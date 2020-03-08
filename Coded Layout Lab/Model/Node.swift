//
//  Node.swift
//  Coded Layout Lab
//
//  Created by Jeroen Dunselman on 08/03/2020.
//  Copyright © 2020 Jeroen Dunselman. All rights reserved.
//

import Foundation

enum Node: String, CaseIterable {
    case basics, work, volunteer, education, awards, publications,skills,
    languages, interests, references, image,
    workDetails, volunteerDetails, educationDetails, awardsDetails,
    publicationsDetails, skillsDetails,
    locationDetails, profiles, info
}

//enum LanguagesSchema:String, CaseIterable {
//    case language,
//    fluency
//}
//
//enum InterestsSchema:String, CaseIterable {
//    case name,
//    keywords
//}
//
//enum ReferencesSchema:String, CaseIterable {
//    case name,
//    reference
//}
