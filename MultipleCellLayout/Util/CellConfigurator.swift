//
//  CellConfigurator.swift
//  MultipleCellLayout
//
//  Created by Jongho Lee on 2021/09/18.
//

import UIKit

protocol CellConfigurable {
	associatedtype CellHolder: ReusableCellHolder
//	associatedtype Cell: ConfigurableCell
//	associatedtype Cell: ReusableCell

	static func registerCell(on reusableCellHolder: CellHolder)
	func configure(cell: UIView)
}

class CellConfigurator<CellHolder: ReusableCellHolder>: CellConfigurable {

	class var cellClass: AnyClass {		// override 가능
		fatalError("Must be implemented by children")
	}

	final class var cellIdentifier: String {
		return String(describing: cellClass)
	}

	static func registerCell(on reusableCellHolder: CellHolder) {
		let bundle = Bundle(for: cellClass)
		let nib = UINib(nibName: cellIdentifier, bundle: bundle)
		reusableCellHolder.register(nib, forCellWithReuseIdentifier: cellIdentifier)
	}

	func configure(cell: UIView) {
		// 자식 클래스에서 override하여 구현
	}
}

class CollectionCellConfigurator<Cell: ConfigurableCell & ReusableCell, DataType>: CellConfigurator<Cell.CellHolder> where Cell.DataType == DataType {

	final class override var cellClass: AnyClass {
		return Cell.self
	}

	let item: DataType

	init(item: DataType) {
		self.item = item
	}

//	static func registerCell(on reusableCellHolder: CellHolder) {
//		let bundle = Bundle(for: cellClass)
//		let nib = UINib(nibName: cellIdentifier, bundle: bundle)
//		reusableCellHolder.register(nib, forCellWithReuseIdentifier: cellIdentifier)
//	}

	override func configure(cell: UIView) {
		(cell as! Cell).configure(data: item)
	}
}
