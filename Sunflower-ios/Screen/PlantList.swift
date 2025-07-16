//
//  PlantList.swift
//  Sunflower-ios
//
//  Created by Devender Sinhg Parihar on 6/15/25.
//

import Foundation
import SwiftUI

struct PlantList: View {
    var viewModel: PlantViewModel
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        ScrollView {
            let plants = viewModel.plantList ?? []
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(plants) { plant in
                    PlantCardView(plant: plant)
                } 
            }.padding(20)
        }.onAppear {
            viewModel.loadPlants()
        }
    }
}
