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
//		.apply {
//			$0.register(sections: self.sectionControllers)
//			self.viewModel.items.forEach {
//				$0.registerCell(on: collectionView)
//			}

//			for configurator in self.viewModel.items {
//				configurator.registerCell(on: $0)
//			}
//		}
		.build()

	lazy var collectionViewFlowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
		.builder
		.scrollDirection(.vertical)
		.build()

	let viewModel = ViewModel()

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}
}

