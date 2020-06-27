//
//  LessonsList.swift
//  kpiRozkladSwiftUI
//
//  Created by Денис Данилюк on 27.06.2020.
//

import SwiftUI

struct LessonsList: View {
    var week: Int
    var lessons: [Lesson]
    
    var normalLessons: [Int: [DayName: [Lesson]]] = [:]
    
    init(lessons: [Lesson], week: Int) {
        self.lessons = lessons
        self.week = week
        normalLessons = makeLessonsShedule(lessons: lessons)
        print(normalLessons.keys)

    }
    
    var body: some View {
        List {
            if let week1 = normalLessons[week]{
                ForEach(week1.keys.sorted(), id: \.self) { key in
                    let lessonsForToday = week1[key]!
                    Section(header: Text(key.rawValue).foregroundColor(.black)) {
                        ForEach(lessonsForToday) { lesson in
                            LessonRow(lesson: lesson)
                                .padding(.leading, -10)
                        }
                    }
                }
                
            }
            
        }
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .listStyle(InsetGroupedListStyle())

        
    }
    
    func makeLessonsShedule(lessons: [Lesson]) -> [Int: [DayName: [Lesson]]] {
        let lessonsWeekFirst = lessons.filter{ return $0.lessonWeek == "1" }
        let lessonsWeekSecond = lessons.filter{ return $0.lessonWeek == "2" }
        
        let weeks = [lessonsWeekFirst, lessonsWeekSecond]
        var ret: [Int: [DayName: [Lesson]]] = [:]
        
        for weekNumber in 1...weeks.count {
            let currentLessonWeek = weeks[weekNumber - 1]
            var sortedDictionary = Dictionary(grouping: currentLessonWeek) { $0.dayName }
            for day in DayName.allCases {
                if sortedDictionary[day] == nil {
                    sortedDictionary[day] = []
                }
            }
            
            var result: [DayName : [Lesson]] = [:]
            let keys = sortedDictionary.keys.sorted()
            keys.forEach { dayName in
                if let lessons: [Lesson] = sortedDictionary[dayName] {
                    result[dayName] = lessons
                } else {
                    result[dayName] = []
                }
            }
            ret[weekNumber] = result
        }
        
        return ret
    }
    
}

struct LessonsList_Previews: PreviewProvider {
    static var previews: some View {
        LessonsList(lessons: [lessonToTest, lessonToTest], week: 1)
    }
}
