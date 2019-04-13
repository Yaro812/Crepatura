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

    @NSManaged public var exercise: Exercise
    @NSManaged public var session: WorkoutSession
    @NSManaged public var trainingSets: Set<TrainingSet>

    @NSManaged func addExerciseObject(_ object: Exercise)
    @NSManaged func removeExerciseObject(_ object: Exercise)

    @NSManaged func addSessionObject(_ object: WorkoutSession)
    @NSManaged func removeSessionObject(_ object: WorkoutSession)

    @NSManaged func addTrainingSetsObject(_ objects: Set<TrainingSet>)
    @NSManaged func removeTrainingSetsObject(_ objects: Set<TrainingSet>)
}
