//
//  Plugins.swift
//  CoreDataModelActor
//
//  Created by Ruben Nine on 19/9/24.
//
//  Based on https://github.com/fatbobman/CoreDataEvolution

import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct CoreDataEvolutionMacrosPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        NSModelActorMacro.self,
    ]
}
