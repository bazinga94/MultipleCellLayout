//
//  ViewModel.swift
//  MultipleCellLayout
//
//  Created by Jongho Lee on 2021/09/18.
//

import UIKit

class ViewModel {

	var items: Dynamic<[[CellConfigurator<UICollectionView>]]> = .init([])

	func fetch() {
		items.value = [
			[
				CollectionCellConfigurator<ExpandableCollectionViewCell, ExpandableModel>.init(item: ExpandableModel(content: "첫번째 내용~")),
				CollectionCellConfigurator<ExpandableCollectionViewCell, ExpandableModel>.init(item: ExpandableModel(content: "두번째 내용~"))
			],
			[
				CollectionCellConfigurator<ExpandableCollectionViewCell, ExpandableModel>.init(item: ExpandableModel(content: "세번째 내용~"))
			]
		]
	}
}
