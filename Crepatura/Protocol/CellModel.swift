//
//  CellModel.swift
//  Crepatura
//
//  Created by Yaroslav Pasternak on 14/04/2019.
//  Copyright © 2019 Thorax. All rights reserved.
//

import Foundation

protocol CellModel {
    var cellId: String { get }
}

extension CellModel {
    var cellId: String {
        return ""
    }
}

protocol CellModelUpdateable {
    func update(with model: CellModel)
}
