//
//  ServiceViewModel.swift
//  Zuper-iOS Assignment
//
//  Created by Paranjothi Balaji on 11/07/25.
//

import Foundation
import Combine

class ServiceViewModel: ObservableObject {
    @Published var allServices: [Service] = []
    @Published var searchText: String = ""
    @Published var filteredServices: [Service] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchServices()
        setupSearch()
    }
    
    func fetchServices() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.allServices = SampleData.generateServices().sorted { $0.title.lowercased() < $1.title.lowercased() }
            self.filteredServices = self.allServices
        }
    }
    
    
    private func setupSearch() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] text in
                guard let self = self else { return }
                
                if text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    self.filteredServices = self.allServices
                } else {
                    self.filteredServices = self.allServices.filter {
                        $0.title.localizedCaseInsensitiveContains(text) ||
                        $0.customerName.localizedCaseInsensitiveContains(text) ||
                        $0.description.localizedCaseInsensitiveContains(text)
                    }
                    .sorted { $0.title.lowercased() < $1.title.lowercased() }
                }
            }
            .store(in: &cancellables)
    }
    
    
}

