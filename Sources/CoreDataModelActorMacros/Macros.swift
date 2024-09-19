//
//  Macros.swift
//  CoreDataModelActor
//
//  Created by Ruben Nine on 19/9/24.
//
//  Based on https://github.com/fatbobman/CoreDataEvolution

import Foundation
import CoreDataModelActor

@attached(member, names: named(modelExecutor), named(modelContainer), named(init))
@attached(extension, conformances: NSModelActor)
public macro NSModelActor() = #externalMacro(module: "CoreDataModelActorMacrosPlugin", type: "NSModelActorMacro")
