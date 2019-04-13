//
//  String+localization.swift
//  Crepatura
//
//  Created by Yaroslav Pasternak on 14/04/2019.
//  Copyright © 2019 Thorax. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        guard let range = self.range(of: ":") else {
            return NSLocalizedString(self, comment: self)
        }

        return NSLocalizedString(self,
                                 tableName: String(self[..<range.lowerBound]),
                                 comment: self)
    }

    func localized(_ arguments: CVarArg...) -> String {
        let template = localized
        return String(format: template, arguments: arguments)
    }
}
