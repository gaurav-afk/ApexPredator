//
//  PredatorMap.swift
//  ApexPredators
//
//  Created by Gaurav Rawat on 2024-02-12.
//

import SwiftUI
import MapKit

struct PredatorMap: View {
    @State var position: MapCameraPosition
    @State var isSatelliteMap: Bool
    
    let predators = Predators()
    
    var body: some View {
        Map(position: $position){
            ForEach(predators.apexPredators){predator in
            
                Annotation(predator.name, coordinate: predator.location){
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .shadow(color: .white, radius: 3)
                        .scaleEffect(x: -1)
                }
            }
        }
        .mapStyle( isSatelliteMap ? .imagery(elevation: .realistic) : .standard(elevation: .realistic))
        .overlay(alignment: .bottomTrailing){
            Button{
                isSatelliteMap.toggle()
            }label: {
                Image(systemName: isSatelliteMap ? "map.circle" : "map.circle.fill")
                    .font(.largeTitle)
                    .imageScale(.large)
                    .background(.ultraThinMaterial)
                    .clipShape(.circle)
                    .padding([.bottom, .trailing], 15)
            }
        }
        .toolbarBackground(.automatic)
    }
}

#Preview {
    PredatorMap(
        position: .camera(MapCamera(centerCoordinate: Predators().apexPredators[2].location,
                                            distance: 1000,
                                            heading: 250,
                                            pitch: 80)),
        isSatelliteMap: true)
}
