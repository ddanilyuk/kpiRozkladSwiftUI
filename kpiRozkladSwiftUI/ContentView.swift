//
//  ContentView.swift
//  kpiRozkladSwiftUI
//
//  Created by Денис Данилюк on 26.06.2020.
//

import SwiftUI

//let lessonToTest = Lesson(id: "1", dayNumber: "1", groupID: "123", dayName: DayName.mounday, lessonName: "SwiftUI tutorials", lessonFullName: "SwiftUI tutorials apple", lessonNumber: "1", lessonRoom: "1", lessonType: .лаб, teacherName: "TeacherName", lessonWeek: "1", timeStart: "08:30", timeEnd: "10:25", rate: "1", teachers: [], rooms: [], groups: [])
//
//var lessons: [Lesson] = Array(repeating: lessonToTest, count: 1)




struct ContentView: View {
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .systemBlue
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.systemBlue], for: .normal)
        UITableView.appearance().backgroundColor = .secondarySystemBackground
    }
    
    var body: some View {

        TabView {
            LessonsView()
            .tabItem {
                Image(systemName: "list.bullet")
                Text("Розклад")
            }
            
            SettingsView()
            .tabItem {
                Image(systemName: "gear")
                Text("Налаштування")
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
