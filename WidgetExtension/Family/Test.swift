//
//  Test.swift
//  Study_Widget
//
//  Created by ChangMin on 2022/11/08.
//

import SwiftUI

struct Test: View {
    var tasks: [Task]
    
    var body: some View {
        VStack() {
            HStack() {
                ForEach(0...6, id:\.self) { index in
                    DayView(index)
                }
            }
            .padding([.leading, .trailing])
            .background(Color.yellow)
            
            Divider()
                .padding([.leading, .trailing], 8)
                .padding([.top, .bottom], 0)
            
            GroupBox(
                label: Label("마감 업무", systemImage: "list.clipboard")
                    .padding(.top, -12)
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
                    
                    if tasks.count == 0 {
                        Text("마감 업무가 없습니다.")
                            .font(.caption)
                            .padding([.leading], 8)
                    }
                }
            }
            .groupBoxStyle(PlainGroupBoxStyle())
            .padding([.leading, .trailing], 8)
            .padding(.bottom, -8)
            
          
        }
    }
}

struct DayView: View {
    let index: Int
    
    init(_ index: Int) {
        self.index = index
    }
    
    var body: some View {
        let weeks = self.getWeeks()
        
        VStack(
            alignment: .center
        ) {

            Text("\(Calendar.current.component(.day, from: weeks[index]))")
                .font(.caption)
                .frame(width: 44, height: 44)
                .border(.green, width: 1)
                .cornerRadius(22)

        }
        
    }
        
    func getWeeks() -> [Date] {
        var calendar = Calendar.autoupdatingCurrent
        calendar.firstWeekday = 1
        let today = calendar.startOfDay(for: Date())
        var week = [Date]()
        if let weekInterval = calendar.dateInterval(of: .weekOfYear, for: today) {
            for i in 0...6 {
                if let day = calendar.date(byAdding: .day, value: i, to: weekInterval.start) {
                    week += [day]
                }
            }
        }
        
        return week
    }
}

struct Test_Previews: PreviewProvider {
    static let tasks: [Task] = [
//        Task(status: .request, title: "임시", assign: [])
        ]
    
    static var previews: some View {
        Test(tasks: tasks)
    }
}
