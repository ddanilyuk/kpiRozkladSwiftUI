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
    
    @State var lessons: [Lesson] = []
    @State var week: Int = 1
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .systemBlue
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.systemBlue], for: .normal)
        UITableView.appearance().backgroundColor = .secondarySystemBackground
    }
    
    var body: some View {

        TabView {
            NavigationView {

                LessonsList(lessons: lessons, week: week)
                    
                    .navigationBarTitle(Text("ІВ-82"))
                    
                    
                    .navigationBarItems(trailing:
                        Picker("", selection: $week) {
                            Text("1").tag(1)
                            Text("2").tag(2)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 120, height: .none, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    )
                    
                    .onAppear {
                        getGroups(complition: { lessons in
                            self.lessons = lessons
                        })
                    }
            }
            
            .tabItem {
                Image(systemName: "list.bullet")
                Text("Розклад")
            }
            
            NavigationView {
                ZStack {
                    Color.init(UIColor.secondarySystemBackground).edgesIgnoringSafeArea(.all)
                    
                    Text("Settings")
                    
                }
                
                
                    .navigationBarTitle(Text("Налаштування"))
            }
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
