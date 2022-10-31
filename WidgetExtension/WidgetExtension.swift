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

// 실제 위젯을 표현하는 부분
struct WidgetExtensionEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack(
            alignment: .leading
        ) {
            Text("오늘 마감 업무")
                .font(.title3)
                .fontWeight(.bold)
                
            VStack(
                alignment: .leading,
                spacing: 8
            ){
                TaskView()
                TaskView()
            }
        }
        .padding(EdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 5))
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
            WidgetExtensionEntryView(entry: entry)
        }
        .configurationDisplayName("위젯 공부")
        .description("위젯 푹 찍먹")
        .supportedFamilies([.systemMedium,.systemLarge])
    }
}

struct WidgetExtension_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WidgetExtensionEntryView(
                entry: SimpleEntry(date: Date())
            )
            .previewContext(
                WidgetPreviewContext(family: .systemSmall)
            )
        }
    }
}
