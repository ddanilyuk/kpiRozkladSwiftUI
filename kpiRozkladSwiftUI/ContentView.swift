//
//  ContentView.swift
//  kpiRozkladSwiftUI
//
//  Created by Денис Данилюк on 26.06.2020.
//

import SwiftUI

let lessonToTest = Lesson(id: "1", dayNumber: "1", groupID: "123", dayName: DayName.mounday, lessonName: "SwiftUI tutorials", lessonFullName: "SwiftUI tutorials apple", lessonNumber: "1", lessonRoom: "1", lessonType: .лаб, teacherName: "TeacherName", lessonWeek: "1", timeStart: "08:30", timeEnd: "10:25", rate: "1", teachers: [], rooms: [], groups: [])

var lessons: [Lesson] = Array(repeating: lessonToTest, count: 1)



struct ContentView: View {
    
    init() {
        UITableView.appearance().backgroundColor = .secondarySystemFill
    }
    
    @State var lessons: [Lesson] = []
    
    var body: some View {

        NavigationView {

            LessonsList(lessons: lessons)
                .listStyle(InsetGroupedListStyle())
                .navigationBarTitle(Text("ІВ-82"))
                .onAppear {
                    getGroups(complition: { lessons in
                        self.lessons = lessons
                    })
                }

        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        ForEach(["iPhone X", "iPhone 8"], id: \.self) { deviceName in
        ContentView()
            .environment(\.colorScheme, .light)
//        }
//            .preferredColorScheme(.)
    }
}
