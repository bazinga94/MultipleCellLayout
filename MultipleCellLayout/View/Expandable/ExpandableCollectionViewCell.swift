//
//  ExpandableCollectionViewCell.swift
//  MultipleCellLayout
//
//  Created by Jongho Lee on 2021/09/18.
//

import UIKit

class ExpandableCollectionViewCell: UICollectionViewCell, ConfigurableCell {

	lazy var contentLabel: UILabel = UILabel()
		.builder
		.translatesAutoresizingMaskIntoConstraints(false)
		.build()

	lazy var contentLabelConstraints = [
		contentLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
		contentLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
	]

	func configure(data: ExpandableRowModel) {
		contentLabel.text = data.content
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.addSubview(contentLabel)
		self.backgroundColor = .orange
		NSLayoutConstraint.activate(contentLabelConstraints)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

//	override func awakeFromNib() {
//		super.awakeFromNib()
//		self.addSubview(contentLabel)
//		NSLayoutConstraint.activate(contentLabelConstraints)
//	}	// xib를 사용안하면 의미 없음..
}
