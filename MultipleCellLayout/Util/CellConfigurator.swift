//
//  CellConfigurator.swift
//  MultipleCellLayout
//
//  Created by Jongho Lee on 2021/09/18.
//

import UIKit

protocol CellConfigurator {
	associatedtype CellHolder: ReusableCellHolder
	associatedtype Cell: ConfigurableCell

	static func registerCell(on reusableCellHolder: CellHolder)
	func configure(cell: Cell)
}

class CollectionCellConfigurator<Cell: ConfigurableCell, CellHolder: ReusableCellHolder, DataType>: CellConfigurator where Cell.DataType == DataType, Cell: UICollectionViewCell {

	final class var cellIdentifier: String {
		return String(describing: Cell.self)
	}

	final class var cellClass: AnyClass {
		return Cell.self
	}

	let item: DataType

	init(item: DataType) {
		self.item = item
	}

	static func registerCell(on reusableCellHolder: CellHolder) {
		let bundle = Bundle(for: cellClass)
		let nib = UINib(nibName: cellIdentifier, bundle: bundle)
		reusableCellHolder.register(nib, forCellWithReuseIdentifier: cellIdentifier)
	}

	func configure(cell: Cell) {
		cell.configure(data: item)
	}
}
