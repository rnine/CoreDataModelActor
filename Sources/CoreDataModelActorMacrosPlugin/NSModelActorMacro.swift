//
//  NSModelActorMacro.swift
//  CoreDataModelActor
//
//  Created by Ruben Nine on 19/9/24.
//
//  Based on https://github.com/fatbobman/CoreDataEvolution

import Foundation
import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

/// The ModelActor in SwiftData corresponding to the Core Data version.
/// An interface for providing mutually-exclusive access to the attributes of a conforming model.
///
///     @NSModelActor
///     actor DataHandler {}
///
///  will expand to
///
///     @NSModelActor
///     actor DataHandler{}
///       public nonisolated let modelExecutor: CoreDataModelActor.NSModelObjectContextExecutor
///       public nonisolated let modelContainer: CoreData.NSPersistentContainer
///
///       public init(container: CoreData.NSPersistentContainer) {
///         let context = container.newBackgroundContext()
///         modelExecutor = CoreDataModelActor.NSModelObjectContextExecutor(context: context)
///         modelContainer = container
///       }
///     extension DataHandler: CoreDataModelActor.NSModelActor {
///     }
public enum NSModelActorMacro {}

extension NSModelActorMacro: ExtensionMacro {
    public static func expansion(of _: SwiftSyntax.AttributeSyntax, attachedTo _: some SwiftSyntax.DeclGroupSyntax, providingExtensionsOf type: some SwiftSyntax.TypeSyntaxProtocol, conformingTo _: [SwiftSyntax.TypeSyntax], in _: some SwiftSyntaxMacros.MacroExpansionContext) throws -> [SwiftSyntax.ExtensionDeclSyntax] {
        let decl: DeclSyntax =
      """
      extension \(type.trimmed): CoreDataModelActor.NSModelActor {}
      """

        guard let extensionDecl = decl.as(ExtensionDeclSyntax.self) else {
            return []
        }

        return [extensionDecl]
    }
}

extension NSModelActorMacro: MemberMacro {
    public static func expansion(of _: AttributeSyntax, providingMembersOf _: some DeclGroupSyntax, conformingTo _: [TypeSyntax], in _: some MacroExpansionContext) throws -> [DeclSyntax] {
        [
      """
      public nonisolated let modelExecutor: any CoreDataModelActor.NSModelObjectContextExecutor
      public nonisolated let modelContainer: CoreData.NSPersistentContainer
      
      public init(container: CoreData.NSPersistentContainer) {
        let context = container.newBackgroundContext()
        modelExecutor = CoreDataModelActor.NSModelObjectContextExecutorFactory.makeExecutor(context: context)
        modelContainer = container
      }
      """,
        ]
    }
}
