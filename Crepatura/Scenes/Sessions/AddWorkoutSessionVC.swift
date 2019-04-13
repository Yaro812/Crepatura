//
//  AddWorkoutVC.swift
//  Crepatura
//
//  Created by Yaroslav Pasternak on 07/03/2019.
//  Copyright © 2019 Thorax. All rights reserved.
//

import CoreData
import UIKit

final class AddWorkoutSessionVC: UIViewController, CoreDataUsing {
    enum Constant {
        static let itemWidth: CGFloat = 200
    }

    let coreData: CoreDataService
    let coordinator: SessionsCoordinator

    let dateTextField = UITextField()
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

        dateTextField.text = "\(Date())"
        view.addSubview(dateTextField)

        addButton.setTitleColor(.blue, for: .normal)
        addButton.setTitle("Add Workout session".localized, for: .normal)
        addButton.addTarget(self, action: #selector(tapAddWorkout), for: .touchUpInside)
        view.addSubview(addButton)

        setupConstraints()
    }

    func setupConstraints() {
        dateTextField.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        let guide = view.safeAreaLayoutGuide
        let constraints = [
            dateTextField.topAnchor.constraint(equalTo: guide.topAnchor),
            dateTextField.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            dateTextField.widthAnchor.constraint(equalToConstant: Constant.itemWidth),
            addButton.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: 50),
            addButton.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            addButton.widthAnchor.constraint(equalToConstant: Constant.itemWidth)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    @objc
    func tapAddWorkout(_ sender: Any) {
        coreData.performInBackground { context in
            let session = WorkoutSession(context: context)
            session.id = UUID()
            session.date = Date()
            context.performAndWait {
                try? context.save()
            }
            DispatchQueue.main.async {
                try? self.coreData.viewContext.save()
                self.coordinator.workoutSessionAdded(sender: self)
            }

        }
    }
}
