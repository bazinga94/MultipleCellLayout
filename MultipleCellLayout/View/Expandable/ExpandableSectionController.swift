//
//  ExpandableSectionController.swift
//  MultipleCellLayout
//
//  Created by Jongho Lee on 2021/09/22.
//

import UIKit

protocol ExpandableSectionDelegate: class {
	func sectionReload(isExpand: Bool, indexPaths: [IndexPath])
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

	private var model: Dynamic<ExpandableSectionModel>

	weak var delegate: ExpandableSectionDelegate?

	init(model: ExpandableSectionModel, section: Int) {
		self.model = .init(model)
		self.model.bind { model in
			// reload
		}
		self.section = section
		self.isExpand = true //true / false
		self._rowCount = self.model.value.items.count // self.model.value.items.count / 0
	}

	func collectionViewCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
		let configurator = CellConfigurator<ExpandableCollectionViewCell, ExpandableRowModel>.init(item: self.model.value.items[indexPath.row])
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: type(of: configurator).cellIdentifier, for: indexPath)
		configurator.configure(cell: cell)

		return cell
	}

	func collectionViewCellSize(collectionView: UICollectionView, indexPath: IndexPath) -> CGSize {
		return CGSize(width: collectionView.bounds.width, height: 80)
	}

	func collectionViewHeader(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionReusableView {
		guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionRegister<ExpandableHeaderView, UICollectionView>.sectionIdentifier, for: indexPath) as? ExpandableHeaderView else { return UICollectionReusableView() }
		view.configure(model: model.value)
		return view
	}

	func collectionViewFooter(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionReusableView {
		guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: SectionRegister<ExpandableFooterView, UICollectionView>.sectionIdentifier, for: indexPath) as? ExpandableFooterView else { return UICollectionReusableView() }
			view.configure(model: model.value)
		view.delegate = self
		view.isExpand = isExpand
		return view
	}

	func collectionViewHeaderSize(collectionView: UICollectionView) -> CGSize {
		return CGSize(width: collectionView.bounds.width, height: 60)
	}

	func collectionViewFooterSize(collectionView: UICollectionView) -> CGSize {
		return CGSize(width: collectionView.bounds.width, height: 60)
	}
}

extension ExpandableSectionController: ExpandableFooterViewDelegate {
	func didTapFooter(isExpand: Bool) {
		self.isExpand = isExpand
		let indexPaths = (0..<model.value.items.count).map { IndexPath(row: $0, section: section) }
		delegate?.sectionReload(isExpand: isExpand, indexPaths: indexPaths)
	}
}
