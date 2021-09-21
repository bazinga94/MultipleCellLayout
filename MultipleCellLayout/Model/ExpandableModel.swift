//
//  ExpandableModel.swift
//  MultipleCellLayout
//
//  Created by Jongho Lee on 2021/09/18.
//

import Foundation

struct ExpandableSectionModel: IterableSectionValue, HeaderValue, FooterValue {

	var headerItem: String
	var footerItem: String
	var items: [CellConfigurable]
}

struct ExpandableRowModel {
	var content: String
}
