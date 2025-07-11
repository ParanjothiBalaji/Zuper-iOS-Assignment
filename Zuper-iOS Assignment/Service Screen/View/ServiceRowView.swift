//
//  ServiceRowView.swift
//  Zuper-iOS Assignment
//
//  Created by Paranjothi Balaji on 11/07/25.
//


import SwiftUI

struct ServiceRowView: View {
    let service: Service

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            Spacer().frame(height: 0)

            HStack(alignment: .top) {
                Text(service.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(1)

                Spacer()

                Circle()
                    .fill(priorityColor(service.priority))
                    .frame(width: 8, height: 8)
                    .alignmentGuide(.top) { d in d[.top] }
            }

            Spacer().frame(height: 10)
            
            HStack(spacing: 4) {
                           Image(systemName: "person.circle")
                               .foregroundColor(.blue)
                               .font(.caption2)

                           Text(service.customerName)
                               .font(.caption)
                               .foregroundColor(.black)
                               .lineLimit(1)
                       }
            Spacer().frame(height: 5)

            HStack(alignment: .top, spacing: 4) {
                Image(systemName: "doc.text")
                    .foregroundColor(.blue)
                    .font(.caption2)
                    .padding(.top, 2)

                Text(service.description)
                    .font(.caption)
                    .foregroundColor(.black)
                    .lineLimit(2)
            }

            Spacer()

            HStack {
                HStack(spacing: 4) {
                    Image(systemName: "line.3.horizontal")
                    Text(service.status.rawValue)
                }
                .font(.caption2)
                .padding(.horizontal, 6)
                .padding(.vertical, 2)
                .background(statusColor(service.status).opacity(0.15))
                .foregroundColor(statusColor(service.status))
                .cornerRadius(5)

                Spacer()

                Text(DateFormatterHelper.smartDateFormat(from: service.scheduledDate))
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            .padding(.bottom, 0)
        }
        
    }

    private func priorityColor(_ priority: Priority) -> Color {
        switch priority {
        case .low: return .green
        case .medium: return .blue
        case .high: return .orange
        case .critical: return .red
        }
    }

    private func statusColor(_ status: ServiceStatus) -> Color {
        switch status {
        case .active: return .green
        case .scheduled: return .mint
        case .completed: return .gray
        case .inProgress: return .blue
        case .urgent: return .red
        }
    }
}
