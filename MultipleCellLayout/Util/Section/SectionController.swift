//
//  SectionController.swift
//  MultipleCellLayout
//
//  Created by Jongho Lee on 2021/09/21.
//

import UIKit

protocol HeaderValue {
	associatedtype Model
	var headerItem: Model { get set }
}

protocol FooterValue {
	associatedtype Model
	var footerItem: Model { get set }
}

protocol IterableSectionValue {
//	associatedtype Model: CellConfigurable
	var items: [CellConfigurable] { get set }
}

protocol SectionControllerable {
//	associatedtype Model: IterableSectionValue

//	init(model: Model)

//	var model: Dynamic<Model> { get set }
	var rowCount: Int { get }
	func collectionViewCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
	func collectionViewCellSize(collectionView: UICollectionView, indexPath: IndexPath) -> CGSize
	func collectionViewHeader(collectionView: UICollectionView, indexPath: IndexPath, identifier: String) -> UICollectionReusableView
	func collectionViewFooter(collectionView: UICollectionView, indexPath: IndexPath, identifier: String) -> UICollectionReusableView
}

class SectionController<DataType: IterableSectionValue & HeaderValue & FooterValue>: SectionControllerable {

	var rowCount: Int {
		return model.value.items.count
	}

	private var model: Dynamic<DataType>

	required init(model: DataType) {
		self.model = .init(model)
		self.model.bind { model in
			// reload
		}
	}

	func collectionViewCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
		let configurator = self.model.value.items[indexPath.row]
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: type(of: configurator).cellIdentifier, for: indexPath)
		configurator.configure(cell: cell)

		return cell
	}

	func collectionViewCellSize(collectionView: UICollectionView, indexPath: IndexPath) -> CGSize {
		return CGSize(width: collectionView.bounds.width, height: 80)	// 임시
	}

	func collectionViewHeader(collectionView: UICollectionView, indexPath: IndexPath, identifier: String) -> UICollectionReusableView {
		guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: identifier, for: indexPath) as? ExpandableHeaderView else { return UICollectionReusableView() }
//		view.configure(model: model.value)	// Header 나 Footer를 configure 할 모델을 Generic으로 받아야 할까?
		return view
	}

	func collectionViewFooter(collectionView: UICollectionView, indexPath: IndexPath, identifier: String) -> UICollectionReusableView {
		return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: identifier, for: indexPath)
	}
}
