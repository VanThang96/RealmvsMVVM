//
//  Item.swift
//  RealmvsMVVM
//
//  Created by win on 4/3/19.
//  Copyright © 2019 win. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var code : String? = nil
    @objc dynamic var district: String? = nil
    @objc dynamic var province : String? = nil
}
