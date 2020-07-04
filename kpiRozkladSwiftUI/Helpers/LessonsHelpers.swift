//
//  LessonsHelpers.swift
//  kpiRozkladSwiftUI
//
//  Created by Денис Данилюк on 04.07.2020.
//

import UIKit

func getDate(lesson: Lesson) -> (dateStart: Date, dateEnd: Date) {
    let timeStart = lesson.timeStart.stringTime
    let timeEnd = lesson.timeEnd.stringTime
    
    let dateNow = Date()

    let formatterFull = DateFormatter()
    formatterFull.dateFormat = "YYYY:MM:DD:HH:mm"

    let formatterInWhichTimeSaved = DateFormatter()
    formatterInWhichTimeSaved.dateFormat = "YYYY:MM:DD"
    let fullYearMonthDay = formatterInWhichTimeSaved.string(from: dateNow)

    let dateStartInit = formatterFull.date(from: "\(fullYearMonthDay):\(timeStart)") ?? Date()
    let dateEndInit = formatterFull.date(from: "\(fullYearMonthDay):\(timeEnd)") ?? Date()
    
    return (dateStart: dateStartInit, dateEnd: dateEndInit)
    
//        let toStartPair = dateStartInit.timeIntervalSince1970 - dateNow.timeIntervalSince1970
//        let toEndPair = dateEndInit.timeIntervalSince1970 - dateNow.timeIntervalSince1970
}
