//
//  NSModelObjectContextExecutor.swift
//  CoreDataModelActor
//
//  Created by Ruben Nine on 19/9/24.
//
//  Based on https://github.com/fatbobman/CoreDataEvolution

import Foundation
import CoreData

public protocol NSModelObjectContextExecutor: Sendable, SerialExecutor {
    var context: NSManagedObjectContext { get }
}
