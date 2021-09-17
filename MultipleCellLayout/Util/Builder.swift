//
//  Builder.swift
//  MultipleCellLayout
//
//  Created by Jongho Lee on 2021/09/18.
//

import Foundation

@dynamicMemberLookup
public struct Builder<Base: AnyObject> {

	private var base: Base

	public init(_ base: Base) {
		self.base = base
	}

	public subscript<Value>(dynamicMember keyPath: ReferenceWritableKeyPath<Base, Value>) -> (Value) -> Builder<Base> {
		{ [base] value in
			base[keyPath: keyPath] = value
			return Builder(base)
		}
	}

	// ???
	public func set<Value>(_ keyPath: ReferenceWritableKeyPath<Base, Value>, to value: Value) -> Builder<Base> {
		base[keyPath: keyPath] = value
		return Builder(base)
	}

	public func apply(_ completion: @escaping (Base) -> Void) -> Builder<Base> {
		completion(base)
		return Builder(base)
	}

	public func build() -> Base {
		return base
	}
}

public protocol Buildable {
	//	associatedtype Base: AnyObject
	//	var builder: Builder<AnyObject> { get set }
}

public extension Buildable where Self: AnyObject {
	var builder: Builder<Self> {
		return Builder(self)
	}
}

extension NSObject: Buildable {
}
