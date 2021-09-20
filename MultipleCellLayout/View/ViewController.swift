//
//  ViewController.swift
//  MultipleCellLayout
//
//  Created by Jongho Lee on 2021/09/18.
//

import UIKit

class ViewController: UIViewController {

	lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
		.builder
		.translatesAutoresizingMaskIntoConstraints(false)
		.delegate(self)
		.dataSource(self)
		.backgroundColor(.clear)
		.showsVerticalScrollIndicator(false)
		.apply({
			CollectionCellConfigurator<ExpandableCollectionViewCell, ExpandableModel>.registerCellAsCustom(on: $0)
		})
		.build()

	lazy var collectionViewFlowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
		.builder
		.scrollDirection(.vertical)
		.build()

	lazy var collectionViewContraints = [
		collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
		collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
		collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
		collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
	]

	let viewModel = ViewModel()

	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.addSubview(collectionView)
		NSLayoutConstraint.activate(collectionViewContraints)
	}
}

extension ViewController: UICollectionViewDataSource {
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.viewModel.items.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let configurator = self.viewModel.items[indexPath.row]
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: type(of: configurator).cellIdentifier, for: indexPath)
		configurator.configure(cell: cell)

		return cell
	}
}

extension ViewController: UICollectionViewDelegate {

}
