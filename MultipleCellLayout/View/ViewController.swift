//
//  ViewController.swift
//  MultipleCellLayout
//
//  Created by Jongho Lee on 2021/09/18.
//

import UIKit

class ViewController: UIViewController {

//	private var isSectionCellAnimatedList: [IndexPath] = []
	private var isSectionCellAnimatedList: [Int] = []

//	private var isSectionViewAnimatedList: [IndexPath] = []
	private var isSectionViewAnimatedList: [Int] = []

	private var visibleLastSection: Int = 0

	private var startDragging: Bool = false

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
			CellRegister<GridCollectionViewCell, UICollectionView>.registerCellAsCustom(on: $0)
			SectionRegister<GridHeaderView, UICollectionView>.registerHeaderAsCustom(on: $0)
			SectionRegister<GridFooterView, UICollectionView>.registerFooterAsCustom(on: $0)
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
		viewModel.fetch(delegate: self)
		print(collectionView.visibleCells)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		print(collectionView.visibleCells)
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		print(collectionView.visibleCells)
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
			return viewModel.sectionControllers.value[indexPath.section].collectionViewHeader(collectionView: collectionView, indexPath: indexPath)
		} else {
			return viewModel.sectionControllers.value[indexPath.section].collectionViewFooter(collectionView: collectionView, indexPath: indexPath)
		}	// header, footer 관리 어떻게?
	}
}

extension ViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return viewModel.sectionControllers.value[indexPath.section].collectionViewCellSize(collectionView: collectionView, indexPath: indexPath)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		return viewModel.sectionControllers.value[section].collectionViewHeaderSize(collectionView: collectionView)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
		return viewModel.sectionControllers.value[section].collectionViewFooterSize(collectionView: collectionView)
	}
}

extension ViewController: UICollectionViewDelegate {

	func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {

		print("section", indexPath, elementKind)
//		if elementKind == UICollectionView.elementKindSectionHeader {
//			return
//		}

		if startDragging {
			view.alpha = 0.05
			let transform = CATransform3DTranslate(CATransform3DIdentity, 0, 20, 0)
			view.layer.transform = transform

			let delay = 1.0

			UIView.animate(withDuration: 2, delay: delay, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseOut, .allowUserInteraction], animations: {
				view.alpha = 1
				view.layer.transform = CATransform3DIdentity
			})

		} else if !isSectionViewAnimatedList.contains(indexPath.section) {
			view.alpha = 0.05
			let transform = CATransform3DTranslate(CATransform3DIdentity, 0, 20, 0)
			view.layer.transform = transform

			let delay = 1.0 * Double(indexPath.section) //Double(isSectionViewAnimatedList.count)

			UIView.animate(withDuration: 2, delay: delay, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseOut, .allowUserInteraction], animations: {
				view.alpha = 1
				view.layer.transform = CATransform3DIdentity
			})

//			isSectionViewAnimatedList.append(indexPath.section)
		}

//		if indexPath.section > visibleLastSection {
//			if isSectionViewAnimatedList.contains(indexPath) == false { //
//				view.alpha = 0.05
//				let transform = CATransform3DTranslate(CATransform3DIdentity, 0, 20, 0)
//				view.layer.transform = transform
//
//				let delay = 2.0
//
//				UIView.animate(withDuration: 2, delay: delay, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseOut, .allowUserInteraction], animations: {
//					view.alpha = 1
//					view.layer.transform = CATransform3DIdentity
//				})
//
//				isSectionViewAnimatedList.append(indexPath)
//			}
//		} else {
//			if isSectionViewAnimatedList.contains(indexPath) == false { //
//				view.alpha = 0.05
//				let transform = CATransform3DTranslate(CATransform3DIdentity, 0, 20, 0)
//				view.layer.transform = transform
//
//				let delay = 2 * Double(indexPath.section)
//
//				UIView.animate(withDuration: 2, delay: delay, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseOut, .allowUserInteraction], animations: {
//					view.alpha = 1
//					view.layer.transform = CATransform3DIdentity
//				})
//
//				isSectionViewAnimatedList.append(indexPath)
//			}
//		}
	}

	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

		print("row", indexPath)
		if startDragging {
			cell.alpha = 0.05
			let transform = CATransform3DTranslate(CATransform3DIdentity, 0, 20, 0)
			cell.layer.transform = transform

			let delay = 1.0

			UIView.animate(withDuration: 2, delay: delay, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseOut, .allowUserInteraction], animations: {
				cell.alpha = 1
				cell.layer.transform = CATransform3DIdentity
			})

		} else if !isSectionCellAnimatedList.contains(indexPath.section) {
			cell.alpha = 0.05
			let transform = CATransform3DTranslate(CATransform3DIdentity, 0, 20, 0)
			cell.layer.transform = transform

			let delay = 1.0 * Double(isSectionCellAnimatedList.count)

			UIView.animate(withDuration: 2, delay: delay, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseOut, .allowUserInteraction], animations: {
				cell.alpha = 1
				cell.layer.transform = CATransform3DIdentity
			})

			isSectionCellAnimatedList.append(indexPath.section)
		}


//		if indexPath.section > visibleLastSection {
//			if isSectionCellAnimatedList.contains(indexPath) == false { //
//				cell.alpha = 0.05
//				let transform = CATransform3DTranslate(CATransform3DIdentity, 0, 20, 0)
//				cell.layer.transform = transform
//
//				let delay = 2.0
//
//				UIView.animate(withDuration: 2, delay: delay, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseOut, .allowUserInteraction], animations: {
//					cell.alpha = 1
//					cell.layer.transform = CATransform3DIdentity
//				})
//
//				isSectionCellAnimatedList.append(indexPath)
//			}
//		} else {
//			if isSectionCellAnimatedList.contains(indexPath) == false { //
//				cell.alpha = 0.05
//				let transform = CATransform3DTranslate(CATransform3DIdentity, 0, 20, 0)
//				cell.layer.transform = transform
//
//				let delay = 2 * Double(indexPath.section)
//
//				UIView.animate(withDuration: 2, delay: delay, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseOut, .allowUserInteraction], animations: {
//					cell.alpha = 1
//					cell.layer.transform = CATransform3DIdentity
//				})
//
//				isSectionCellAnimatedList.append(indexPath)
//			}
//		}
	}
}

extension ViewController: UIScrollViewDelegate {
	func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		startDragging = true
	}
}

extension ViewController: ExpandableSectionDelegate {
	func sectionReload(isExpand: Bool, indexPaths: [IndexPath]) {
//		let indexSet = IndexSet(integer: section)
//		collectionView.reloadSections(indexSet)

		collectionView.performBatchUpdates({
			if isExpand {
				collectionView.insertItems(at: indexPaths)
			} else {
				collectionView.deleteItems(at: indexPaths)
			}
		})
	}
}
