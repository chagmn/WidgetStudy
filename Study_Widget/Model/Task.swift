//
//  Task.swift
//  Study_Widget
//
//  Created by ChangMin on 2022/10/31.
//

import Foundation

struct Task {
    let status: TaskStatus
    let title: String
    let assign: [String]
    let startDate: Date
    let endDate: Date
    let progressRate: Int
    let priority: TaskPriority
}


enum TaskStatus {
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
