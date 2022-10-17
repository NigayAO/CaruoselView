//
//  SearchBar.swift
//  CaruoselView
//
//  Created by Alik Nigay on 17.10.2022.
//

import SwiftUI

struct CustomSearchBarView: View {
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: "magnifyingglass")
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 28, height: 28)
                .foregroundColor(.gray)
                
            TextField("Search", text: .constant(""))
                .padding(.vertical, 10)
            
            Image(systemName: "mic")
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 28, height: 28)
                .foregroundColor(.gray)
        }
        .padding(.horizontal)
        .padding(.vertical)
        .background {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color.white.opacity(0.12))
        }
        .padding(.top, 20)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomSearchBarView()
    }
}
