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

	static var cellIdentifier: String { get }

	static func registerCellAsXib(on reusableCellHolder: CellHolder)
	static func registerCellAsCustom(on reusableCellHolder: CellHolder)
	func configure(cell: UIView)
}

class CellRegister<CellHolder: ReusableCellHolder>: CellConfigurable {

	class var cellClass: AnyClass {		// override 가능
		fatalError("Must be implemented by children")
	}

	final class var cellIdentifier: String {
		return String(describing: cellClass)
	}

	static func registerCellAsXib(on reusableCellHolder: CellHolder) {
		let bundle = Bundle(for: cellClass)
		let nib = UINib(nibName: cellIdentifier, bundle: bundle)
		reusableCellHolder.register(nib, forCellWithReuseIdentifier: cellIdentifier)
	}

	static func registerCellAsCustom(on reusableCellHolder: CellHolder) {
		reusableCellHolder.register(cellClass, forCellWithReuseIdentifier: cellIdentifier)
	}

	func configure(cell: UIView) {
		// 자식 클래스에서 override하여 구현
	}
}

class CellConfigurator<Cell: ConfigurableCell & ReusableCell, DataType>: CellRegister<Cell.CellHolder> where Cell.DataType == DataType {

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
