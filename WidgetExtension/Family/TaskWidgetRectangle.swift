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
                .padding(.bottom, 0)
            if #available(iOS 16.0, *) {
                Grid(
                    alignment: .leading,
                    verticalSpacing: 0
                ) {
                    GridRow {
                        HStack {
                            Text("요청")
                                .font(.subheadline)
                            
                            Text("10")
                                .font(.subheadline)
                        }
                        .gridColumnAlignment(.listRowSeparatorLeading)
                        
                        HStack {
                            Text("진행")
                                .font(.subheadline)
                            
                            Text("12")
                                .font(.subheadline)
                        }
                        .gridColumnAlignment(.listRowSeparatorTrailing)
                    }
                    
                    GridRow {
                        HStack {
                            Text("피드백")
                                .font(.subheadline)
                            
                            Text("30")
                                .font(.subheadline)
                                .padding(.leading, 2)
                    
                        }
                    }

                }
                .padding(.leading, 6)
                .padding(.trailing, 4)
                .overlay(
                         Rectangle()
                             .frame(width: 2)
                             .foregroundColor(.black),
                         alignment: .leading
                )
            } else {
                // Fallback on earlier versions
            }
        }
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
