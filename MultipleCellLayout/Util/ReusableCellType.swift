//
//  ReusableCellType.swift
//  MultipleCellLayout
//
//  Created by Jongho Lee on 2021/09/18.
//

import UIKit

protocol ReusableCell: class {
	associatedtype CellHolder: ReusableCellHolder // where CellHolder.Cell == Self
}

extension UITableViewCell: ReusableCell {
	typealias CellHolder = UITableView
}

extension UICollectionViewCell: ReusableCell {
	typealias CellHolder = UICollectionView
}

protocol ReusableCellHolder: class {
//	associatedtype Cell: ReusableCell where Cell.CellHolder == Self

	func register(_ nib: UINib?, forCellWithReuseIdentifier identifier: String)
	func register(_ cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String)
//	func dequeueReusableCell(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> Cell
}

extension UITableView: ReusableCellHolder {

	func register(_ nib: UINib?, forCellWithReuseIdentifier identifier: String) {
		register(nib, forCellReuseIdentifier: identifier)
	}

	func register(_ cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String) {
		register(cellClass, forCellReuseIdentifier: identifier)
	}

//	func dequeueReusableCell(withReuseIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
//		return dequeueReusableCell(withIdentifier: identifier, for: indexPath)
//	}
}

extension UICollectionView: ReusableCellHolder {
}
