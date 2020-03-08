//
//  Awards.swift
//  Coded Layout Lab
//
//  Created by Jeroen Dunselman on 08/03/2020.
//  Copyright © 2020 Jeroen Dunselman. All rights reserved.
//

import Foundation

enum AwardsSchema:String, CaseIterable {
    case title,
    date,
    awarder,
    summary
}

extension AwardsSchema {
    func content(_ content: award) -> Any {
        switch self {
        case .title: return content.title
        case .date: return content.date
        case .awarder: return content.awarder
        case .summary: return content.summary
        }}}
