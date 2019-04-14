//
//  WorkoutType.swift
//  Crepatura
//
//  Created by Yaroslav Pasternak on 07/03/2019.
//  Copyright © 2019 Thorax. All rights reserved.
//

import CoreData
import Foundation

@objc(SessionType)
class SessionType: NSManagedObject, FetchableById {
    typealias Id = String

    @NSManaged public var name: String
    @NSManaged public var details: String?

    @NSManaged public var sessions: Set<WorkoutSession>

    @NSManaged func addSessionsObject(_ objects: Set<WorkoutSession>)
    @NSManaged func removeSessionsObject(_ objects: Set<WorkoutSession>)
}
