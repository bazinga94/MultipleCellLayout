//
//  GridSectionController.swift
//  MultipleCellLayout
//
//  Created by Jongho Lee on 2021/09/23.
//

import UIKit

class GridSectionController: SectionControllerable {
	var rowCount: Int {
		return model.value.items.count
	}

	private var model: Dynamic<GridSectionModel>

	init(model: GridSectionModel) {
		self.model = .init(model)
		self.model.bind { model in
			// reload
		}
	}

	func collectionViewCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
		let configurator = CellConfigurator<GridCollectionViewCell, GridRowModel>.init(item: self.model.value.items[indexPath.row]) //self.model.value.items[indexPath.row]
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: type(of: configurator).cellIdentifier, for: indexPath)
		configurator.configure(cell: cell)

		return cell
	}

	func collectionViewCellSize(collectionView: UICollectionView, indexPath: IndexPath) -> CGSize {
		// 1안... 근데 모델을 여기서 접근 못함
		let item = model.value.items[indexPath.row].content
		var itemSize = item.size(withAttributes: [
			NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)
		])
		itemSize.width += 20
		return itemSize
//		return CGSize(width: collectionView.bounds.width/5, height: 20)
	}

	func collectionViewHeader(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionReusableView {
		guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionRegister<GridHeaderView, UICollectionView>.sectionIdentifier, for: indexPath) as? GridHeaderView else { return UICollectionReusableView() }
		return view
	}

	func collectionViewFooter(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionReusableView {
		guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: SectionRegister<GridFooterView, UICollectionView>.sectionIdentifier, for: indexPath) as? GridFooterView else { return UICollectionReusableView() }
		return view
	}

	func collectionViewHeaderSize(collectionView: UICollectionView) -> CGSize {
		return CGSize(width: collectionView.bounds.width, height: 10)
	}

	func collectionViewFooterSize(collectionView: UICollectionView) -> CGSize {
		return CGSize(width: collectionView.bounds.width, height: 10)
	}
}
