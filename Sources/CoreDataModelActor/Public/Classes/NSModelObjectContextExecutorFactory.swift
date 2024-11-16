//
//  NSModelObjectContextExecutorFactory.swift
//  CoreDataModelActor
//
//  Created by Ruben Nine on 16/11/24.
//

import Foundation
import CoreData

public final class NSModelObjectContextExecutorFactory {
    public static func makeExecutor(context: NSManagedObjectContext) -> any NSModelObjectContextExecutor {
        if #available(macOS 14.0, iOS 17.0, tvOS 17.0, watchOS 10.0, macCatalyst 17.0, *) {
            NSModelObjectContextExecutorNew(context: context)
        } else {
            NSModelObjectContextExecutorLegacy(context: context)
        }
    }
}
