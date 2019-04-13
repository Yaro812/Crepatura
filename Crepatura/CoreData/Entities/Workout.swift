//
//  Workout.swift
//  Crepatura
//
//  Created by Yaroslav Pasternak on 07/03/2019.
//  Copyright © 2019 Thorax. All rights reserved.
//

import CoreData
import Foundation

@objc(Workout)
class Workout: NSManagedObject, FetchableById {
    typealias Id = UUID
    
    @NSManaged public var id: UUID

    @NSManaged func addExerciseObject(exercise: Exercise)
    @NSManaged func removeExerciseObject(exercise: Exercise)

    @NSManaged func addSessionObject(session: WorkoutSession)
    @NSManaged func removeSessionObject(session: WorkoutSession)

    @NSManaged func addTrainingSetsObject(trainingSets: NSSet)
    @NSManaged func removeTrainingSetsObject(trainingSets: NSSet)
}
