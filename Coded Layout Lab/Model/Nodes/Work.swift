//
//  Work.swift
//  Coded Layout Lab
//
//  Created by Jeroen Dunselman on 08/03/2020.
//  Copyright © 2020 Jeroen Dunselman. All rights reserved.
//

import Foundation

enum WorkSchema:String, CaseIterable {
    case company,
    position,
    website,
    startDate,
    endDate,
    summary,
    highlights
}

extension WorkSchema {
    func content(_ content: work) -> Any {
        
        switch self {
        case .company: return content.company
        case .position: return content.position
        case .website: return content.website
        case .startDate: return content.startDate
        case .endDate: return content.endDate
        case .summary: return content.summary
        case .highlights: return content.highlights
        }
    }
}
