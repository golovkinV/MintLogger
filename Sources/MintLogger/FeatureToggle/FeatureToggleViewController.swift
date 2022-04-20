//
//  FeatureToggleViewController.swift
//  
//
//  Created by Vladimir Golovkin on 17.12.2021.
//

import UIKit
import SnapKit

public final class FeatureToggleViewController: UIViewController {
    
    private var bag = CancelBag()
    
    let viewModel: FeatureToggleViewModel = .init()
    
    public private(set) var items: [Feature] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    public private(set) lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout().apply {
            $0.itemSize = .init(width: UIScreen.main.bounds.width, height: 48)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).apply {
            $0.backgroundColor = .white
            $0.dataSource = self
            $0.delegate = self
            $0.register(of: FeatureSwitchCell.self)
            $0.register(of: ContextCell.self)
        }
        return collectionView
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setUpBindings()
        viewModel.input.didLoad.send(())
    }
    
    // MARK: - SetUp Bindings
    
    private func setupViews() {
        title = "Features"
        view.backgroundColor = .white
        view.addSubview(collectionView)
        layoutConstraints()
    }
    
    private func layoutConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setUpBindings() {
        bindViewToViewModel()
        bindViewModelToView()
    }
    
    func bindViewToViewModel() {}
    
    func bindViewModelToView() {
        viewModel.output.$items
            .sink(receiveValue: { [weak self] in
                self?.items = $0
            })
            .store(in: &bag)
    }
}

extension FeatureToggleViewController: UICollectionViewDataSource {
    
    public func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return items.count
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let item = items[indexPath.item]
        switch item.type {
        case .switch:
            let cell = collectionView.dequeueReusableCell(of: FeatureSwitchCell.self, at: indexPath)
            return cell.setDelegate(self).configure(item)
        case .contextMenu:
            let cell = collectionView.dequeueReusableCell(of: ContextCell.self, at: indexPath)
            return cell.configure(item)
        }
    }
}

extension FeatureToggleViewController: UICollectionViewDelegate {
    public func collectionView(
        _ collectionView: UICollectionView,
        contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint
    ) -> UIContextMenuConfiguration? {
        let item = items[indexPath.item]
        return configureContextMenu(feature: item)
    }

    private func configureContextMenu(feature: Feature) -> UIContextMenuConfiguration? {
        guard case let .contextMenu(items) = feature.type, !items.isEmpty else { return nil }
        var changeFeature = feature

        let validToggleValue = fetchValidValue(for: feature, items: items)
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (action) -> UIMenu? in
            var actions: [UIAction] = []
            items.forEach { item in

                let state: UIMenu.State = item.toggleValue == validToggleValue ? .on: .off

                let action: UIAction = .init(title: item.title, state: state) { [weak self] _ in
                    changeFeature.toggleValue = item.toggleValue
                    self?.viewModel.changeFeatureToggleValue(changeFeature)
                    item.didSelected?()
                }
                actions.append(action)
            }

            return UIMenu(
                title: "Options",
                image: nil,
                identifier: nil,
                options: UIMenu.Options.displayInline,
                children: actions
            )
        }
    }

    private func fetchValidValue(for feature: Feature, items: [ContextMenuItem]) -> String? {

        if let savedToggleValue = FeatureToggleProvider.shared.fetchToggleValue(for: feature.key) {
            return savedToggleValue
        }

        var changingFeature = feature
        let defaultItem = items.first(where: { $0.isDefault })
        let firstValue = defaultItem?.toggleValue ?? items.first?.toggleValue
        changingFeature.toggleValue = firstValue
        viewModel.changeFeatureToggleValue(changingFeature)

        return firstValue
    }
}

extension FeatureToggleViewController: FeatureDelegate {
    public func changeState(_ model: Feature?) {
        guard let model = model else { return }
        viewModel.changeFeatureState(model)
    }
}
