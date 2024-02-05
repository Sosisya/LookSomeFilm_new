//
//  RealmManager.swift
//  LookSomeFilm
//
//  Created by Луиза Самойленко on 17.11.2023.
//

import Foundation
import RealmSwift

final class RealmManager {
    static let shared = RealmManager()
    
    private let storage: Realm?

    init(_ configuration: Realm.Configuration = Realm.Configuration(
        schemaVersion: 1,
        migrationBlock: nil,
        deleteRealmIfMigrationNeeded: true)
    ) {
        self.storage = try? Realm(configuration: configuration)
    }

    /// Create or Update
    func createUpdate(object: FavouriteModel) throws {
        guard let storage else { return }
        try storage.write {
            storage.add(object)
        }
    }

    /// Read
    func fetch() -> [FavouriteModel] {
        guard let storage else { return [] }
        return storage.objects(FavouriteModel.self).toArray()
    }

    /// Delete
    func delete(object: FavouriteModel) throws {
        guard let storage else { return }
        try storage.write {
            storage.delete(object)
        }
    }
}

extension Results {
    func toArray() -> [Element] {
        .init(self)
    }
}
