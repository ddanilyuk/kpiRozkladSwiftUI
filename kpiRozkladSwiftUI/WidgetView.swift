//
//  WidgetView.swift
//  kpiRozkladSwiftUI
//
//  Created by Денис Данилюк on 27.06.2020.
//

import SwiftUI
import WidgetKit


let lessonToTest = Lesson(id: "1", dayNumber: "1", groupID: "123", dayName: DayName.mounday, lessonName: "SwiftUI tutorials", lessonFullName: "SwiftUI tutorials apple", lessonNumber: "1", lessonRoom: "1", lessonType: .лаб, teacherName: "TeacherName", lessonWeek: "1", timeStart: "08:30", timeEnd: "10:25", rate: "1", teachers: [], rooms: [], groups: [])

var lessonsTEST: [Lesson] = Array(repeating: lessonToTest, count: 2)


//struct WidgetRow: View {
//
//    let lesson: Lesson
//
//    init(lesson: Lesson) {
//        self.lesson = lesson
//    }
//
//    var body: some View {
//        VStack {
//            Text(lesson.lessonFullName)
//            Text(lesson.le)
//
//        }
//    }
//}

struct WidgetView: View {
    
    var lessons: [Lesson]
    
    init(lessons: [Lesson]) {
        self.lessons = lessons
    }
    
    var body: some View {
        VStack {
            Spacer()
            if lessons.count >= 1 {
                LessonRow(lesson: lessons[0])
                Spacer()
                LessonRow(lesson: lessons[1])
            } else {
                Text("NoLessonsLoaded")
            }
            
            Spacer()
        }
//        Text(lessons[0].lessonFullName)
    }
}

struct WidgetView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetView(lessons: Lesson.defaultArratOfLesson)
            .previewLayout(.fixed(width: 329, height: 155))
        
//        WidgetView(lessons: lessonsTEST)
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
