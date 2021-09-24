//
//  ExpandableHeaderView.swift
//  MultipleCellLayout
//
//  Created by Jongho Lee on 2021/09/20.
//

import UIKit

class ExpandableHeaderView: UICollectionReusableView {

	lazy var headerLabel: UILabel = UILabel()
		.builder
		.translatesAutoresizingMaskIntoConstraints(false)
		.build()

	lazy var headerLabelConstraints = [
		headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
		headerLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5)
	]

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = .yellow
		self.addSubview(headerLabel)
		NSLayoutConstraint.activate(headerLabelConstraints)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configure(model: ExpandableSectionModel) {
		headerLabel.text = model.headerItem
	}
}
