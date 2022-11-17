//
//  Test.swift
//  Study_Widget
//
//  Created by ChangMin on 2022/11/08.
//

import SwiftUI

struct TaskWidgetNewLarge: View {
    var tasks: [Task]
    
    var body: some View {
        VStack() {
            HStack() {
                ForEach(0...6, id:\.self) { index in
                    DayView(index)
                }
            }
            
            Divider()
                .padding([.leading, .trailing], 8)
                .padding([.top, .bottom], 0)
            
            GroupBox(
                label: Label("금일 마감 업무", systemImage: "list.clipboard")
                    .padding(.top, -12)
            ) {
                LazyVStack(
                    alignment: .leading,
                    spacing: 8
                ) {
                    ForEach(Array(tasks.enumerated()), id: \.offset) { index, taskValue in
                        if index < 10 && taskValue.status.rawValue < 3 {
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
            .padding(.bottom, -8)
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .top
        )
    }
}

struct DayView: View {
    let index: Int
    
    init(_ index: Int) {
        self.index = index
    }
    
    var body: some View {
        let weeks = self.getWeeks()
        let todayIndex = Calendar.current.component(.weekday, from: Date()) - 1
        
        VStack(
            alignment: .center
        ) {

            Text("\(Calendar.current.component(.day, from: weeks[index]))")
                .foregroundColor(index == 0 ? .red : index == 6 ? .blue : .black)
                .font(.caption)
            
            Text("\(Calendar.current.shortWeekdaySymbols[index])")
                .foregroundColor(index == 0 ? .red : index == 6 ? .blue : .black)
                .font(.caption2)
                
                
        }
        .frame(width: 36, height: 36)
        .background(
            todayIndex == index ? Color(uiColor: UIColor.systemGray4) : Color.clear
        )
        .cornerRadius(18)
        .overlay {
            RoundedRectangle(cornerRadius: 18)
                .stroke(.gray, lineWidth: 1)
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

struct TaskWidgetNewLarge_Previews: PreviewProvider {
    static let tasks: [Task] = [
//        Task(status: .request, title: "임시", assign: [])
        ]
    
    static var previews: some View {
        TaskWidgetNewLarge(tasks: tasks)
    }
}
