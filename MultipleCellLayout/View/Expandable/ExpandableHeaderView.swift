//
//  ExpandableHeaderView.swift
//  MultipleCellLayout
//
//  Created by Jongho Lee on 2021/09/20.
//

import UIKit

class ExpandableHeaderView: UICollectionReusableView {

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = .yellow
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configure(model: HeaderValue<String>) {
		
	}
}
