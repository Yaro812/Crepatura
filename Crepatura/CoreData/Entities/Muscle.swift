//
//  Muscle.swift
//  Crepatura
//
//  Created by Yaroslav Pasternak on 13/04/2019.
//  Copyright © 2019 Thorax. All rights reserved.
//

import CoreData
import Foundation

@objc(Muscle)
class Muscle: NSManagedObject, FetchableById {
    typealias Id = String

    @NSManaged public var name: Id

    @NSManaged public var exercises: NSSet // of Exercise

    @NSManaged func addExercisesObject(exercises: NSSet)
    @NSManaged func removeExercisesObject(exercises: NSSet)
}
