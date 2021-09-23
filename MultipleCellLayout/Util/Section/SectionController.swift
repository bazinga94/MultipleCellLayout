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
// 위에 두개는 option...

protocol IterableSectionValue {
//	associatedtype Model: CellConfigurable
	var items: [CellConfigurable] { get set }
}

protocol SectionControllerable {
//	associatedtype Model: IterableSectionValue

//	init(model: Model)

//	var model: Dynamic<Model> { get set }

//	init(model: IterableSectionValue)

//	var model: Dynamic<IterableSectionValue> { get set }

	var rowCount: Int { get }

	func collectionViewCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
	func collectionViewCellSize(collectionView: UICollectionView, indexPath: IndexPath) -> CGSize
	func collectionViewHeader(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionReusableView
	func collectionViewHeaderSize(collectionView: UICollectionView) -> CGSize
	func collectionViewFooter(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionReusableView
	func collectionViewFooterSize(collectionView: UICollectionView) -> CGSize
}

extension SectionControllerable {
//	func collectionViewCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
//		let configurator = self.model.value.items[indexPath.row]
//		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: type(of: configurator).cellIdentifier, for: indexPath)
//		configurator.configure(cell: cell)
//
//		return cell
//	}
}

// Sample!! 프로토콜을 상속 받게 하자~
class SectionController<DataType: IterableSectionValue & HeaderValue & FooterValue>: SectionControllerable {

	required init(model: IterableSectionValue) {
		self.model = .init(model)
	}

	var model: Dynamic<IterableSectionValue>


	var rowCount: Int {
		return model.value.items.count
	}

//	internal var model: Dynamic<DataType>
//
//	required init(model: DataType) {
//		self.model = .init(model)
//		self.model.bind { model in
//			// reload
//		}
//	}

	func collectionViewCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
		let configurator = self.model.value.items[indexPath.row]
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: type(of: configurator).cellIdentifier, for: indexPath)
		configurator.configure(cell: cell)

		return cell
	}

	func collectionViewCellSize(collectionView: UICollectionView, indexPath: IndexPath) -> CGSize {
		return CGSize(width: collectionView.bounds.width, height: 80)	// 임시
	}

	func collectionViewHeader(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionReusableView {
		return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "identifier", for: indexPath)
	}

	func collectionViewFooter(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionReusableView {
		return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "identifier", for: indexPath)
	}

	func collectionViewHeaderSize(collectionView: UICollectionView) -> CGSize {
		return CGSize(width: collectionView.bounds.width, height: 60)
	}

	func collectionViewFooterSize(collectionView: UICollectionView) -> CGSize {
		return CGSize(width: collectionView.bounds.width, height: 60)
	}
}
