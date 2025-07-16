//
//  PlantViewModel.swift
//  Sunflower-ios
//
//  Created by Devender Sinhg Parihar on 6/16/25.
//

import Foundation

class PlantViewModel: ObservableObject {
    @Published var plantList: [Plant]?
    var isLoaded: Bool =  false
    
    func loadPlants() {
        guard !isLoaded else { return }
        isLoaded = true
        guard let url = Bundle.main.url(forResource: "plants", withExtension: "json") else {
            print("❌ Failed to find plants.json in bundle.")
            plantList = []
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let decodedPlants = try JSONDecoder().decode([Plant].self, from: data)
            plantList = decodedPlants
        } catch {
            print("❌ Error loading or decoding plants.json: \(error.localizedDescription)")
            plantList = []
        }
    }
}

