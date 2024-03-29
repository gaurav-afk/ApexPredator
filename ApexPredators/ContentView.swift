//
//  ContentView.swift
//  ApexPredators
//
//  Created by Gaurav Rawat on 2024-02-11.
//

import SwiftUI
import SwiftData
import MapKit

struct ContentView: View {
    var predators = Predators()
    @State var searchText = ""
    @State var alphabetical = false
    @State var currentSelection = PredatorType.all
    @State var currentMovieSelection = Movies.all
    
    var filteredDinos: [ApexPredator]{
        predators.filter(type: currentSelection, movie: currentMovieSelection)
        predators.sort(by: alphabetical)
        return predators.search(for: searchText)
    }
    
    
    var body: some View {
        NavigationStack {
            List{
                
                ForEach(filteredDinos){ predator in
                    NavigationLink{
                        PredatorDetail(predator: predator, position: .camera(MapCamera(centerCoordinate: predator.location, distance: 3000)))
                    }label: {
                        HStack{
                            Image(predator.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                            
                            VStack(alignment: .leading){
                                Text(predator.name)
                                    .fontWeight(.bold)
                                
                                Button{
                                    
                                }label: {
                                    Text(predator.type.rawValue.capitalized)
                                }
                                .font(.subheadline)
                                .buttonStyle(.borderedProminent)
                                .tint(predator.type.background)
                                .buttonBorderShape(.capsule)
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 13)
                                .padding(.vertical, 5)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Apex Predators")
            .searchable(text: $searchText)
            .autocorrectionDisabled()
            .animation(.default, value: searchText)
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    
                    Button{
                        withAnimation{
                            alphabetical.toggle()
                        }
                    }label: {
                        Image(systemName: alphabetical ? "film" : "textformat")
                            .fontWeight(.bold)
                            .fontWeight(.bold)
                            .foregroundColor(.orange)
                            .symbolEffect(.bounce, value: alphabetical)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing){
                    Menu{
                        Picker("MovieFilter", selection: $currentMovieSelection.animation()){
                            ForEach(Movies.allCases){ type in
                                Label(type.rawValue, systemImage: "")
                                    .font(.footnote)
                            }
                        }
                    } label: {
                        Image(systemName: "popcorn")
                            .fontWeight(.bold)
                            .foregroundColor(.orange)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing){
                    Menu{
                        Picker("Filter", selection: $currentSelection.animation()){
                            ForEach(PredatorType.allCases){ type in
                                Label(type.rawValue.capitalized, systemImage: type.icon)
                            }
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                            .fontWeight(.bold)
                            .foregroundColor(.orange)
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
