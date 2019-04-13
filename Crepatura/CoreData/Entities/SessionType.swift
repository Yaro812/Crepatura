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
    typealias Id = UUID
    
    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var details: String?

    @NSManaged func addSessionsObject(sessions: NSSet)
    @NSManaged func removeSessionsObject(sessions: NSSet)
}
