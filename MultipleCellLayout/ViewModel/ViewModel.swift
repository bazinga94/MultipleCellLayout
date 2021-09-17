//
//  ViewModel.swift
//  MultipleCellLayout
//
//  Created by Jongho Lee on 2021/09/18.
//

import UIKit

class ViewModel {
	let items: [CellConfigurator] = [
		CollectionCellConfigurator<ExpandableCollectionViewCell, UICollectionView, ExpandableModel>.init(item: ExpandableModel(content: "첫번째 내용~"))
	]
}
