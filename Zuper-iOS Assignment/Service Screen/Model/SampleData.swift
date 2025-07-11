//
//  SampleData.swift
//  Zuper-iOS Assignment
//
//  Created by Paranjothi Balaji on 11/07/25.
//

import Foundation

public struct SampleData {
    
    private static let serviceTypes = [
        "Interior Design Project",
        "Home Cleaning Service",
        "HVAC Maintenance",
        "Garden Landscaping",
        "Plumbing Repair",
        "Electrical Installation",
        "Pool Maintenance",
        "Security System Setup",
        "Carpet Cleaning",
        "Window Cleaning",
        "Pest Control Service",
        "Appliance Repair",
        "Painting Service",
        "Roofing Inspection",
        "Solar Panel Installation",
        "Garage Door Repair",
        "Fence Installation",
        "Driveway Cleaning",
        "Tree Trimming",
        "Gutter Cleaning"
    ]
    
    private static let customerNames = [
        "ABC Manufacturing",
        "Johnson Residence",
        "Tech Solutions Inc",
        "Smith Family Home",
        "Downtown Office Complex",
        "Green Valley Apartments",
        "Riverside Medical Center",
        "Sunset Retail Plaza",
        "Metro Business Park",
        "Oakwood Elementary School",
        "City Hall Building",
        "Hillside Shopping Center",
        "Parkview Restaurant",
        "Elite Fitness Gym",
        "Northside Auto Dealership",
        "Westfield Corporate Tower",
        "Lakeside Hotel & Spa",
        "University Campus",
        "Memorial Hospital",
        "Industrial Park Facility"
    ]
    
    private static let descriptions = [
        "Complete office space redesign with modern furniture and ergonomic workstations",
        "Weekly deep cleaning including kitchen, bathrooms, and common areas",
        "Quarterly maintenance check for HVAC system including filter replacement",
        "Complete backyard renovation with new plants, pathways, and landscaping",
        "Emergency leak repair in basement level with pipe replacement",
        "Install electrical systems for new office building expansion",
        "Monthly pool cleaning and chemical balancing service",
        "Install and configure security cameras and alarm systems",
        "Professional carpet cleaning for entire office floor with stain removal",
        "Window cleaning service for high-rise building exterior and interior",
        "Comprehensive pest control treatment and prevention plan",
        "Repair and maintenance of kitchen appliances and HVAC equipment",
        "Interior and exterior painting with premium quality materials",
        "Annual roofing inspection and minor repair assessment",
        "Solar panel installation with energy efficiency consultation",
        "Garage door motor replacement and safety inspection",
        "Wooden fence installation with weather-resistant materials",
        "Pressure washing of driveway and walkway areas",
        "Tree trimming and branch removal for safety compliance",
        "Gutter cleaning and debris removal with downspout check"
    ]
    
    private static let locations = [
        "123 Business Avenue, Suite 456",
        "789 Residential Street",
        "456 Corporate Drive",
        "321 Industrial Boulevard",
        "654 Commercial Plaza",
        "987 Healthcare Way",
        "147 Education Lane",
        "258 Retail Center",
        "369 Medical District",
        "741 Technology Park",
        "852 Shopping Complex",
        "963 Office Tower",
        "159 Apartment Complex",
        "357 Hotel District",
        "486 Restaurant Row",
        "729 Fitness Center",
        "618 Auto Plaza",
        "273 Campus Drive",
        "495 Hospital Road",
        "516 Manufacturing Zone"
    ]
    
    private static let serviceNotes = [
        "All required equipment and materials will be provided by our team",
        "Customer will provide access key and disable security system",
        "Service requires power shutdown during installation period",
        "Weather-dependent service, may reschedule if conditions are poor",
        "Please ensure parking space is available for service vehicle",
        "Homeowner should remove personal items from work area",
        "Service includes cleanup and disposal of old materials",
        "Technician will call 30 minutes before arrival time",
        "Annual service contract eligible for priority scheduling",
        "Emergency service available 24/7 for urgent issues",
        "Warranty period applies to all parts and labor provided",
        "Service may require temporary water/power disconnection",
        "Please have pets secured during service appointment",
        "Multiple visits may be required for complex installations",
        "Service includes detailed inspection report and recommendations"
    ]
    
    public static func generateServices(count: Int = 15) -> [Service] {
        var services: [Service] = []
        let calendar = Calendar.current
        let now = Date()
        
        // Track used combinations to avoid duplicates
        var usedCombinations: Set<String> = []
        
        for i in 0..<count {
            let id = String(format: "%03d", i + 1)
            
            // Generate unique combination
            var title: String
            var customer: String
            var combination: String
            
            repeat {
                title = serviceTypes.randomElement()!
                customer = customerNames.randomElement()!
                combination = "\(title)-\(customer)"
            } while usedCombinations.contains(combination)
            
            usedCombinations.insert(combination)
            
            let description = descriptions.randomElement()!
            let status = ServiceStatus.allCases.randomElement()!
            let priority = Priority.allCases.randomElement()!
            let location = locations.randomElement()!
            let notes = serviceNotes.randomElement()!
            
            // Generate diverse date strings
            let scheduledDateString: String
            let randomValue = Int.random(in: 1...10)
            
            let baseDate: Date
            switch randomValue {
            case 1...2: // Today (20%)
                baseDate = calendar.startOfDay(for: now)
            case 3: // Tomorrow (10%)
                baseDate = calendar.date(byAdding: .day, value: 1, to: calendar.startOfDay(for: now))!
            case 4: // Yesterday (10%)
                baseDate = calendar.date(byAdding: .day, value: -1, to: calendar.startOfDay(for: now))!
            case 5...7: // Next few days (30%)
                let daysAhead = Int.random(in: 2...7)
                baseDate = calendar.date(byAdding: .day, value: daysAhead, to: calendar.startOfDay(for: now))!
            case 8...9: // Past dates (20%)
                let daysBehind = Int.random(in: 2...30)
                baseDate = calendar.date(byAdding: .day, value: -daysBehind, to: calendar.startOfDay(for: now))!
            default: // Future dates (10%)
                let daysAhead = Int.random(in: 8...60)
                baseDate = calendar.date(byAdding: .day, value: daysAhead, to: calendar.startOfDay(for: now))!
            }
            
            // Add random time (8 AM to 6 PM, 15-minute intervals)
            let randomHour = Int.random(in: 8...18)
            let randomMinute = [0, 15, 30, 45].randomElement()!
            let finalDate = calendar.date(byAdding: .hour, value: randomHour, to: baseDate)!
                .addingTimeInterval(TimeInterval(randomMinute * 60))
            
            // Convert to ISO 8601 string
            let formatter = ISO8601DateFormatter()
            scheduledDateString = formatter.string(from: finalDate)
            
            let service = Service(
                id: id,
                title: title,
                customerName: customer,
                description: description,
                status: status,
                priority: priority,
                scheduledDate: scheduledDateString,
                location: location,
                serviceNotes: notes
            )
            
            services.append(service)
        }
        
        // Sort by date (convert string back to Date for sorting)
        let formatter = ISO8601DateFormatter()
        return services.sorted { service1, service2 in
            let date1 = formatter.date(from: service1.scheduledDate) ?? Date()
            let date2 = formatter.date(from: service2.scheduledDate) ?? Date()
            return date1 < date2
        }
    }
    
    public static func generateSingleService() -> Service {
        return generateServices(count: 1).first!
    }
}
