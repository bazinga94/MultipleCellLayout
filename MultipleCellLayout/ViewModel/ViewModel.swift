//
//  ViewModel.swift
//  MultipleCellLayout
//
//  Created by Jongho Lee on 2021/09/18.
//

import UIKit

class ViewModel {

	var items: Dynamic<[[CellRegister<UICollectionView>]]> = .init([])

	func fetch() {
		items.value = [
			[
				CellConfigurator<ExpandableCollectionViewCell, ExpandableModel>.init(item: ExpandableModel(content: "1-1")),
				CellConfigurator<ExpandableCollectionViewCell, ExpandableModel>.init(item: ExpandableModel(content: "1-2"))
			],
			[
				CellConfigurator<ExpandableCollectionViewCell, ExpandableModel>.init(item: ExpandableModel(content: "2-1")),
				CellConfigurator<ExpandableCollectionViewCell, ExpandableModel>.init(item: ExpandableModel(content: "2-2")),
				CellConfigurator<ExpandableCollectionViewCell, ExpandableModel>.init(item: ExpandableModel(content: "2-3")),
				CellConfigurator<ExpandableCollectionViewCell, ExpandableModel>.init(item: ExpandableModel(content: "2-4")),
				CellConfigurator<ExpandableCollectionViewCell, ExpandableModel>.init(item: ExpandableModel(content: "2-5"))
			]
		]
	}
}
