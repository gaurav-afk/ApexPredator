//
//  PredatorDetail.swift
//  ApexPredators
//
//  Created by Gaurav Rawat on 2024-02-11.
//

import SwiftUI
import MapKit

struct PredatorDetail: View {
    let predator: ApexPredator
    
    @State var position: MapCameraPosition
    
    var body: some View {
        GeometryReader{ geo in
            ScrollView{
                ZStack(alignment: .bottomTrailing){
                    //Background image
                    Image(predator.type.rawValue)
                        .resizable()
                        .scaledToFit()
                        .overlay{
                            LinearGradient(stops: [
                                Gradient.Stop(color: Color.clear, location: 0.8),
                                Gradient.Stop(color: Color.black, location: 1),
                            ], startPoint: .top, endPoint: .bottom)
                        }
                    
                    //Dino image
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width/1.5, height: geo.size.height/3)
                        .scaleEffect(x: -1)
                        .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 7)
                        .offset(y: 20)
                }
                
                
                
                // Dino name
                VStack(alignment: .leading){
                    Text(predator.name)
                    .font(.largeTitle)
                    
                    NavigationLink{
                        PredatorMap(position: .camera(MapCamera(centerCoordinate: predator.location,distance: 1000, heading: 250,pitch: 80)),
                                      isSatelliteMap: false)
                    }label: {
                        // Current location
                        Map(position: $position){
                            Annotation(predator.name, coordinate: predator.location){
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.largeTitle)
                                    .imageScale(.large)
                                    .symbolEffect(.pulse)
                            }
                            .annotationTitles(.hidden) // hides the name below annotation
                        }
                        .frame(height: 150)
                        .overlay(alignment: .trailing){
                            Image(systemName: "greaterthan")
                                .imageScale(.large)
                                .font(.title3)
                                .padding(.trailing, 5)
                        }
                        .overlay(alignment: .topLeading){
                            Text("Current location")
                                .padding([.leading, .bottom], 5)
                                .padding(.trailing, 8)
                                .background(.black.opacity(0.4))
                                .clipShape(.rect(bottomTrailingRadius: 15))
                        }
                        .clipShape(.rect(cornerRadius: 15))
                        
                    }
                    // Appears in
                    Text("Appears in: ")
                        .font(.title)
                        
                    
                    ForEach(predator.movies, id: \.self){ movie in
                        Text("• \(movie)")
                            .font(.subheadline)
                    }
                    
                    // Movie moments
                    Text("Movie Moments: ")
                        .padding(.top, 15)
                        .font(.title)
                    
                    ForEach(predator.movieScenes){ scene in
                        
                        Text(scene.movie)
                            .font(.title2)
                            .padding(.vertical, 1)
                        
                        Text("\(scene.sceneDescription)")
                            .font(.subheadline)
                            .padding(.bottom, 15)
                    }
                    
                    //Link to webpage
                    Text("Read more:")
                        .font(.caption)
                    
                    Link(predator.link, destination: URL(string: predator.link)!)
                        .font(.caption)
                        .foregroundColor(.blue)
                }
                .padding()
                .padding(.bottom, 50)
                .frame(width: geo.size.width, alignment: .leading)
                
            }
            .ignoresSafeArea()
        }
        .toolbarBackground(.automatic)
    }
}

#Preview {
    NavigationStack{
        PredatorDetail(predator: Predators().allApexPredators[2], position: .camera(MapCamera(centerCoordinate: Predators().apexPredators[2].location, distance: 3000)))
    }
}
