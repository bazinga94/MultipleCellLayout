//
//  SectionRegister.swift
//  MultipleCellLayout
//
//  Created by Jongho Lee on 2021/09/21.
//

import UIKit

protocol SectionRegisterable {
	associatedtype SectionHolder: SectionViewHolder//, ReusableCellHolder

	static func registerHeaderAsXib(on sectionViewHolder: SectionHolder)
	static func registerHeaderAsCustom(on sectionViewHolder: SectionHolder)
	static func registerFooterAsXib(on sectionViewHolder: SectionHolder)
	static func registerFooterAsCustom(on sectionViewHolder: SectionHolder)
}

// collection view 한정임
class SectionRegister<Section: SectionView, SectionHolder: SectionViewHolder>: SectionRegisterable {

	final class var sectionClass: AnyClass {
		return Section.self
	}

	final class var sectionIdentifier: String {
		return String(describing: sectionClass)
	}

	static func registerHeaderAsXib(on sectionViewHolder: SectionHolder) {
		let bundle = Bundle(for: sectionClass)
		let nib = UINib(nibName: sectionIdentifier, bundle: bundle)
		sectionViewHolder.register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionIdentifier)
	}

	static func registerHeaderAsCustom(on sectionViewHolder: SectionHolder) {
		sectionViewHolder.register(sectionClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionIdentifier)
	}

	static func registerFooterAsXib(on sectionViewHolder: SectionHolder) {
		let bundle = Bundle(for: sectionClass)
		let nib = UINib(nibName: sectionIdentifier, bundle: bundle)
		sectionViewHolder.register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: sectionIdentifier)
	}

	static func registerFooterAsCustom(on sectionViewHolder: SectionHolder) {
		sectionViewHolder.register(sectionClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: sectionIdentifier)
	}
}

// section에는 header, footer가 각각 있어서 generic 하게 사용하진 못 할듯..
//class SectionConfigurator<Section: SectionView>: SectionRegister<Section.SectionHolder> {
//
//	final class override var sectionClass: AnyClass {
//		return Section.self
//	}
//}
