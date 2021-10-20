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
//			ExpandableResponse(header: "H 1", footer: "F 1", row: ["1", "2"]),
//			ExpandableResponse(header: "H 2", footer: "F 2", row: ["1", "2", "3", "4"]),
//			ExpandableResponse(header: "H 3", footer: "F 3", row: ["1", "2", "3"]),
//			ExpandableResponse(header: "H 1", footer: "F 1", row: ["1", "2"]),
//			ExpandableResponse(header: "H 2", footer: "F 2", row: ["1", "2", "3", "4"]),
//			ExpandableResponse(header: "H 3", footer: "F 3", row: ["1", "2", "3"])
			ExpandableResponse(header: "H 0", footer: "F 0", row: ["1"]),
			ExpandableResponse(header: "H 1", footer: "F 1", row: ["1"]),
			ExpandableResponse(header: "H 2", footer: "F 2", row: ["1"]),
			ExpandableResponse(header: "H 3", footer: "F 3", row: ["1"]),
			ExpandableResponse(header: "H 4", footer: "F 4", row: ["1"]),
			ExpandableResponse(header: "H 5", footer: "F 5", row: ["1"]),
			ExpandableResponse(header: "H 6", footer: "F 6", row: ["1"]),
			ExpandableResponse(header: "H 7", footer: "F 7", row: ["1"]),
			ExpandableResponse(header: "H 8", footer: "F 8", row: ["1"]),
			ExpandableResponse(header: "H 9", footer: "F 9", row: ["1"]),
			ExpandableResponse(header: "H 10", footer: "F 10", row: ["1"]),
			ExpandableResponse(header: "H 11", footer: "F 11", row: ["1"]),
			ExpandableResponse(header: "H 12", footer: "F 12", row: ["1"]),
			ExpandableResponse(header: "H 13", footer: "F 13", row: ["1"]),
			ExpandableResponse(header: "H 14", footer: "F 14", row: ["1"]),
		]

		let gridResponses: [GridResponse] = [
			GridResponse(row: ["1", "123", "12345", "12", "12345678", "1231241241", "1231", "1241233", "11", "2", "21344", "1234", "123"])
		]

		sectionControllers.value = expandableResponses.enumerated().map { (index, response) in

//			let cellConfigurators = response.row.map {
//				CellConfigurator<ExpandableCollectionViewCell, ExpandableRowModel>.init(item: ExpandableRowModel(content: $0))
//			}
			let expandableRowModel = response.row.map {
				ExpandableRowModel(content: $0)
			}

			let expandableSectionController = ExpandableSectionController.init(model: ExpandableSectionModel(headerItem: response.header, footerItem: response.footer, items: expandableRowModel), section: index)

			expandableSectionController.delegate = delegate

			return expandableSectionController

//			return SectionController<ExpandableSectionModel>.init(model: ExpandableSectionModel(headerItem: $0.header, footerItem: $0.footer, items: cellConfigurators))
		}

//		let cellConfigurators = gridResponses[0].row.map {
//			CellConfigurator<GridCollectionViewCell, GridRowModel>.init(item: GridRowModel(content: $0))
//		}
		let gridRowModel = gridResponses[0].row.map {
			GridRowModel(content: $0)
		}

		let gridSectionController = GridSectionController.init(model: GridSectionModel(items: gridRowModel))

		sectionControllers.value.append(gridSectionController)
	}
}
