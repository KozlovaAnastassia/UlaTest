//
//  ServiceModel.swift
//  UlaTest
//
//  Created by Анастасия on 31.03.2024.
//

import Foundation

struct ResponseDataModel: Codable {
    let body: BodyModel
    let status: Int
}

struct BodyModel: Codable {
    let services: [ServiceModel]
}

struct ServiceModel: Codable {
    let name: String
    let description: String
    let link: String
    let iconUrl: String
}
