//
//  HomeScreen.swift
//  Sunflower-ios
//
//  Created by Devender Sinhg Parihar on 6/5/25.
//

import Foundation
import SwiftUI
import SwiftData

struct HomeScreen: View {
    
    @State private var selectedTabIndex: Int = 0
    @StateObject private var viewModel = PlantViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Sunflower")
                    .font(.largeTitle)
                    .padding(.top, 20)
                    .padding(.bottom, 20)
                
                CustomTopTabbedView(
                    onSelect: { selectedIndex in
                        selectedTabIndex = selectedIndex
                    }
                )
                
                VStack{
                    if selectedTabIndex == 0 {
                        Planted()
                    } else {
                        PlantList(viewModel: viewModel)
                    }
                }
                .frame(maxHeight: .infinity)
            }
        }.modelContainer(for: Plant.self)
    }
}

#Preview {
    HomeScreen()
}
