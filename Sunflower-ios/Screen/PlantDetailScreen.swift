//
//  PlantDetailScreen.swift
//  Sunflower-ios
//
//  Created by Devender Sinhg Parihar on 6/30/25.
//

import Foundation
import SwiftUI
import SwiftData

struct PlantDetailScreen: View {
    let plant: Plant
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
    
    var body: some View {
        ScrollView {
                HeaderView(
                    context: context,
                    plant: plant,
                    imageUrl: plant.imageUrl,
                    onBack: {
                        withAnimation {
                            dismiss()
                        }
                    },
                    onSave: {
                        context.insert(plant)
                    }
                )
                
                Detail(
                    plantName: plant.name,
                    plantWateringNeeds: plant.wateringFrequency,
                    plantDescription: plant.plantDetail
                )
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct Detail: View {
    let plantName: String
    let plantWateringNeeds: Int
    let plantDescription: String
    
    var body: some View {
        
        Text(plantName).font(.title).padding(.bottom, 10)
        
        Text("Watering needs: every \(plantWateringNeeds)day").padding(.bottom, 10)
    
        if let attributedString = htmlToAttributedString(plantDescription) {
            Text(attributedString).padding(20)
        } else {
            Text(plantDescription).padding(20)
        }
    }
}

func htmlToAttributedString(_ html: String) -> AttributedString? {
        guard let data = html.data(using: .utf8) else { return nil }
        do {
            let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ]
            let nsAttrStr = try NSAttributedString(data: data, options: options, documentAttributes: nil)
            return try AttributedString(nsAttrStr, including: \.uiKit)
        } catch {
            print("HTML to AttributedString error:", error)
            return nil
        }
    }

struct HeaderView: View {
    let context: ModelContext
    let plant: Plant
    let imageUrl: String
    let onBack: () -> Void
    let onSave: () -> Void
    @State private var showSaveButton = false
    
    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: imageUrl)!) { image in
                image.image?
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: 300)
            }.padding(.bottom, 35)
            
            VStack(alignment: .leading) {
                HStack {
                    Button(
                        action: {
                            onBack()
                        },
                        label: {
                            Image(systemName: "arrow.backward")
                                .foregroundColor(.black)
                                .bold(true)
                                .padding()
                                .background(Color.white)
                                .clipShape(Circle())
                        }
                    ).buttonStyle(.plain)
                        .padding([.top, .leading], 10)
                    Spacer()
                }
                Spacer()
            }
            
            if showSaveButton {
                VStack(alignment: .trailing) {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(
                            action: {
                                onSave()
                            },
                            label: {
                                Image(systemName: "plus")
                                    .foregroundColor(.black)
                                    .padding()
                                    .background(Color.green)
                                    .clipShape(Circle())
                            }
                        ).buttonStyle(.plain)
                            .padding([.bottom, .trailing], 10)
                    }
                    
                }
            }
        }.onAppear {
            Task {
                showSaveButton = !(await plantExists(plantId: plant.plantId, context: context))
            }
        }
    }
}

struct AyncImageView: View {
    let imageUrl: String
    var body: some View {
        AsyncImage(url: URL(string: imageUrl)) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: 300)

            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: 300)
                    .clipped()

            case .failure:
                Color.gray
                    .frame(maxWidth: .infinity, maxHeight: 300)
            @unknown default:
                EmptyView()
            }
        }
        .padding(.bottom, 35)

    }
}

func plantExists(plantId: String, context: ModelContext) -> Bool {
    let predicate = #Predicate<Plant>{ $0.plantId == plantId}
    let descriptor = FetchDescriptor<Plant>(predicate: predicate)
        
    do {
        let results = try context.fetch(descriptor)
        return !results.isEmpty
    } catch {
        print("Error checking existence:", error)
        return false
    }
}

#Preview {
    PlantDetailScreen(
        plant: Plant(
            plantId: "solanum-melongena",
            name: "Eggplant",
            imageUrl: "https://upload.wikimedia.org/wikipedia/commons/e/e5/Eggplant_display.JPG",
            plantDetail: "Eggplant (US), aubergine (UK), or brinjal (South Asia and South Africa) is a plant species in the nightshade family Solanaceae, Solanum melongena, grown for its often purple edible fruit.<br><br>The spongy, absorbent fruit of the plant is widely used in cooking in many different cuisines, and is often considered a vegetable, even though it is a berry by botanical definition. As a member of the genus Solanum, it is related to the tomato and the potato. Like the tomato, its skin and seeds can be eaten, but, like the potato, it is not advisable to eat it raw. Eggplant supplies low contents of macronutrients and micronutrients. The capability of the fruit to absorb oils and flavors into its flesh through cooking is well known in the culinary arts.<br><br>It was originally domesticated from the wild nightshade species thorn or bitter apple, S. incanum, probably with two independent domestications: one in South Asia, and one in East Asia.<br><br>(From <a href=\"https://en.wikipedia.org/wiki/Eggplant\">Wikipedia</a>)",
            wateringFrequency: 3
        )
    )
}
