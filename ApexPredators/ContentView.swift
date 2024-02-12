//
//  ContentView.swift
//  ApexPredators
//
//  Created by Gaurav Rawat on 2024-02-11.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var predators = Predators()
    @State var searchText = ""
    @State var alphabetical = false
    @State var currentSelection = PredatorType.all
    
    var filteredDinos: [ApexPredator]{
        predators.filter(by: currentSelection)
        predators.sort(by: alphabetical)
        return predators.search(for: searchText)
    }
    
    var body: some View {
        NavigationStack {
            List(filteredDinos){predator in
                NavigationLink{
                    PredatorDetail(predator: predator)
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
                            .foregroundColor(.orange)
                            .fontWeight(.bold)
                            .symbolEffect(.bounce, value: alphabetical)
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
                            .foregroundColor(.orange)
                            .fontWeight(.bold)
                    }
                }
            }
        }
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ContentView()
}
