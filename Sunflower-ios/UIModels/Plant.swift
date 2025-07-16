//
//  Plant.swift
//  Sunflower-ios
//
//  Created by Devender Sinhg Parihar on 6/15/25.
//

import Foundation
import SwiftData

@Model
class Plant: Codable, Identifiable {
    var id: String { plantId }
    var plantId: String
    var name: String
    var plantDetail: String
    var wateringFrequency: Int
    var imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case plantId
        case name
        case imageUrl
        case plantDetail = "description"
        case wateringFrequency = "wateringInterval"
    }

    init(plantId: String, name: String, imageUrl: String, plantDetail: String, wateringFrequency: Int) {
        self.plantId = plantId
        self.name = name
        self.imageUrl = imageUrl
        self.plantDetail = plantDetail
        self.wateringFrequency = wateringFrequency
    }
    
    required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            plantId = try container.decode(String.self, forKey: .plantId)
            name = try container.decode(String.self, forKey: .name)
            imageUrl = try container.decode(String.self, forKey: .imageUrl)
            plantDetail = try container.decode(String.self, forKey: .plantDetail)
            wateringFrequency = try container.decode(Int.self, forKey: .wateringFrequency)
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(plantId, forKey: .plantId)
            try container.encode(name, forKey: .name)
            try container.encode(imageUrl, forKey: .imageUrl)
            try container.encodeIfPresent(plantDetail, forKey: .plantDetail)
            try container.encodeIfPresent(wateringFrequency, forKey: .wateringFrequency)
        }
}



