//
//  PublishedProperty.swift
//  
//
//  Created by Vladimir Golovkin on 20.12.2021.
//

import Foundation
import Combine

typealias CancelBag = Set<AnyCancellable>

extension CancelBag {
    mutating func collect(@Builder _ cancellables: () -> [AnyCancellable]) {
        formUnion(cancellables())
    }

    @resultBuilder
    struct Builder {
        static func buildBlock(_ cancellables: AnyCancellable...) -> [AnyCancellable] {
            return cancellables
        }
    }
    
    func cancel() {
        self.forEach { $0.cancel() }
    }
}

@propertyWrapper
struct PublishedProperty<Value> {
    private let subject = PassthroughSubject<Value, Never>()
    public var wrappedValue: Value {
        didSet {
            subject.send(wrappedValue)
        }
    }
    
    public var projectedValue: AnyPublisher<Value, Never> {
        subject.eraseToAnyPublisher()
    }
    
    public init(wrappedValue: Value = ()) where Value == Void {
        self.wrappedValue = wrappedValue
    }
    
    public init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
    }
}

struct PublishedAction<Value> {
    private var subject = PassthroughSubject<Value, Never>()
    public var publisher: AnyPublisher<Value, Never> {
        subject.eraseToAnyPublisher()
    }
    
    public func send(_ value: Value) {
        subject.send(value)
    }
    
    public func send(_ value: Value = ()) where Value == Void {
        subject.send(value)
    }
}
