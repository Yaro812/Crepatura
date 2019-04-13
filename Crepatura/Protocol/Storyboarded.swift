//
//  Storyboarded.swift
//  Crepatura
//
//  Created by Yaroslav Pasternak on 14/04/2019.
//  Copyright © 2019 Thorax. All rights reserved.
//

import UIKit

/// Protocol that helps UIViewControllers instantiate from Storyboard without segues
protocol Storyboarded: class {
    static var storyboardId: String { get }
    static var storyboardName: String { get }

    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static var storyboardId: String { return "\(self)" }
    static var storyboardName: String { return "Main" }

    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: storyboardId)
        // swiftlint:disable:next force_cast
        return vc as! Self
    }
}
