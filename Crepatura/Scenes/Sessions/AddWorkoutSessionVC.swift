//
//  AddWorkoutVC.swift
//  Crepatura
//
//  Created by Yaroslav Pasternak on 07/03/2019.
//  Copyright © 2019 Thorax. All rights reserved.
//

import CoreData
import UIKit

class AddWorkoutSessionVC: UIViewController, CoreDataUsing, Storyboarded {
    var coreData: CoreDataService!
    var coordinator: SessionsCoordinator!

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var dateTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        dateTextField.text = "\(Date())"
    }

    @IBAction func tapAddWorkout(_ sender: Any) {
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
