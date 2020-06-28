//
//  WidgetView.swift
//  kpiRozkladSwiftUI
//
//  Created by Денис Данилюк on 27.06.2020.
//

import SwiftUI
import WidgetKit


struct WidgetView: View {
    
    var lessons: [Lesson]
    
    init(lessons: [Lesson]) {
        self.lessons = lessons
    }
    
    var body: some View {
        VStack {
            Spacer()
            if lessons.count >= 2 {
                LessonRow(lesson: lessons[0])
                Spacer()
                LessonRow(lesson: lessons[1])
            } else {
                Text("NoLessonsLoaded")
            }
            
            Spacer()
        }
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
