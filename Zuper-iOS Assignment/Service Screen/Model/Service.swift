//
//  Service.swift
//  Zuper-iOS Assignment
//
//  Created by Paranjothi Balaji on 11/07/25.
//

import Foundation

public struct Service: Identifiable, Codable, Hashable {
    public let id: String
    public let title: String
    public let customerName: String
    public let description: String
    public let status: ServiceStatus
    public let priority: Priority
    public let scheduledDate: String
    public let location: String
    public let serviceNotes: String
    
    public init(
        id: String,
        title: String,
        customerName: String,
        description: String,
        status: ServiceStatus,
        priority: Priority,
        scheduledDate: String,
        location: String,
        serviceNotes: String
    ) {
        self.id = id
        self.title = title
        self.customerName = customerName
        self.description = description
        self.status = status
        self.priority = priority
        self.scheduledDate = scheduledDate
        self.location = location
        self.serviceNotes = serviceNotes
    }
}

public enum ServiceStatus: String, CaseIterable, Codable {
    case active = "Active"
    case scheduled = "Scheduled"
    case completed = "Completed"
    case inProgress = "In Progress"
    case urgent = "Urgent"
}

public enum Priority: String, CaseIterable, Codable {
    case low = "Low"
    case medium = "Medium"
    case high = "High"
    case critical = "Critical"
}
