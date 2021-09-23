//
//  ExpandableModel.swift
//  MultipleCellLayout
//
//  Created by Jongho Lee on 2021/09/18.
//

import Foundation

struct ExpandableSectionModel {

	var headerItem: String
	var footerItem: String
	var items: [ExpandableRowModel]
}

struct ExpandableRowModel {
	var content: String
}
