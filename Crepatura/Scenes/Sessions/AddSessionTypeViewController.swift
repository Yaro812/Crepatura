//
//  AddSessionTypeViewController.swift
//  Crepatura
//
//  Created by Yaroslav Pasternak on 14/04/2019.
//  Copyright © 2019 Thorax. All rights reserved.
//

import CoreData
import UIKit

final class AddSessionTypeViewController: UIViewController, CoreDataUsing {
    enum Constant {
        static let itemWidth: CGFloat = 200
    }

    let coreData: CoreDataService
    weak var coordinator: SessionsCoordinator?

    let nameTextField = UITextField()
    let detailTextView = UITextView()
    let addButton = UIButton()

    required init(coordinator: SessionsCoordinator, coreData: CoreDataService) {
        self.coordinator = coordinator
        self.coreData = coreData
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func setupView() {
        view.backgroundColor = .white

        nameTextField.text = ""
        view.addSubview(nameTextField)

        addButton.setTitleColor(.blue, for: .normal)
        addButton.setTitle("Add Workout session".localized, for: .normal)
        addButton.addTarget(self, action: #selector(tapAdd), for: .touchUpInside)
        view.addSubview(addButton)

        setupConstraints()
    }

    func setupConstraints() {
         nameTextField.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        let guide = view.safeAreaLayoutGuide
        let constraints = [
             nameTextField.topAnchor.constraint(equalTo: guide.topAnchor),
             nameTextField.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
             nameTextField.widthAnchor.constraint(equalToConstant: Constant.itemWidth),
            addButton.topAnchor.constraint(equalTo:  nameTextField.bottomAnchor, constant: 50),
            addButton.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            addButton.widthAnchor.constraint(equalToConstant: Constant.itemWidth)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    @objc
    func tapAdd(_ sender: Any) {
        let name = nameTextField.text ?? ""
        coreData.performInBackground { context in
            let item = SessionType(context: context)
            item.name = name
            context.performAndWait {
                try? context.save()
            }
            DispatchQueue.main.async {
                try? self.coreData.viewContext.save()
                self.coordinator?.sessionTypeAdded(sender: self)
            }

        }
    }
}
