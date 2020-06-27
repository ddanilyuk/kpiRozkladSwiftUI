//
//  RowView.swift
//  kpiRozkladSwiftUI
//
//  Created by Денис Данилюк on 26.06.2020.
//

import SwiftUI

struct LessonRow: View {
    
    var lesson: Lesson
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                
                Text(lesson.timeStart.stringTime)
                    .padding(.leading, 3)
                    .frame(minWidth: 30, idealWidth: 50, maxWidth: 55, alignment: .center)
                    .font(.subheadline)

                Text(lesson.lessonName)
                    .lineLimit(1)
                    .font(.title2)
                
                
                Spacer()
            }
                .padding(.bottom, 0)
            
            
            HStack(alignment: .center) {
                Text("")
                    .padding(.leading, 3)
                    .frame(minWidth: 30, idealWidth: 50, maxWidth: 55, alignment: .center)

                Text(lesson.teacherName)
                    .font(.subheadline)
                
                Spacer()
            }
            
            HStack(alignment: .center) {
                Text(lesson.timeEnd.stringTime)
                    .padding(.leading, 3)
                    .frame(minWidth: 30, idealWidth: 50, maxWidth: 55, alignment: .center)
                    .font(.subheadline)


                Text(lesson.lessonRoom + lesson.lessonType.rawValue)
                    .font(.subheadline)

                
                Spacer()
            }

        }

    }
}

let lessonToTestRow = Lesson(id: "1", dayNumber: "1", groupID: "123", dayName: DayName.mounday, lessonName: "SwiftUI tutorials", lessonFullName: "SwiftUI tutorials apple", lessonNumber: "1", lessonRoom: "1", lessonType: .лаб, teacherName: "TeacherName", lessonWeek: "1", timeStart: "08:30", timeEnd: "10:25", rate: "1", teachers: [], rooms: [], groups: [])

struct LessonRow_Previews: PreviewProvider {
    static var previews: some View {
//        ForEach(["iPhone X", "iPhone 8"], id: \.self) { deviceName in
//            LessonRow(lesson: lessonToTestRow)            .environment(\.colorScheme, .light)
//        }
        LessonRow(lesson: lessonToTestRow)
            .previewLayout(.sizeThatFits)
    }
}
