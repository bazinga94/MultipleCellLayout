//
//  CellRegister.swift
//  MultipleCellLayout
//
//  Created by Jongho Lee on 2021/09/22.
//

import UIKit

protocol CellRegisterable {
	associatedtype CellHolder: ReusableCellHolder

	static func registerCellAsXib(on reusableCellHolder: CellHolder)
	static func registerCellAsCustom(on reusableCellHolder: CellHolder)
}

class CellRegister<Cell: ReusableCell, CellHolder: ReusableCellHolder>: CellRegisterable {

	final class var cellClass: AnyClass {
		return Cell.self
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
}
