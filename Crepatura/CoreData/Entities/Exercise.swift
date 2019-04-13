//
//  Exercise.swift
//  Crepatura
//
//  Created by Yaroslav Pasternak on 13/04/2019.
//  Copyright © 2019 Thorax. All rights reserved.
//

import CoreData
import Foundation

@objc(Exercise)
class Exercise: NSManagedObject, FetchableById {
    typealias Id = String

    @NSManaged public var name: Id
    @NSManaged public var details: String?

    @NSManaged public var workouts: Set<Workout>
    @NSManaged public var muscles: Set<Muscle>

    @NSManaged func addWorkoutsObject(_ objects:  Set<Workout>)
    @NSManaged func removeWorkoutsObject(_ objects:  Set<Workout>)

    @NSManaged func addMusclesObject(_ objects:  Set<Muscle>)
    @NSManaged func removeMusclesObject(_ objects:  Set<Muscle>)
}
