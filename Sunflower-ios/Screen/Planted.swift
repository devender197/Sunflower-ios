//
//  Planted.swift
//  Sunflower-ios
//
//  Created by Devender Sinhg Parihar on 6/30/25.
//

import Foundation
import SwiftUI
import SwiftData

struct Planted: View {
    // local database variables
    @Query private var plants: [Plant]
    
    var body: some View {
        
        ScrollView{
            if plants.isEmpty {
                VStack{
                    Text("Your garden is empty")
                        .font(.title)
                        .padding(.top, 20)
                        .padding(.bottom, 20)
                    
                    Button("Add plant"){
                        
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.capsule)
                    .tint(.green)
                    
                }
            } else {
                let columns = [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ]
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(plants) { plant in
                        PlantCardView(plant: plant)
                    }
                }.padding(20)
            }
        }
    }
}
