//
//  ConfigurableCell.swift
//  MultipleCellLayout
//
//  Created by Jongho Lee on 2021/09/18.
//

import UIKit

protocol ConfigurableCell {
	associatedtype DataType

	func configure(data: DataType)
}
