//
//  Attachable.swift
//  Crepatura
//
//  Created by Yaroslav Pasternak on 14/04/2019.
//  Copyright © 2019 Thorax. All rights reserved.
//

import UIKit

protocol Attachable: UIViewController {
    /// add a child view controller to be presented in container view
    func attach(to parent: UIViewController, in view: UIView?)
}

extension Attachable {
    func attach(to parent: UIViewController, in view: UIView?) {
        let view: UIView = view ?? parent.view

        self.view.frame = view.bounds
        view.addSubview(self.view)
        self.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        parent.addChild(self)
        didMove(toParent: parent)
    }

    static func attached(to parent: UIViewController, in view: UIView?) -> Self {
        let vc = Self.init(nibName: nil, bundle: nil)
        vc.attach(to: parent, in: view)
        return vc
    }
}
