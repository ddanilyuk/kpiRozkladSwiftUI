//
//  LessonsList.swift
//  kpiRozkladSwiftUI
//
//  Created by Денис Данилюк on 27.06.2020.
//

import SwiftUI
import CoreData

struct LessonsList: View {
    var week: Int
    
    @FetchRequest(
        entity: LessonData.entity(),
        
        sortDescriptors: [
            NSSortDescriptor(keyPath: \LessonData.lessonID, ascending: true)
        ]
    ) public var lessonsCoreData: FetchedResults<LessonData>
        
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State var normalLessons: [Int: [DayName: [Lesson]]] = [:]
    
    
    init(week: Int) {
        self.week = week
    }
    
    var body: some View {
        VStack {
            
            List {
                if let currentWeek = normalLessons[week] {
                    ForEach(currentWeek.keys.sorted(), id: \.self) { key in
                        let lessonsForToday = currentWeek[key]!
                        Section(header: Text(key.rawValue).foregroundColor(Color(.label))) {
                            ForEach(lessonsForToday) { lesson in
                                LessonRow(lesson: lesson)
                                    .padding(.leading, -10)
                            }
                            .onDelete { indexSet in
                                deleteMovie(at: indexSet, section: key)
                            }
                        }
                    }
                }
            }
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listStyle(InsetGroupedListStyle())

        }
        .onAppear {
            normalLessons = [:]
            var lessonsFromCoreData: [Lesson] = []
            _ = lessonsCoreData.map { lessonData in
                lessonsFromCoreData.append(lessonData.wrappedLesson)
            }
            normalLessons = makeLessonsShedule(lessons: lessonsFromCoreData)
            Lesson.defaultArratOfLesson = lessonsFromCoreData
        }
//        .onAppear {
//            getGroups(complition: { lessons in
//                updateCoreData(lessons: lessons, managedContext: managedObjectContext)
//            })
//        }
        
    }
    
    func deleteMovie(at offsets: IndexSet, section: DayName) {
        offsets.forEach { index in
            print("index", index)
            print("section", section.rawValue)
            let actualWeek = self.normalLessons[week]
//            let lesson =
//            let lesson = actualWeek[index.row]
//            self.managedObjectContext.delete(lesson)
        }
        saveContext()
    }

    
    func saveContext() {
        do {
            try managedObjectContext.save()
        } catch {
            print("Error saving managed object context: \(error)")
        }
    }
    
    func makeLessonsShedule(lessons: [Lesson]) -> [Int: [DayName: [Lesson]]] {
        let lessonsWeekFirst = lessons.filter{ return $0.lessonWeek == WeekType.first }
        let lessonsWeekSecond = lessons.filter{ return $0.lessonWeek == WeekType.second }
        
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
        LessonsList(week: 1)
    }
}
