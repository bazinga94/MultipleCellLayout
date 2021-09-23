//
//  GridHeaderView.swift
//  MultipleCellLayout
//
//  Created by Jongho Lee on 2021/09/23.
//

import UIKit

class GridHeaderView: UICollectionReusableView {
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = .green
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configure(model: ExpandableSectionModel) {

	}
}
