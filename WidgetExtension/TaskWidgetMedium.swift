//
//  TaskWidgetMedium.swift
//  WidgetExtensionExtension
//
//  Created by ChangMin on 2022/11/04.
//

import SwiftUI

struct TaskWidgetMedium: View {
    var tasks: [Task]
    
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
                
                if tasks.count > 3{
                    Text("+\(tasks.count-3)개 업무가 금일 마감입니다.")
                        .font(.caption)
                        .padding([.leading], 8)
                }
            }
        }
        .groupBoxStyle(PlainGroupBoxStyle())
    }
}

struct PlainGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            configuration.label
            configuration.content
        }
        .padding(.all)

    }
}

struct TaskWidgetMedium_Previews: PreviewProvider {
    static let tasks: [Task] = [
        Task(status: .complete, title: "임시", assign: [])
        ]
    
    static var previews: some View {
        TaskWidgetMedium(tasks: tasks)
    }
}
