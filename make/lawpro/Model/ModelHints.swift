//
//  ModelHints.swift
//  lawpro
//
//  Created by Pham Van Thai on 15/11/2021.
//

import Foundation
import RealmSwift
import Realm
class ModelHints: Object {
    @objc dynamic var id = 0
    @objc dynamic var hint = 0

    override static func primaryKey() -> String? {
        return "id"
    }
}
