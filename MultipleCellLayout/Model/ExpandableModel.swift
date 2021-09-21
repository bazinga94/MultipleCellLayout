//
//  ExpandableModel.swift
//  MultipleCellLayout
//
//  Created by Jongho Lee on 2021/09/18.
//

import Foundation

struct ExpandableSectionModel: IterableSectionValue {

	var headerTitle: String
	var footerTitle: String
	var items: [CellConfigurable]
}

struct ExpandableRowModel {
	var content: String
}
