//
//  Education.swift
//  Coded Layout Lab
//
//  Created by Jeroen Dunselman on 08/03/2020.
//  Copyright © 2020 Jeroen Dunselman. All rights reserved.
//

import Foundation

enum EducationSchema:String, CaseIterable {
    case institution,
    area,
    studyType,
    startDate,
    endDate,
    gpa,
    courses
}

extension EducationSchema {
    func content(_ content: education) -> Any {
        
        switch self {
        case .institution: return content.institution
        case .area: return content.area
        case .studyType: return content.studyType
        case .startDate: return content.startDate
        case .endDate: return content.endDate
        case .gpa: return content.gpa
        case .courses: return content.courses  }}}
