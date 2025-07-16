//
//  CustomTopTap.swift
//  Sunflower-ios
//
//  Created by Devender Sinhg Parihar on 6/6/25.
//

import Foundation
import SwiftUI

struct CustomTopTabbedView: View {
    
    @State private var selectedTabIndex: Int = 0
    
    var onSelect: ((Int) -> Void)
    
    var body: some View {
        HStack() {
            VStack{
                Button(
                    action: {
                        selectedTabIndex = 0
                        onSelect(selectedTabIndex)
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
                        onSelect(selectedTabIndex)
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
    }
}

#Preview {
    CustomTopTabbedView(
        onSelect: { selectedIndex in
            
        }
    )
}
