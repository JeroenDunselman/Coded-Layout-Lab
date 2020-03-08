//
//  Basics.swift
//  Coded Layout Lab
//
//  Created by Jeroen Dunselman on 08/03/2020.
//  Copyright © 2020 Jeroen Dunselman. All rights reserved.
//

import Foundation

struct basics: Codable {
    var name: String
    var label: String
    var picture: String
    var email: String
    var phone: String
    var website: String
    var summary: String
    var location: location
    var profiles: [profile]
    var info: info
}

enum BasicsSchema:String, CaseIterable {
    case name,
    label,
    picture,
    email,
    phone,
    website,
    summary,
    location,
    profiles,
    info
}

extension BasicsSchema {
    func content(_ content: Resume) -> Any {
        switch self {
        case .name: return content.basics.name
        case .label: return content.basics.label
        case .picture: return content.basics.picture
        case .email: return content.basics.email
        case .phone: return content.basics.phone
        case .website: return content.basics.website
        case .summary: return content.basics.summary
        case .location: return content.basics.location
        case .profiles: return content.basics.profiles
        case .info: return content.basics.info
        }
    }
}

enum LocationSchema:String, CaseIterable {
    case address,
    postalCode,
    city,
    countryCode,
    region
}

extension LocationSchema {
    func content(_ content: Resume) -> Any {
        switch self {
        case .address: return content.basics.location
        case .postalCode: return content.basics.location.postalCode
        case .city: return content.basics.location.city
        case .countryCode: return content.basics.location.countryCode
        case .region: return content.basics.location.region
        }
    }
}

enum InfoSchema:String, CaseIterable {
    case nationality,
    workPermit,
    dateOfBirth,
    placeOfBirth
}

extension InfoSchema {
    func content(_ content: Resume) -> Any {
        
        switch self {
        case .nationality: return content.basics.info.nationality
        case .workPermit: return content.basics.info.workPermit
        case .dateOfBirth: return content.basics.info.dateOfBirth
        case .placeOfBirth: return content.basics.info.placeOfBirth
            
        }}}
//
//enum ProfilesSchema: CaseIterable {
//    case network,
//    username,
//    url
//}
