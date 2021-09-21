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
		.backgroundColor(.brown)
		.showsVerticalScrollIndicator(false)
		.apply({
			CellRegister<ExpandableCollectionViewCell, UICollectionView>.registerCellAsCustom(on: $0)
			SectionRegister<ExpandableHeaderView, UICollectionView>.registerHeaderAsCustom(on: $0)
			SectionRegister<ExpandableFooterView, UICollectionView>.registerFooterAsCustom(on: $0)
		})
		.build()

	lazy var collectionViewFlowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
		.builder
		.scrollDirection(.vertical)
		.minimumLineSpacing(30)
		.minimumInteritemSpacing(10)
		.itemSize(CGSize(width: self.view.bounds.width, height: 80))
		.headerReferenceSize(CGSize(width: self.view.bounds.width, height: 60))
		.footerReferenceSize(CGSize(width: self.view.bounds.width, height: 60))
		.build()

	lazy var collectionViewContraints = [
		collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
		collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
		collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
		collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
	]

	let viewModel = ViewModel()

	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.addSubview(collectionView)
		NSLayoutConstraint.activate(collectionViewContraints)
		viewModel.fetch()
	}
}

extension ViewController: UICollectionViewDataSource {
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return self.viewModel.sectionControllers.value.count
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.viewModel.sectionControllers.value[section].rowCount
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		return self.viewModel.sectionControllers.value[indexPath.section].collectionViewCell(collectionView: collectionView, indexPath: indexPath)
	}

	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		if kind == UICollectionView.elementKindSectionHeader {	// 이 부분도 section configurator로 대체 할 수 있을지 확인
			return viewModel.sectionControllers.value[indexPath.section].collectionViewHeader(collectionView: collectionView, indexPath: indexPath, identifier: SectionRegister<ExpandableHeaderView, UICollectionView>.sectionIdentifier)
		} else {
			return viewModel.sectionControllers.value[indexPath.section].collectionViewFooter(collectionView: collectionView, indexPath: indexPath, identifier: SectionRegister<ExpandableFooterView, UICollectionView>.sectionIdentifier)
		}
	}
}

extension ViewController: UICollectionViewDelegate {
}

extension ViewController: ExpandableFooterViewDelegate {
	func didTapFooter(isExpand: Bool) {
		// reloadItems?
	}
}
