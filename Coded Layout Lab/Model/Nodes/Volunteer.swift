//
//  Volunteer.swift
//  Coded Layout Lab
//
//  Created by Jeroen Dunselman on 08/03/2020.
//  Copyright © 2020 Jeroen Dunselman. All rights reserved.
//

import Foundation

enum VolunteerSchema:String, CaseIterable {
    case organization,
    position,
    website,
    startDate,
    endDate,
    summary,
    highlights
}

extension VolunteerSchema {
    func content(_ content: volunteer) -> Any {
        
        switch self {
        case .organization: return content.organization
        case .position: return content.position
        case .website: return content.website
        case .startDate: return content.startDate
        case .endDate: return content.endDate
        case .summary: return content.summary
        case .highlights: return content.highlights
        }
    }
}
