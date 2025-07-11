//
//  ServiceListView.swift
//  Zuper-iOS Assignment
//
//  Created by Paranjothi Balaji on 11/07/25.
//


import SwiftUI
import Speech

struct ServiceListView: View {
    @StateObject private var viewModel = ServiceViewModel()
    @StateObject private var speechRecognizer = SpeechRecognizer()
    @State private var isListening = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Search", text: $viewModel.searchText)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                        
                        Button(action: {
                            toggleVoiceSearch()
                        }) {
                            Image(systemName: isListening ? "mic.fill" : "mic")
                                .foregroundColor(isListening ? .red : .gray)
                        }
                    }
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.top, 8)
                
                List {
                    ForEach(viewModel.filteredServices) { service in
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color(.systemBackground))
                                        .shadow(color: Color.black.opacity(0.05), radius: 1, x: 0, y: 1)
                                )
                            
                            NavigationLink(destination: ServiceDetailView(service: service)) {
                                EmptyView()
                            }
                            .opacity(0)
                            
                            ServiceRowView(service: service)
                                .padding()
                        }
                        .padding(.vertical, 6)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                    }
                }
                .listStyle(.plain)
                .refreshable {
                    try? await Task.sleep(nanoseconds: 2_000_000_000)
                    viewModel.fetchServices()
                }
            }
            .navigationTitle("Services")
            .navigationBarTitleDisplayMode(.inline)
            
            .onChange(of: speechRecognizer.transcribedText) { newValue in
                viewModel.searchText = newValue
            }
        }
    }
    
    private func toggleVoiceSearch() {
        isListening.toggle()
        if isListening {
            speechRecognizer.startTranscribing()
        } else {
            speechRecognizer.stopTranscribing()
        }
    }
}
