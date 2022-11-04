//
//  TaskWidgetLarge.swift
//  Study_Widget
//
//  Created by ChangMin on 2022/11/04.
//

import SwiftUI

struct TaskWidgetLarge: View {
    var tasks: [Task]
    var priorityTasks: [Task]
    
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

struct TaskWidgetLarge_Previews: PreviewProvider {
    static let tasks: [Task] = [
        Task(status: .request, title: "임시", assign: [])
        ]
    static let priorityTasks: [Task] = [
        Task(status: .complete, title: "임시", assign: [])
        ]
    
    static var previews: some View {
        TaskWidgetLarge(tasks: tasks, priorityTasks: priorityTasks)
    }
}
