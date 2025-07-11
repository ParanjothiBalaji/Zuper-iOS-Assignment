//
//  ServiceDetailView.swift
//  Zuper-iOS Assignment
//
//  Created by Paranjothi Balaji on 11/07/25.
//


import SwiftUICore
import SwiftUI

struct ServiceDetailView: View {
    let service: Service

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                MapView()
                    .frame(height: 200)
                    .cornerRadius(15)
                    .padding(.horizontal, 20)
                
                HStack {
                        Text(service.title)
                        .font(.title)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.trailing)
                    
                    Spacer()
                    
                    HStack(spacing: 4) {
                        Image(systemName: "line.3.horizontal")
                            .font(.caption2)
                        Text(service.status.rawValue)
                            .font(.caption2)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(statusColor(service.status).opacity(0.15))
                    .foregroundColor(statusColor(service.status))
                    .cornerRadius(6)
                }
                .padding(.horizontal)

                Group {
                    DetailRow(title: "Customer", value: service.customerName, icon: "person.circle")
                    DetailRow(title: "Description", value: service.description, icon: "doc.text")
                    DetailRow(title: "Scheduled Time", value: DateFormatterHelper.smartDateFormat(from: service.scheduledDate), icon: "calendar")
                    DetailRow(title: "Location", value: service.location, icon: "mappin.and.ellipse")
                    DetailRow(title: "Service Notes", value: service.serviceNotes, icon: "note.text")
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("Service Detail")
        .navigationBarTitleDisplayMode(.inline)
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

struct DetailRow: View {
    let title: String
    let value: String
    let icon: String

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 20)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.black)
                Text(value)
                    .font(.caption)
                    .foregroundColor(.gray)

            }
        }
    }
}
