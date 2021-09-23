//
//  GridCollectionViewCell.swift
//  MultipleCellLayout
//
//  Created by Jongho Lee on 2021/09/23.
//

import UIKit

class GridCollectionViewCell: UICollectionViewCell, ConfigurableCell {

	lazy var contentLabel: UILabel = UILabel()
		.builder
		.translatesAutoresizingMaskIntoConstraints(false)
		.build()

	lazy var contentLabelConstraints = [
		contentLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
		contentLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
	]

	func configure(data: GridRowModel) {
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

//	lazy var collectionView: UICollectionView = UICollectionView(frame: .zero)
//		.builder
//		.translatesAutoresizingMaskIntoConstraints(false)
//		.delegate(self)
//		.dataSource(self)
//		.backgroundColor(.white)
//		.showsVerticalScrollIndicator(false)
//		.apply({
////			CellRegister<GridCollectionViewCell, UICollectionView>.registerCellAsCustom(on: $0)
//		})
//		.build()
}

//extension GridCollectionViewCell: UICollectionViewDataSource {
//	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//		<#code#>
//	}
//
//	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//		<#code#>
//	}
//}
//
//extension GridCollectionViewCell: UICollectionViewDelegateFlowLayout {
//
//}
