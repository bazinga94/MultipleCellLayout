//
//  ExpandableFooterView.swift
//  MultipleCellLayout
//
//  Created by Jongho Lee on 2021/09/20.
//

import UIKit

protocol ExpandableFooterViewDelegate: class {
	func didTapFooter(isExpand: Bool)
}

class ExpandableFooterView: UICollectionReusableView {

	private var isExpand: Bool = true

	weak var delegate: ExpandableFooterViewDelegate?

	lazy var footerButton: UIButton = UIButton()
		.builder
		.translatesAutoresizingMaskIntoConstraints(false)
		.build()

	lazy var footerButtonConstraints = [
		footerButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
		footerButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
		footerButton.topAnchor.constraint(equalTo: self.topAnchor),
		footerButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
	]

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = .red
		self.addSubview(footerButton)
		NSLayoutConstraint.activate(footerButtonConstraints)
		footerButton.addTarget(self, action: #selector(didTapFooter(sender:)), for: .touchUpInside)
	}

	@objc func didTapFooter(sender: UIButton) {
		delegate?.didTapFooter(isExpand: !isExpand)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configure(model: ExpandableSectionModel) {

	}
}
