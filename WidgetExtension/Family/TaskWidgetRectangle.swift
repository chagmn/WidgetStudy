//
//  TaskWidgetRectangle.swift
//  Study_Widget
//
//  Created by ChangMin on 2022/11/06.
//

import SwiftUI

struct TaskWidgetRectangle: View {
    var tasks: [Task]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("업무 현황")
                .font(.headline)
            if #available(iOS 16.0, *) {
                Grid(
                    alignment: .leading,
                    verticalSpacing: 4
                ) {
                    GridRow {
                        Text("요청")
                            .font(.subheadline)
                        
                        Text("\(tasks.count)건")
                            .gridColumnAlignment(.trailing)
                    }
                    
                    GridRow {
                        Text("진행")
                            .font(.subheadline)
                        
                        Text("13건")
                            .gridColumnAlignment(.trailing)
                    }
                    
                    GridRow {
                        Text("피드백")
                            .font(.subheadline)
                            .padding(.trailing, 4)
                        
                        Text("334건")
                            .gridColumnAlignment(.trailing)
                    }
                }
            } else {
                // Fallback on earlier versions
            }
        }
        .background(Color.yellow)
    }
    
    
    func Test() -> Int {
        return 10
    }
}

struct TaskWidgetCircular_Previews: PreviewProvider {
    static let tasks: [Task] = []
        
    static var previews: some View {
        TaskWidgetRectangle(tasks: tasks)
    }
}
