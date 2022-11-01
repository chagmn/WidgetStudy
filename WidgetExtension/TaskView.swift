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
                .frame(width: 8)
            
            Text(task.title)
                .font(.footnote)
        }
    }
    
    func color() -> Color {
        switch task.status {
        case .request:
            return .blue
        case .progress:
            return .green
        default:
            return .gray
        }
    }
}

struct TaskView_Previews: PreviewProvider {
    static let task: Task = Task(status: .complete, title: "임시", assign: [])
    
    static var previews: some View {
        TaskView(task: task)
    }
}
