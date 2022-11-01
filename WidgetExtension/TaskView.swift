//
//  TaskView.swift
//  WidgetExtensionExtension
//
//  Created by ChangMin on 2022/10/31.
//

import SwiftUI

struct TaskView: View {
//    @Binding var task: Task
    var task: Task
    
    var body: some View {
        HStack {
            Circle()
                .foregroundColor(color())
                .frame(width: 12)
            
            Text(task.title)
        }
    }
    
    func color() -> Color {
        switch task.status {
        case .request:
            return .blue
        case .progress:
            return .green
        case .feedback:
            return .orange
        case .complete:
            return Color(uiColor: .blue)
        case .hold:
            return Color(uiColor: .lightGray)
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static let task: Task = Task(status: .complete, title: "임시", assign: [], taskNum: 100)
    
    static var previews: some View {
        TaskView(task: task)
    }
}
