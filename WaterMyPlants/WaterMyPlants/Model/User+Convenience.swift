//
//  User+Convenience.swift
//  WaterMyPlants
//
//  Created by Craig Swanson on 2/26/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

import Foundation
import CoreData

extension User {

    // these will change when we get the api endpoints.
    enum CodingKeys: String, CodingKey {
        case identifier = "identifer"
        case password = "password"
        case phoneNumber = "phoneNumber"
        case username = "username"
    }

    var userRepresentation: UserRepresentation? {
        guard let password = password,
        let phoneNumber = phoneNumber,
            let username = username else { return nil }
        return UserRepresentation(identifier: UUID().uuidString,
                                  password: password,
                                  phoneNumber: phoneNumber,
                                  username: username)
    }

    // need to add a convenience initializer
    @discardableResult convenience init(identifier: UUID = UUID(),
                                        password: String,
                                        phoneNumber: String,
                                        username: String,
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {

        self.init(context: context)
        self.identifier = identifier
        self.password = password
        self.phoneNumber = phoneNumber
        self.username = username
    }

    // need to add a "representation" convenience initializer
    @discardableResult convenience init?(userRepresentation: UserRepresentation, context: NSManagedObjectContext) {

        self.init(identifier: UUID(uuidString: userRepresentation.identifier) ?? UUID(),
                  password: userRepresentation.password,
                  phoneNumber: userRepresentation.phoneNumber,
                  username: userRepresentation.username)
    }
}