//
//  PlantCardView.swift
//  Sunflower-ios
//
//  Created by Devender Sinhg Parihar on 6/15/25.
//

import Foundation
import SwiftUI

struct PlantCardView: View {
    let plant: Plant
    var body: some View {
        NavigationLink(destination: PlantDetailScreen(plant: plant)) {
            ZStack {
                AsyncImage(url: URL(string: plant.imageUrl)!) { image in
                    image.image?
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 170, height: 170)
                        .clipped()
                    
                }
                
                VStack {
                    Spacer()
                    ZStack {
                        Color.green
                        Text(plant.name)
                            .font(.headline)
                            .foregroundColor(.white)
                    }.frame(maxWidth: 170, maxHeight: 70)
                }
                
            }.frame(width: 170, height: 170)
            .cornerRadius(10)
        }
        
    }
}


#Preview {
    PlantCardView(
        plant: Plant(
            plantId: "solanum-melongena",
            name: "Eggplant",
            imageUrl: "https://upload.wikimedia.org/wikipedia/commons/e/e5/Eggplant_display.JPG",
            plantDetail: "Eggplant (US), aubergine (UK), or brinjal (South Asia and South Africa) is a plant species in the nightshade family Solanaceae, Solanum melongena, grown for its often purple edible fruit.<br><br>The spongy, absorbent fruit of the plant is widely used in cooking in many different cuisines, and is often considered a vegetable, even though it is a berry by botanical definition. As a member of the genus Solanum, it is related to the tomato and the potato. Like the tomato, its skin and seeds can be eaten, but, like the potato, it is not advisable to eat it raw. Eggplant supplies low contents of macronutrients and micronutrients. The capability of the fruit to absorb oils and flavors into its flesh through cooking is well known in the culinary arts.<br><br>It was originally domesticated from the wild nightshade species thorn or bitter apple, S. incanum, probably with two independent domestications: one in South Asia, and one in East Asia.<br><br>(From <a href=\"https://en.wikipedia.org/wiki/Eggplant\">Wikipedia</a>)",
            wateringFrequency: 3
        )
    )
}
