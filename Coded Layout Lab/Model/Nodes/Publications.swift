//
//  Publications.swift
//  Coded Layout Lab
//
//  Created by Jeroen Dunselman on 08/03/2020.
//  Copyright © 2020 Jeroen Dunselman. All rights reserved.
//

import Foundation

enum PublicationsSchema:String, CaseIterable {
    case name,
    publisher,
    releaseDate,
    website,
    summary
}

extension PublicationsSchema {
    func content(_ content: publication) -> Any {
        switch self {
        case .name: return content.name
        case .publisher: return content.publisher
        case .releaseDate: return content.releaseDate
        case .website: return content.website
        case .summary: return content.summary
        }}}
