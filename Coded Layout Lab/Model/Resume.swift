//
//  Resume.swift
//  akarsh seggemu resume
//
//  Created by Akarsh Seggemu on 29.10.18.
//  Copyright © 2018 Akarsh Seggemu. All rights reserved.


import Foundation

struct Resume: Codable {
    var basics: basics
    var work: [work]
    var volunteer: [volunteer]
    var education: [education]
    var awards: [award]
    var publications: [publication]
    var skills: [skill]
    var languages: [language]
    var interests: [interest]
    var references: [reference]
}

enum ResumeSchema: String, CaseIterable {
    case basics,
    work,
    volunteer,
    education,
    awards,
    publications,
    skills,
    languages,
    interests,
    references
}

extension ResumeSchema {
    func label() -> String  {
        switch self {
        case .basics: return "The person"
        case .work: return "The employee"
        case .volunteer: return "The volunteer"
        case .education: return "The student"
        case .awards: return "The award winner"
        case .publications: return "The publisher"
        case .skills: return "His skills"
        case .languages: return "His language skills"
        case .interests: return "His interests"
        case .references: return "What people say about him"
            //        case .image: return "His profile picture"
        }
    }
}

struct location: Codable {
    var address: String
    var postalCode: String
    var city: String
    var countryCode: String
    var region: String
}

struct profile: Codable {
    var network: String
    var username: String
    var url: String
}

struct info: Codable {
    var nationality: String
    var workPermit: String
    var dateOfBirth: String
    var placeOfBirth: String
}

struct work: Codable {
    var company: String
    var position: String
    var website: String
    var startDate: String
    var endDate: String
    var summary: String
    var highlights: [String]
}

struct volunteer: Codable {
    var organization: String
    var position: String
    var website: String
    var startDate: String
    var endDate: String
    var summary: String
    var highlights: [String]
}

struct education: Codable {
    var institution: String
    var area: String
    var studyType: String
    var startDate: String
    var endDate: String
    var gpa: String
    var courses: [String]
}

struct award: Codable {
    var title: String
    var date: String
    var awarder: String
    var summary: String
}

struct publication: Codable {
    var name: String
    var publisher: String
    var releaseDate: String
    var website: String
    var summary: String
}

struct skill: Codable {
    var name: String
    var level: String
    var keywords: [String]
}

struct language: Codable {
    var language: String
    var fluency: String
}

struct interest: Codable {
    var name: String
    var keywords: [String]
}

struct reference: Codable {
    var name: String
    var reference: String
}

