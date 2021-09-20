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
				CellConfigurator<ExpandableCollectionViewCell, ExpandableModel>.init(item: ExpandableModel(content: "첫번째 섹션~")),
				CellConfigurator<ExpandableCollectionViewCell, ExpandableModel>.init(item: ExpandableModel(content: "첫번째 섹션~"))
			],
			[
				CellConfigurator<ExpandableCollectionViewCell, ExpandableModel>.init(item: ExpandableModel(content: "두번째 섹션~")),
				CellConfigurator<ExpandableCollectionViewCell, ExpandableModel>.init(item: ExpandableModel(content: "두번째 섹션~")),
				CellConfigurator<ExpandableCollectionViewCell, ExpandableModel>.init(item: ExpandableModel(content: "두번째 섹션~")),
				CellConfigurator<ExpandableCollectionViewCell, ExpandableModel>.init(item: ExpandableModel(content: "두번째 섹션~")),
				CellConfigurator<ExpandableCollectionViewCell, ExpandableModel>.init(item: ExpandableModel(content: "두번째 섹션~"))
			]
		]
	}
}
