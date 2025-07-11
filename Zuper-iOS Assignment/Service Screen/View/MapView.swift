//
//  MapView.swift
//  Zuper-iOS Assignment
//
//  Created by Paranjothi Balaji on 11/07/25.
//


import MapKit
import SwiftUICore
import _MapKit_SwiftUI

struct MapView: View {
    var body: some View {
        Map(coordinateRegion: .constant(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 47.6097, longitude: -122.3331),
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
        ), annotationItems: [MarkerLocation()]) { location in
            MapMarker(coordinate: location.coordinate)
        }
    }
}

struct MarkerLocation: Identifiable {
    let id = UUID()
    let coordinate = CLLocationCoordinate2D(latitude: 47.6097, longitude: -122.3331)
}

