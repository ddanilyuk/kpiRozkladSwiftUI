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
                    .frame(minWidth: 45, idealWidth: 45, maxWidth: 50, alignment: .center)
                    .font(.footnote)

                Text(lesson.lessonName)
                    .lineLimit(1)
                    .font(.title2)
                
                
                Spacer()
            }
                .padding(.bottom, 0)
            
            
            HStack(alignment: .center) {
                Text("")
                    .padding(.leading, 3)
                    .frame(minWidth: 45, idealWidth: 45, maxWidth: 50, alignment: .center)

                Text(lesson.teacherName)
                    .font(.subheadline)
                
                Spacer()
            }
            
            HStack(alignment: .center) {
                Text(lesson.timeEnd.stringTime)
                    .padding(.leading, 3)
                    .frame(minWidth: 45, idealWidth: 45, maxWidth: 50, alignment: .center)
                    .font(.footnote)


                Text(lesson.lessonRoom + " " + lesson.lessonType.rawValue)
                    .font(.subheadline)

                
                Spacer(minLength: 0)
                
                HStack(spacing: 4.0) {
                    Spacer()
                    Text("через")
                    Text(getDate(lesson: lesson).dateStart, style: .timer)
                        .padding(.trailing, 10)
//                        .frame(width: 80)
                    
                }
                .frame(width: 150)

                .font(.system(.footnote, design: .monospaced))//                Spacer()
//                    .padding(.trailing, 10)
                
            }

        }

    }
    
    
    
}





struct LessonRow_Previews: PreviewProvider {
    static var previews: some View {
//        ForEach(["iPhone X", "iPhone 8"], id: \.self) { deviceName in
//            LessonRow(lesson: lessonToTestRow)            .environment(\.colorScheme, .light)
//        }
        LessonRow(lesson: Lesson.defaultLesson)
            .previewLayout(.sizeThatFits)
    }
}
