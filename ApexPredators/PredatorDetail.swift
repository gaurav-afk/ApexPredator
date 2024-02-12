//
//  PredatorDetail.swift
//  ApexPredators
//
//  Created by Gaurav Rawat on 2024-02-11.
//

import SwiftUI

struct PredatorDetail: View {
    var predator: ApexPredator
    
    var body: some View {
        GeometryReader{ geo in
            ScrollView{
                ZStack(alignment: .bottomTrailing){
                    //Background image
                    Image(predator.type.rawValue)
                        .resizable()
                        .scaledToFit()
                    
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
                
                // Current location
                
                // Appears in
                
                // Movie moments
                
                //Link to webpage
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    PredatorDetail(predator: Predators().allApexPredators[2])
}
