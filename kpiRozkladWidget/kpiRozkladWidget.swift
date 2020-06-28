//
//  kpiRozkladWidget.swift
//  kpiRozkladWidget
//
//  Created by Денис Данилюк on 27.06.2020.
//

import WidgetKit
import SwiftUI
import Intents
import CoreData

struct Provider: TimelineProvider {
    
    var managedObjectContext : NSManagedObjectContext
    
    init(context : NSManagedObjectContext) {
        self.managedObjectContext = context
    }
    
    let groupID = "group.ddanilyuk.kpiRozkladSwiftUI"
    
    typealias Entry = SimpleEntry
    
//    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
        entity: LessonData.entity(),
        
        sortDescriptors: [
            NSSortDescriptor(keyPath: \LessonData.lessonID, ascending: true)
        ]
    ) public var lessonsCoreData: FetchedResults<LessonData>

    func snapshot(with context: Context, completion: @escaping (SimpleEntry) -> ()) {

        let entry = SimpleEntry(date: Date(), lessons: Lesson.defaultArratOfLesson)
        completion(entry)
    }
    
    
    func timeline(with context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        var lessonsFromCoreData: [Lesson] = []
        
//        print(lessonsCoreData.count)
//        _ = lessonsCoreData.map { lessonData in
//            lessonsFromCoreData.append(lessonDataToLesson(lessonData: lessonData))
//        }
        
        let entries = [SimpleEntry(date: Date(), lessons: lessonsFromCoreData)]

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
}


struct SimpleEntry: TimelineEntry {
    public let date: Date
    let lessons: [Lesson]

}

struct PlaceholderView : View {
    var body: some View {
        WidgetView(lessons: [Lesson.defaultLesson])
//        LessonRow(lesson: lessonToTest)
//        WidgetView(lessons: lessonsTESTWidget)
    }
}


struct kpiRozkladWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        WidgetView(lessons: entry.lessons)
    }
}

@main
struct kpiRozkladWidget: Widget {
    private let kind: String = "kpiRozkladWidget"

    public var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider(context: persistentContainer.viewContext), placeholder: PlaceholderView()) { entry in
            kpiRozkladWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Kpi Rozklad Widget")
        .description("Widget with your shedule")
        .supportedFamilies([.systemMedium])
    }
    
    var persistentContainer: NSPersistentContainer = {

        let container = NSCustomPersistentContainer(name: "kpiRozklad")
        
        
//        let persistentContainer = NSPersistentContainer(name: "Collect")
//        let storeURL = URL.storeURL(for: "group.ddanilyuk.kpiRozkladSwiftUI", databaseName: "Lessons")
//        let storeDescription = NSPersistentStoreDescription(url: storeURL)
//        container.persistentStoreDescriptions = [storeDescription]
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}

struct kpiRozkladWidget_Previews: PreviewProvider {
    static var previews: some View {
        WidgetView(lessons: Lesson.defaultArratOfLesson)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
