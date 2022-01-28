//
//  WidgetExtension.swift
//  WidgetExtension
//
//  Created by ChangMin on 2022/01/03.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    // 갱신 전에 디폴트로 값을 보여주는 부분
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    // 설정에서의 프리뷰 화면
    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    // TimelineEntry에 들어있는 값을 표현해주는 부분
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

       
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        // policy에 따라 entries 값을 가지고 리로드 해주는 부분
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

// 실제 위젯을 표현하는 부분
struct WidgetExtensionEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        HStack {
            Text("현재 시각 :")
                .font(.system(size: 15))
            Text(entry.date, style: .time)
                .fontWeight(.medium)
                .font(.system(size: 14))
        }
    }
    
}

@main
struct WidgetExtension: Widget {
    let kind: String = "WidgetExtension"

    // 위젯 설정에서 설정하는 부분
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
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
            WidgetExtensionEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            WidgetExtensionEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
                .previewDisplayName("medium")
                .previewContext(WidgetPreviewContext(family: .systemMedium))
        }
    }
}
