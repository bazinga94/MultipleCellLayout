//
//  CellConfigurator.swift
//  MultipleCellLayout
//
//  Created by Jongho Lee on 2021/09/18.
//

import UIKit

protocol CellConfigurable {
//	associatedtype CellHolder: ReusableCellHolder
//	associatedtype Cell: ConfigurableCell
//	associatedtype Cell: ReusableCell

	static var cellIdentifier: String { get }

//	static func registerCellAsXib(on reusableCellHolder: CellHolder)
//	static func registerCellAsCustom(on reusableCellHolder: CellHolder)
	func configure(cell: UIView)
}

class CellConfigurator<Cell: ConfigurableCell & ReusableCell, DataType>: CellConfigurable where Cell.DataType == DataType {

	final class var cellClass: AnyClass {
		return Cell.self
	}

	final class var cellIdentifier: String {
		return String(describing: cellClass)
	}

	let item: DataType

	init(item: DataType) {
		self.item = item
	}

	func configure(cell: UIView) {
		(cell as! Cell).configure(data: item)
	}
}
