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

    @NSManaged public var sessionType: SessionType?
    @NSManaged public var workouts: NSSet // of Workout

    @NSManaged func addSessionTypeObject(sessionType: SessionType)
    @NSManaged func removeSessionTypeObject(sessionType: SessionType)

    @NSManaged func addWorkoutsObject(workouts: NSSet)
    @NSManaged func removeWorkoutsObject(workouts: NSSet)
}
