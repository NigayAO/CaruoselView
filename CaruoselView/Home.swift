//
//  Home.swift
//  CaruoselView
//
//  Created by Alik Nigay on 17.10.2022.
//

import SwiftUI

struct Home: View {
    //MARK: - Properties
    @State private var currentTab: TabItems = .home
    
    //MARK: - Carouser Properties
    @State private var currentIndex = 0
    
    private let movies = Movie.getMovies()
    
    var body: some View {
        VStack(spacing: 15) {
            HeaderView()
            
            CustomSearchBarView()
            
            //MARK: - Custom Carousel
            CustomCarouselView(index: $currentIndex, items: movies, cardPadding: 150, id: \.id) { movie, cardSize in
                //MARK: - Custom Cell view
                Image(movie.poster)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: cardSize.width, height: cardSize.height)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            }
            .padding(.horizontal, -15)
            .padding(.vertical)

            CustomTabBarView(currentTab: $currentTab)
        }
        .padding([.horizontal, .top], 15)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background {
            GeometryReader { geometry in
                let size = geometry.size
                VisibleView(currentElement: $currentIndex, movies: movies, size: size)
                
                Rectangle()
                    .fill(.ultraThinMaterial)
                
                LinearGradient(colors: [
                    .clear,
                    .gray,
                    .black
                ], startPoint: .top, endPoint: .bottom)
            }
            .ignoresSafeArea()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
