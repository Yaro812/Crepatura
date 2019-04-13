//
//  TrainingSet.swift
//  Crepatura
//
//  Created by Yaroslav Pasternak on 13/04/2019.
//  Copyright © 2019 Thorax. All rights reserved.
//

import CoreData
import Foundation

@objc(TrainingSet)
class TrainingSet: NSManagedObject, FetchableById {
    typealias Id = UUID

    @NSManaged public var id: UUID
    @NSManaged public var weight: Decimal
    @NSManaged public var repeats: Int
    @NSManaged public var details: String?

    @NSManaged public var workout: Workout

    @NSManaged func addWorkoutObject(workout: Workout)
    @NSManaged func removeWorkoutObject(workout: Workout)
}
