//
//  ViewModel.swift
//  MultipleCellLayout
//
//  Created by Jongho Lee on 2021/09/18.
//

import UIKit

class ViewModel {

	struct Response {
		var header: String
		var footer: String
		var row: [String]
	}

	var sectionControllers: Dynamic<[SectionControllerable]> = .init([])

	func fetch() {

		let responses: [Response] = [
			Response(header: "H 1", footer: "F 1", row: ["1", "2"]),
			Response(header: "H 2", footer: "F 2", row: ["1", "2", "3", "4"]),
			Response(header: "H 3", footer: "F 3", row: ["1", "2", "3"]),
		]

		sectionControllers.value = responses.map {

			let cellConfigurators = $0.row.map {
				CellConfigurator<ExpandableCollectionViewCell, ExpandableRowModel>.init(item: ExpandableRowModel(content: $0))
			}

			return SectionController<ExpandableSectionModel>.init(model: ExpandableSectionModel(headerTitle: $0.header, footerTitle: $0.footer, items: cellConfigurators))
		}
	}
}
