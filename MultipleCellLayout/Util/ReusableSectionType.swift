//
//  ReusableSectionType.swift
//  MultipleCellLayout
//
//  Created by Jongho Lee on 2021/09/21.
//

import UIKit

protocol SectionView: class {
	associatedtype SectionHolder: SectionViewHolder where SectionHolder.Section == Self
}

protocol SectionViewHolder: class {
	associatedtype Section: SectionView where Section.SectionHolder == Self

	func register(_ viewClass: AnyClass?, forSupplementaryViewOfKind elementKind: String, withReuseIdentifier identifier: String)
	func register(_ nib: UINib?, forSupplementaryViewOfKind kind: String, withReuseIdentifier identifier: String)
	func dequeueReusableSupplementaryView(ofKind elementKind: String, withReuseIdentifier identifier: String, for indexPath: IndexPath) -> Section
}

extension UICollectionReusableView: SectionView {
	typealias SectionHolder = UICollectionView
}

extension UICollectionView: SectionViewHolder {
	typealias Section = UICollectionReusableView
}

extension UITableViewHeaderFooterView: SectionView {
	typealias SectionHolder = UITableView
}

extension UITableView: SectionViewHolder {

	typealias Section = UITableViewHeaderFooterView

	func register(_ viewClass: AnyClass?, forSupplementaryViewOfKind elementKind: String, withReuseIdentifier identifier: String) {
		register(viewClass, forHeaderFooterViewReuseIdentifier: identifier)
	}

	func register(_ nib: UINib?, forSupplementaryViewOfKind kind: String, withReuseIdentifier identifier: String) {
		register(nib, forHeaderFooterViewReuseIdentifier: identifier)
	}

	func dequeueReusableSupplementaryView(ofKind elementKind: String, withReuseIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewHeaderFooterView {
		guard let view = dequeueReusableHeaderFooterView(withIdentifier: identifier) else {
			return UITableViewHeaderFooterView(reuseIdentifier: identifier)
		}
		return view
	}
}
