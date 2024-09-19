//
//  NSModelObjectContextExecutorNew.swift
//  CoreDataModelActor
//
//  Created by Ruben Nine on 19/9/24.
//
//  Based on https://github.com/fatbobman/CoreDataEvolution

import Foundation
import CoreData

@available(macOS 14.0, *)
@available(iOS 17.0, *)
@available(tvOS 17.0, *)
@available(watchOS 10.0, *)
@available(macCatalyst 17.0, *)
public final class NSModelObjectContextExecutorNew: @unchecked Sendable, NSModelObjectContextExecutor {
    public final let context: NSManagedObjectContext
    public init(context: NSManagedObjectContext) {
        self.context = context
    }

    public func enqueue(_ job: consuming ExecutorJob) {
        let unownedJob = UnownedJob(job)
        let unownedExecutor = asUnownedSerialExecutor()
        context.perform {
            unownedJob.runSynchronously(on: unownedExecutor)
        }
    }

    public func asUnownedSerialExecutor() -> UnownedSerialExecutor {
        UnownedSerialExecutor(ordinary: self)
    }
}
