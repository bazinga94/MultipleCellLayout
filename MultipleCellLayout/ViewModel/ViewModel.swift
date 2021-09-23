//
//  ViewModel.swift
//  MultipleCellLayout
//
//  Created by Jongho Lee on 2021/09/18.
//

import UIKit

class ViewModel {

	struct ExpandableResponse {
		var header: String
		var footer: String
		var row: [String]
	}

	struct GridResponse {
		var row: [String]
	}

	var sectionControllers: Dynamic<[SectionControllerable]> = .init([])

	func fetch(delegate: ExpandableSectionDelegate) {

		let expandableResponses: [ExpandableResponse] = [
			ExpandableResponse(header: "H 1", footer: "F 1", row: ["1", "2"]),
			ExpandableResponse(header: "H 2", footer: "F 2", row: ["1", "2", "3", "4"]),
			ExpandableResponse(header: "H 3", footer: "F 3", row: ["1", "2", "3"]),
		]

		let gridResponses: [GridResponse] = [
			GridResponse(row: ["1", "123", "12345", "12", "12345678"])
		]

		sectionControllers.value = expandableResponses.enumerated().map { (index, response) in

			let cellConfigurators = response.row.map {
				CellConfigurator<ExpandableCollectionViewCell, ExpandableRowModel>.init(item: ExpandableRowModel(content: $0))
			}

			let expandableSectionController = ExpandableSectionController.init(model: ExpandableSectionModel(headerItem: response.header, footerItem: response.footer, items: cellConfigurators), section: index)

			expandableSectionController.delegate = delegate

			return expandableSectionController

//			return SectionController<ExpandableSectionModel>.init(model: ExpandableSectionModel(headerItem: $0.header, footerItem: $0.footer, items: cellConfigurators))
		}

		let cellConfigurators = gridResponses[0].row.map {
			CellConfigurator<GridCollectionViewCell, GridRowModel>.init(item: GridRowModel(content: $0))
		}

		let gridSectionController = GridSectionController.init(model: GridSectionModel(items: cellConfigurators))

		sectionControllers.value.append(gridSectionController)
	}
}
