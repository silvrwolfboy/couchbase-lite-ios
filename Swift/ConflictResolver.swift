//
//  ConflictResolver.swift
//  CouchbaseLite
//
//  Created by Pasin Suriyentrakorn on 5/19/17.
//  Copyright © 2017 Couchbase. All rights reserved.
//

import Foundation

/// The Conflict provides details about a conflict.
public struct Conflict {
    
    /// Mine version of the document.
    public let mine: ReadOnlyDocument
    
    /// Theirs version of the document.
    public let theirs: ReadOnlyDocument
    
    /// Base or common anchester version of the document.
    public let base: ReadOnlyDocument?

    init(impl: CBLConflict) {
        mine = ReadOnlyDocument(impl.mine)
        theirs = ReadOnlyDocument(impl.theirs)
        base = impl.base.flatMap({ReadOnlyDocument($0)})
    }
    
}

/// A protocol for an application-defined object that can resolve a conflict between two versions
/// of a document along with the base or the common ancester document if available. Called when saving
/// a document, when there is a a newer revision already in the database; and also when the
/// replicator pulls a remote revision that conflicts with a locally-saved revision.
public protocol ConflictResolver {
    
    /// Resolves the given conflict. Returning a nil document means giving up the conflict resolution
    /// and will result to a conflicting error returned when saving the document.
    ///
    /// - Parameter conflict: The conflict object.
    /// - Returns: The result document of the conflict resolution.
    func resolve(conflict: Conflict) -> ReadOnlyDocument?
    
}
