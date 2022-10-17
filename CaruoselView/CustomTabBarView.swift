//
//  CustomTabBar.swift
//  CaruoselView
//
//  Created by Alik Nigay on 17.10.2022.
//

import SwiftUI

struct CustomTabBarView: View {
    @Binding var currentTab: TabItems
    @Namespace var animation
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(TabItems.allCases, id: \.rawValue) { item in
                VStack(spacing: -2) {
                    Image(systemName: item.rawValue)
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 28, height: 28)
                        .foregroundColor(currentTab == item ? .white : .gray.opacity(0.6))
                    
                    if currentTab == item {
                        Circle()
                            .fill(.white)
                            .frame(width: 5, height: 5)
                            .offset(y: 10)
                            .matchedGeometryEffect(id: "TAB", in: animation)
                        
                    }
                }
                .frame(maxWidth: .infinity)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeInOut) { currentTab = item }
                }
            }
        }
        .padding(.horizontal)
        .padding(.bottom, 10)
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBarView(currentTab: .constant(.home))
    }
}
