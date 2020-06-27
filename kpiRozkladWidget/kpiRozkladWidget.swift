//
//  kpiRozkladWidget.swift
//  kpiRozkladWidget
//
//  Created by Денис Данилюк on 27.06.2020.
//

import WidgetKit
import SwiftUI
import Intents


struct Provider: TimelineProvider {
    
    let groupID = "group.ddanilyuk.kpiRozkladSwiftUI"
    
    typealias Entry = SimpleEntry

    func snapshot(with context: Context, completion: @escaping (SimpleEntry) -> ()) {

        let entry = SimpleEntry(date: Date(), lessons: Lesson.defaultArratOfLesson)
        completion(entry)
    }
    
    
    func timeline(with context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let entries = [SimpleEntry(date: Date(), lessons: Lesson.defaultArratOfLesson)]

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
        StaticConfiguration(kind: kind, provider: Provider(), placeholder: PlaceholderView()) { entry in
            kpiRozkladWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Kpi Rozklad Widget")
        .description("Widget with your shedule")
        .supportedFamilies([.systemMedium])

    }
}

struct kpiRozkladWidget_Previews: PreviewProvider {
    static var previews: some View {
        WidgetView(lessons: Lesson.defaultArratOfLesson)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
