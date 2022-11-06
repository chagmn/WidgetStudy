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
        VStack() {
            GroupBox(
                label: Label("마감 업무", systemImage: "list.clipboard")
            ) {
                LazyVStack(
                    alignment: .leading,
                    spacing: 8
                ) {
                    ForEach(Array(tasks.enumerated()), id: \.offset) { index, taskValue in
                        if index < 5 {
                            TaskView(task: taskValue)
                        }
                    }
                }
            }
            .groupBoxStyle(PlainGroupBoxStyle())
            .padding([.leading, .trailing], 8)
            .padding(.bottom, -8)
                
            Divider()
                .padding([.top, .bottom], 0)
            
            GroupBox(
                label: Label("우선 업무", systemImage: "light.beacon.max")
            ) {
                LazyVStack(
                    alignment: .leading,
                    spacing: 8
                ) {
                    ForEach(Array(priorityTasks.enumerated()), id: \.offset) { index, taskValue in
                        if index < 5 {
                            TaskView(task: taskValue)
                        }
                    }
                }
            }
            .groupBoxStyle(PlainGroupBoxStyle())
            .padding([.leading, .trailing], 8)
            .padding(.top, -8)
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
