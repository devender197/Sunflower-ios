//
//  HomeScreen.swift
//  Sunflower-ios
//
//  Created by Devender Sinhg Parihar on 6/5/25.
//

import Foundation
import SwiftUI

struct HomeScreen: View {
    
    @State private var selectedTabIndex: Int = 0
    
    var body: some View {
        VStack {
            Text("Sunflower")
                .font(.largeTitle)
                .padding(.top, 20)
                .padding(.bottom, 20)
            
            HStack() {
                VStack{
                    Button(
                        action: {
                            selectedTabIndex = 0
                        },
                        label: {
                            VStack {
                                Image(systemName: "tree.fill")
                                Text("My garden")
                            }
                        }
                    )
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(
                        selectedTabIndex == 0 ? Color.green : Color.gray
                    )
                }
                
                VStack {
                    Button(
                        action: {
                            selectedTabIndex = 1
                        },
                        label: {
                            VStack {
                                Image(systemName: "leaf.fill")
                                Text("Plant list")
                            }
                        }
                    )
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(
                        selectedTabIndex == 1 ? Color.green : Color.gray
                    )
                }
            }
            
            GeometryReader { geo in
                let tabWidth = geo.size.width / 2
                Rectangle()
                    .fill(Color.green)
                    .frame(width: tabWidth, height: 5)
                    .offset(x: CGFloat(selectedTabIndex) * tabWidth)
                    .animation(.easeInOut(duration: 0.3), value: selectedTabIndex)
            }
            .frame(height: 5)
            
            VStack{
                if selectedTabIndex == 0 {
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
                        .clipShape(Shape.)
                        
                    }
                } else {
                    Text("Plant list")
                }
            }
            .frame(maxHeight: .infinity)
        }
    }
}

#Preview {
    HomeScreen()
}
