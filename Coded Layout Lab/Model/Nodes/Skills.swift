//
//  File.swift
//  Coded Layout Lab
//
//  Created by Jeroen Dunselman on 08/03/2020.
//  Copyright © 2020 Jeroen Dunselman. All rights reserved.
//

import Foundation

enum SkillsSchema:String, CaseIterable {
    case name,
    level,
    keywords
}

extension SkillsSchema {
    func content(_ content: skill) -> Any {
        switch self {
        case .name: return content.name
        case .level: return content.level
        case .keywords: return content.keywords
        }}}
