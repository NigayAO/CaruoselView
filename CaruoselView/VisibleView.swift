//
//  VisibleView.swift
//  CaruoselView
//
//  Created by Alik Nigay on 18.10.2022.
//

import SwiftUI

struct VisibleView: View {
    @Binding var currentElement: Int
    var movies: [Movie]
    var size: CGSize
    
    var body: some View {
        TabView(selection: $currentElement) {
            ForEach(movies.indices, id: \.self) { index in
                Image(movies[index].poster)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width, height: size.height)
                    .clipped()
                    .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .animation(.easeInOut, value: currentElement)
    }
}

struct VisibleView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
