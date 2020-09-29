//
//  WorkoutSession.swift
//  Crepatura
//
//  Created by Yaroslav Pasternak on 13/04/2019.
//  Copyright © 2019 Thorax. All rights reserved.
//

import CoreData
import Foundation

@objc(WorkoutSession)
class WorkoutSession: NSManagedObject, FetchableById {
    typealias Id = UUID

    @NSManaged public var id: UUID
    @NSManaged public var date: Date

    @NSManaged public var sessionTypes: Set<SessionType>?
    @NSManaged public var workouts: Set<Workout>?

    @NSManaged func addSessionTypesObject(_ objects: Set<SessionType>)
    @NSManaged func removeSessionTypesObject(_ objects: Set<SessionType>)

    @NSManaged func addWorkoutsObject(_ objects: Set<Workout>)
    @NSManaged func removeWorkoutsObject(_ objects: Set<Workout>)
}

