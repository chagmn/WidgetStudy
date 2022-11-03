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

// medium 사이즈 위젯 뷰
struct TaskWidgetMediumView : View {
    var entry: Provider.Entry
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
    var body: some View {
        GroupBox(
            label: Label("금일 마감 업무", systemImage: "list.clipboard")
        ) {
            LazyVStack(
                alignment: .leading,
                spacing: 8
            ) {
                ForEach(Array(tasks.enumerated()), id: \.offset) { index, taskValue in
                    if index < 3 {
                        TaskView(task: taskValue)
                    }
                }
                
                Text("+\(tasks.count-3)개 업무가 금일 마감입니다.")
                    .font(.caption)
                    .padding([.leading], 8)
            }
            .frame(
                maxHeight: .infinity,
                alignment: .topLeading
            )
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .top
        )
    }
}

// Large 사이즈 위젯 뷰
struct TaskWidgetLargeView : View {
    var entry: Provider.Entry
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
        )
    ]
    
    var body: some View {
        
        VStack {
            GroupBox(
                label: Label("마감 업무", systemImage: "list.clipboard")
            ) {
                LazyVStack(
                    alignment: .leading,
                    spacing: 8
                ) {
                    ForEach(Array(tasks.enumerated()), id: \.offset) { index, taskValue in
                        TaskView(task: taskValue)
                    }
                }
                .frame(
                    maxHeight: .infinity,
                    alignment: .topLeading
                )
            }
            .padding([.top, .leading, .trailing], 8)
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .top
            )
                        
            GroupBox(
                label: Label("이번주 우선 업무", systemImage: "list.clipboard")
            ) {
                LazyVStack(
                    alignment: .leading,
                    spacing: 8
                ) {
                    ForEach(Array(priorityTasks.enumerated()), id: \.offset) { index, taskValue in
                        TaskView(task: taskValue)
                    }
                }
            }
            .padding([.leading, .trailing, .bottom], 8)
            .frame(
                maxWidth: .infinity,
                maxHeight: .greatestFiniteMagnitude,
                alignment: .top
            )
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
            TaskWidgetMediumView(entry: entry)
        }
        .configurationDisplayName("위젯 공부")
        .description("위젯 푹 찍먹")
        .supportedFamilies([.systemMedium,.systemLarge])
    }
}

struct WidgetExtension_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TaskWidgetMediumView(
                entry: SimpleEntry(date: Date())
            )
            .previewContext(
                WidgetPreviewContext(family: .systemMedium)
            )
            
            TaskWidgetLargeView(
                entry: SimpleEntry(date: Date())
            )
            .previewContext(
                WidgetPreviewContext(family: .systemLarge)
            )
        }
    }
}
