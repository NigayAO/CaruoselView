//
//  CustomCarouselView.swift
//  CaruoselView
//
//  Created by Alik Nigay on 17.10.2022.
//

import SwiftUI

struct CustomCarouselView<Content: View, Item, ID>: View where Item: RandomAccessCollection, ID: Hashable, Item.Element: Equatable {
    var content: (Item.Element, CGSize) -> Content
    var id: KeyPath<Item.Element, ID>
    
    //MARK: - View Properties
    var spacing: CGFloat
    var cardPadding: CGFloat
    var items: Item
    @Binding var index: Int
    
    //MARK: - Gesture Properties
    @GestureState var translation: CGFloat = 0
    
    @State private var offset: CGFloat = 0
    @State private var lastStoredOffset: CGFloat = 0
    @State private var currentIndex = 0
    //MARK: - Rotation
    @State private var rotation: Double = 0
    
    init(index: Binding<Int>, items: Item, spacing: CGFloat = 38, cardPadding: CGFloat = 80, id: KeyPath<Item.Element, ID>, @ViewBuilder content: @escaping (Item.Element, CGSize) -> Content) {
        self.content = content
        self.id = id
        self._index = index
        self.spacing = spacing
        self.cardPadding = cardPadding
        self.items = items
    }
    
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            
            //MARK: - Reduced After Applying Card Spacing & Padding
            let cardWidth = size.width - (cardPadding - spacing)
            LazyHStack(spacing: spacing) {
                ForEach(items, id: id) { movie in
                    
                    let index = indexOf(item: movie)
                    
                    content(movie, CGSize(width: size.width - cardPadding, height: size.height))
                        .rotationEffect(.init(degrees: Double(index) * 5), anchor: .bottom)
                        .rotationEffect(.init(degrees: rotation), anchor: .bottom)
                        .frame(width: size.width - cardPadding, height: size.height)
                        .contentShape(Rectangle())
                }
            }
            .padding(.horizontal, spacing)
            .offset(x: limitScroll())
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 5)
                    .updating($translation, body: { value, out, _ in
                        out = value.translation.width
                    })
                    .onChanged { onChanged(value: $0, cardWidth: cardWidth) }
                    .onEnded { onEnd(value: $0, cardWidth: cardWidth) }
            )
        }
        .padding(.top, 60)
        .onAppear {
            let extraSpace = (cardPadding / 2) - spacing
            offset = extraSpace
            lastStoredOffset = extraSpace
        }
        .animation(.easeInOut, value: translation == 0)
    }
    
    //MARK: - Item index
    func indexOf(item: Item.Element) -> Int {
        let array = Array(items)
        if let index = array.firstIndex(of: item) {
            return index
        }
        return 0
    }

    //MARK: - Limiting Scroll Of First And Last Items
    private func limitScroll() -> CGFloat {
        let extraSpace = (cardPadding / 2) - spacing
        if index == 0 && offset > extraSpace {
            return extraSpace + (offset / 4)
        } else  if index == items.count - 1 && translation < 0 {
            return offset + (translation / 2)
        } else {
            return offset
        }
    }
    
    private func onChanged(value: DragGesture.Value, cardWidth: CGFloat) {
        let translationX = value.translation.width
        offset = translationX + lastStoredOffset
        
        //MARK: - Calculation Rotation
        let progress = offset / cardWidth
        rotation = progress * 5
    }
    
    private func onEnd(value: DragGesture.Value, cardWidth: CGFloat) {
        //MARK: - Calculating current index
        var _index = (offset / cardWidth).rounded()
        _index = max(-CGFloat(items.count - 1), _index)
        _index = min(_index, 0)
        
        index = -currentIndex
        
        currentIndex = Int(_index)
        withAnimation(.easeInOut(duration: 0.25)) {
            //MARK: - Removing extra space
            let extraSpace = (cardPadding / 2) - spacing
            offset = (cardWidth * _index) + extraSpace
            //MARK: - Calculation Rotation
            let progress = offset / cardWidth
            rotation = (progress * 5).rounded() - 1
        }
        lastStoredOffset = offset
    }
}

struct CustomCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
