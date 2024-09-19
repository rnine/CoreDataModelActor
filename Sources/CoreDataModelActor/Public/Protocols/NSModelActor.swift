//
//  NSModelActor.swift
//  CoreDataModelActor
//
//  Created by Ruben Nine on 19/9/24.
//
//  Based on https://github.com/fatbobman/CoreDataEvolution

import Foundation
import CoreData

public protocol NSModelActor: Actor {
    /// The NSPersistentContainer for the NSModelActor
    nonisolated var modelContainer: NSPersistentContainer { get }

    /// The executor that coordinates access to the model actor.
    nonisolated var modelExecutor: any NSModelObjectContextExecutor { get }
}

extension NSModelActor {
    /// The optimized, unonwned reference to the model actor's executor.
    public nonisolated var unownedExecutor: UnownedSerialExecutor {
        modelExecutor.asUnownedSerialExecutor()
    }

    /// The context that serializes any code running on the model actor.
    public var modelContext: NSManagedObjectContext {
        modelExecutor.context
    }

    /// Returns the model for the specified identifier, downcast to the appropriate class.
    public subscript<T>(id: NSManagedObjectID, as _: T.Type) -> T? where T: NSManagedObject {
        try? modelContext.existingObject(with: id) as? T
    }
}
