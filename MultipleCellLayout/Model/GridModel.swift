//
//  GridModel.swift
//  MultipleCellLayout
//
//  Created by Jongho Lee on 2021/09/23.
//

import Foundation

struct GridSectionModel: IterableSectionValue {
	var items: [CellConfigurable]
}

struct GridRowModel {
	var content: String
}
