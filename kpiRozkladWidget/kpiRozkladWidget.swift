//
//  kpiRozkladWidget.swift
//  kpiRozkladWidget
//
//  Created by Денис Данилюк on 27.06.2020.
//

import WidgetKit
import SwiftUI
import CoreData


struct Provider: TimelineProvider {
    
    var managedObjectContext: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.managedObjectContext = context
    }
    
    typealias Entry = SimpleEntry

    func snapshot(with context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), lessons: Lesson.defaultArratOfLesson)
        completion(entry)
    }
    
    
    func timeline(with context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        guard let lessonsCoreData = try? managedObjectContext.fetch(NSFetchRequest<NSFetchRequestResult>(entityName: "LessonData")) as? [LessonData] else { return }
        
        var lessonsFromCoreData: [Lesson] = []
        
        lessonsFromCoreData.append(contentsOf: lessonsCoreData.map({
            $0.wrappedLesson
        }))
        
        let (dayNumberFromCurrentDate, currentWeekFromTodayDate) = getTimeAndDayNumAndWeekOfYear()
        
        
        let (firstNextLessonID, secondNextLessonID) = getNextTwoLessons(lessons: lessonsFromCoreData, dayNumberFromCurrentDate: dayNumberFromCurrentDate, currentWeekFromTodayDate: currentWeekFromTodayDate)
        
        var arrayWithLessonsToShow: [Lesson] = []
        
        if let firstLesson = lessonsFromCoreData.first(where: { return $0.id == firstNextLessonID }),
           let secondLesson = lessonsFromCoreData.first(where: { return $0.id == secondNextLessonID }) {
            arrayWithLessonsToShow = [firstLesson, secondLesson]
        }
//
//        let todayLessons = lessonsFromCoreData.filter { lesson in
//            return lesson.lessonWeek == currentWeekFromTodayDate && lesson.dayNumber == dayNumberFromCurrentDate
//        }
//
//        let lastLessonInDayOptional: Lesson? = lessonsFromCoreData.first { lesson -> Bool in
//            return lesson.id == todayLessons.last?.id
//        }
//
//        var index: Int = 0
//        if let lastLessonInDay = lastLessonInDayOptional {
//            index = lessonsFromCoreData.firstIndex(of: lastLessonInDay) ?? 0
//        }
//
//
//
//        print(todayLessons.count)
        
        let entries = [SimpleEntry(date: Date(), lessons: arrayWithLessonsToShow)]
        
        let date = arrayWithLessonsToShow[0].dayNumber == dayNumberFromCurrentDate ? getDate(lesson: arrayWithLessonsToShow[0]).dateEnd : Date.tomorrow
        
        let timeline = Timeline(entries: entries, policy: .after(date))
        completion(timeline)
    }
    
    
    func getNextTwoLessons(lessons: [Lesson], dayNumberFromCurrentDate: Int, currentWeekFromTodayDate: WeekType) -> (firstNextLessonID: Int, secondNextLessonID: Int) {
        
        // Init values
        var firstNextLessonID: Int = 0
        var secondNextLessonID: Int = 0

        let date = Date()
        
        for lessonIndex in 0..<lessons.count {
            let lesson = lessons[lessonIndex]
            let (currentLessonsDateStart, currentLessonsDateEnd) = getDate(lesson: lesson)
//            
//            print("---------------")
//            print(lesson)
//            print("date", date)
//            print("currentLessonsDateStart", currentLessonsDateStart)
//            print("currentLessonsDateEnd", currentLessonsDateEnd)
//            print("currentLessonsDateStart < date", currentLessonsDateStart < date)
//            print("(currentLessonsDateStart > date && currentLessonsDateEnd < date))", (currentLessonsDateStart > date && currentLessonsDateEnd < date))
//            print("full", (currentLessonsDateStart < date || (currentLessonsDateStart > date && currentLessonsDateEnd < date)) )


            if (currentLessonsDateStart > date || (currentLessonsDateStart < date && currentLessonsDateEnd > date)) && lesson.lessonWeek == currentWeekFromTodayDate && lesson.dayNumber == dayNumberFromCurrentDate {
                firstNextLessonID = lesson.id
                
                if lessonIndex != lessons.count + 1 {
                    secondNextLessonID = lessons[lessonIndex + 1].id
                } else {
                    secondNextLessonID = lessons[0].id
                }
                
                return (firstNextLessonID: firstNextLessonID, secondNextLessonID: secondNextLessonID)
            }
            
        }
        if firstNextLessonID == 0 && secondNextLessonID == 0 {
            if currentWeekFromTodayDate == .first {
                let firstNextLesson = lessons.first { lesson -> Bool in
                    return lesson.lessonWeek == .second
                }
                if let lesson = firstNextLesson {
                    let index = lessons.firstIndex(of: lesson) ?? 0
                    if index != lessons.count + 1 {
                        return (firstNextLessonID: lessons[index].id, secondNextLessonID: lessons[index + 1].id)
                    }
                    
                }
            } else if currentWeekFromTodayDate == .second {
                if lessons.count > 1 {
                    return (firstNextLessonID: lessons[0].id, secondNextLessonID: lessons[1].id)
                }
            }
        }
        
        return (firstNextLessonID: firstNextLessonID, secondNextLessonID: secondNextLessonID)
            
    }
    
    
    
    
    
}


struct SimpleEntry: TimelineEntry {
    public let date: Date
    public let lessons: [Lesson]

}

struct PlaceholderView : View {
    var body: some View {
        WidgetView(lessons: Lesson.defaultArratOfLesson)
    }
}


struct KpiRozkladWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        WidgetView(lessons: entry.lessons)
    }
}

@main
struct kpiRozkladWidget: Widget {
    private let kind: String = "kpiRozkladWidget"

    public var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind,
                            provider: Provider(context: persistentContainer.viewContext),
                            placeholder: PlaceholderView()
        ) { entry in
            KpiRozkladWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Kpi Rozklad Widget")
        .description("Widget with your shedule")
        .supportedFamilies([.systemMedium])
    }
    
    
    var persistentContainer: NSPersistentContainer = {
//        let container = NSCustomPersistentContainer(name: "kpiRozkladData")

        let container = NSPersistentContainer(name: "kpiRozkladData")
        let storeURL = URL.storeURL(for: "group.ddanilyuk.kpiRozkladSwiftUI", databaseName: "LessonsData")
        let storeDescription = NSPersistentStoreDescription(url: storeURL)
        container.persistentStoreDescriptions = [storeDescription]

        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

//var wrapper = Wrapper()
//
//struct Wrapper {
//    lazy var persistentContainer: NSPersistentContainer = {
//
//        let container = NSCustomPersistentContainer(name: "kpiRozkladData")
//
//
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        return container
//    }()
//}

struct kpiRozkladWidget_Previews: PreviewProvider {
    static var previews: some View {
        WidgetView(lessons: Lesson.defaultArratOfLesson)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
