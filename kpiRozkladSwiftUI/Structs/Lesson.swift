//
//  Server.swift
//  kpiRozklad
//
//  Created by Denis on 9/26/19.
//  Copyright © 2019 Denis Danilyuk. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import UIKit

 
// MARK: - Welcome
struct WelcomeLessons: Codable {
    let statusCode, timeStamp: Int
    let message, debugInfo: String?
    let meta: JSONNull?
    let data: [Lesson]
}


// MARK: - Lesson
public struct Lesson: Codable, Hashable, Identifiable {
    public let id: Int
    let dayNumber, lessonNumber, lessonWeek: Int
    let groupID: Int?
    let dayName: DayName
    let lessonType: LessonType
    let lessonName, lessonFullName, lessonRoom: String
    let teacherName, timeStart, timeEnd: String
    let rate: String
    let teacher: Teacher?
    let room: Room?
    let groups: [Group]?

    
    enum CodingKeys: String, CodingKey {
        case id = "lesson_id"
        case groupID = "group_id"
        case dayNumber = "day_number"
        case dayName = "day_name"
        case lessonName = "lesson_name"
        case lessonFullName = "lesson_full_name"
        case lessonNumber = "lesson_number"
        case lessonRoom = "lesson_room"
        case lessonType = "lesson_type"
        case teacherName = "teacher_name"
        case lessonWeek = "lesson_week"
        case timeStart = "time_start"
        case timeEnd = "time_end"
        case room = "rooms"
        case teacher = "teachers"

        case rate, groups
    }
    
    
    static let defaultLesson = Lesson(id: 1, dayNumber: 1, lessonNumber: 12, lessonWeek: 1, groupID: 123, dayName: DayName.mounday, lessonType: LessonType.лек1, lessonName: "Lesson Name", lessonFullName: "Lesson Full", lessonRoom: "LessonRoom", teacherName: "teacher", timeStart: "08:30", timeEnd: "10:25", rate: "rate", teacher: nil, room: nil, groups: [])

    static var defaultArratOfLesson: [Lesson] = Array(repeating: defaultLesson, count: 3)
}


extension Lesson: Comparable {
    public static func < (lhs: Lesson, rhs: Lesson) -> Bool {
        return lhs.dayName.rawValue == rhs.dayName.rawValue

    }
    
    public static func == (lhs: Lesson, rhs: Lesson) -> Bool {
        return lhs.dayName.rawValue < rhs.dayName.rawValue
    }
}
