//
//  WidgetExtension.swift
//  WidgetExtension
//
//  Created by ChangMin on 2022/01/03.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: TimelineProvider {
    // 설정에서의 프리뷰 화면
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }
    
    // TimelineEntry에 들어있는 값을 표현해주는 부분
    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        var entries: [SimpleEntry] = []
        let currentDate = Date()
        
        // 3분마다 위젯 갱신
        for minuteOffset in 0 ..< 3 {
            let entryDate = Calendar.current.date(
                byAdding: .minute,
                value: minuteOffset,
                to: currentDate
            )!
            let entry = SimpleEntry(date: entryDate)
            
            entries.append(entry)
        }

        // policy에 따라 entries 값을 가지고 리로드 해주는 부분
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    // 갱신 전에 디폴트로 값을 보여주는 부분
    func placeholder(in context: Context) -> SimpleEntry {
        return SimpleEntry(date: Date())
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct TaskWidgetView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var family: WidgetFamily
    var tasks: [Task] = [
        Task(
            status: .request,
            title: "플로우 테크 세미나 준비",
            assign: ["나"]
        ),
        Task(
            status: .progress,
            title: "테크 세미나 피피티 자료 준비하기",
            assign: ["나"]
        ),
        Task(
            status: .feedback,
            title: "업무명의 길이가 길어진다면 어떻게 될까아아요?",
            assign: ["나"]
        ),
        Task(
            status: .complete,
            title: "이건 완료 업무",
            assign: ["나"]
        ),
        Task(
            status: .hold,
            title: "보류 업무",
            assign: ["나"]
        )
    ]
    
    var priorityTasks: [Task] = [
        Task(
            status: .request,
            title: "급한업무",
            assign: ["나"]
        ),
        Task(
            status: .progress,
            title: "테크 세미나 피피티 자료 준비하기",
            assign: ["나"]
        ),
        Task(
            status: .feedback,
            title: "업무명의 길이가 길어진다면 어떻게 될까아아요?",
            assign: ["나"]
        ),
        Task(
            status: .feedback,
            title: "업무명의 길이가 길어진다면 어떻게 될까아아요?",
            assign: ["나"]
        ),
        Task(
            status: .feedback,
            title: "업무명의 길이가 길어진다면 어떻게 될까아아요?",
            assign: ["나"]
        ),
        Task(
            status: .feedback,
            title: "업무명의 길이가 길어진다면 어떻게 될까아아요?",
            assign: ["나"]
        )
    ]
    
    var body: some View {
        switch family {
        case .systemMedium:
            TaskWidgetMedium(
                tasks: tasks
            )
            
        case .systemLarge:
            TaskWidgetLarge(
                tasks: tasks,
                priorityTasks: priorityTasks
            )

        default:
            Text("지원하지 않아요")
        }
    }
}

@main
struct WidgetExtension: Widget {
    private let kind: String = "WidgetExtension"
    
    // 위젯 설정에서 설정하는 부분
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: Provider()
        ) { entry in
            TaskWidgetView(entry: entry)
        }
        .configurationDisplayName("위젯 공부")
        .description("위젯 푹 찍먹")
        .supportedFamilies([.systemMedium,.systemLarge])
    }
}

struct WidgetExtension_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TaskWidgetView(
                entry: SimpleEntry(date: Date())
            )
            .previewContext(
                WidgetPreviewContext(family: .systemMedium)
            )
            .previewDisplayName("Medium Size")
            
            TaskWidgetView(
                entry: SimpleEntry(date: Date())
            )
            .previewContext(
                WidgetPreviewContext(family: .systemLarge)
            )
            .previewDisplayName("Large Size")
        }
    }
}
