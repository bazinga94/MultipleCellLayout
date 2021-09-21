//
//  SectionController.swift
//  MultipleCellLayout
//
//  Created by Jongho Lee on 2021/09/21.
//

import UIKit

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
}

class SectionController<DataType: IterableSectionValue>: SectionControllerable {

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
		return CGSize(width: collectionView.bounds.width, height: 80)
	}
}
