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

    @NSManaged public var muscles: NSSet // of Muscle
    @NSManaged public var workouts: NSSet // of Workout

    @NSManaged func addWorkoutsObject(workout: NSSet)
    @NSManaged func removeWorkoutsObject(workout: NSSet)

    @NSManaged func addMusclesObject(muscles: NSSet)
    @NSManaged func removeMusclessObject(muscles: NSSet)
}
