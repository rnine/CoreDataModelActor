//
//  NSModelObjectContextExecutorLegacy.swift
//  CoreDataModelActor
//
//  Created by Ruben Nine on 19/9/24.
//
//  Based on https://github.com/fatbobman/CoreDataEvolution

import Foundation
import CoreData

public final class NSModelObjectContextExecutorLegacy: @unchecked Sendable, NSModelObjectContextExecutor {
    public final let context: NSManagedObjectContext
    public init(context: NSManagedObjectContext) {
        self.context = context
    }

    public func enqueue(_ job: UnownedJob) {
        let unownedExecutor = asUnownedSerialExecutor()
        context.perform {
            job.runSynchronously(on: unownedExecutor)
        }
    }

    public func asUnownedSerialExecutor() -> UnownedSerialExecutor {
        UnownedSerialExecutor(ordinary: self)
    }
}
