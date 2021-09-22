//
//  ExpandableSectionController.swift
//  MultipleCellLayout
//
//  Created by Jongho Lee on 2021/09/22.
//

import UIKit

protocol ExpandableSectionDelegate: class {
	func sectionReload(isExpand: Bool, section: Int)
}

class ExpandableSectionController: SectionControllerable {

	private var section: Int

	var rowCount: Int {
		return _rowCount
	}

	private var _rowCount: Int = 0

	private var isExpand: Bool {
		didSet {
			if isExpand {
				_rowCount = model.value.items.count
			} else {
				_rowCount = 0
			}
		}
	}

	internal var model: Dynamic<ExpandableSectionModel>

	weak var delegate: ExpandableSectionDelegate?

	required init(model: ExpandableSectionModel, section: Int) {
		self.model = .init(model)
		self.model.bind { model in
			// reload
		}
		self.section = section
		self.isExpand = true
	}

	func collectionViewCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
		let configurator = self.model.value.items[indexPath.row]
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: type(of: configurator).cellIdentifier, for: indexPath)
		configurator.configure(cell: cell)

		return cell
	}

	func collectionViewCellSize(collectionView: UICollectionView, indexPath: IndexPath) -> CGSize {
		return CGSize(width: collectionView.bounds.width, height: 80)
	}

	func collectionViewHeader(collectionView: UICollectionView, indexPath: IndexPath, identifier: String) -> UICollectionReusableView {
		guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: identifier, for: indexPath) as? ExpandableHeaderView else { return UICollectionReusableView() }
		view.configure(model: model.value)
		return view
	}

	func collectionViewFooter(collectionView: UICollectionView, indexPath: IndexPath, identifier: String) -> UICollectionReusableView {
		guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: identifier, for: indexPath) as? ExpandableFooterView else { return UICollectionReusableView() }
			view.configure(model: model.value)
		view.delegate = self
		return view
	}
}

extension ExpandableSectionController: ExpandableFooterViewDelegate {
	func didTapFooter(isExpand: Bool) {
		self.isExpand = isExpand
		delegate?.sectionReload(isExpand: isExpand, section: section)
	}
}
