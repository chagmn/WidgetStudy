//
//  Task.swift
//  Study_Widget
//
//  Created by ChangMin on 2022/10/31.
//

import Foundation

struct Task: Hashable {
    let status: TaskStatus
    let title: String
    let assign: [String]
    let startDate: Date?
    let endDate: Date?
    let progressRate: Int?
    let priority: TaskPriority?
    
    init(status: TaskStatus, title: String, assign: [String], startDate: Date? = nil, endDate: Date? = nil, progressRate: Int? = 0, priority: TaskPriority? = .no) {
        self.status = status
        self.title = title
        self.assign = assign
        self.startDate = startDate
        self.endDate = endDate
        self.progressRate = progressRate
        self.priority = priority
    }
}


enum TaskStatus: Int {
    case request
    case progress
    case feedback
    case complete
    case hold
}

enum TaskPriority {
    case no
    case low
    case normal
    case high
    case urgent
}
