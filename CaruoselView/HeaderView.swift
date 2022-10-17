//
//  HeaderVeiw.swift
//  CaruoselView
//
//  Created by Alik Nigay on 17.10.2022.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                (Text("Hello")
                    .fontWeight(.semibold) +
                 Text(" It's me!")
                )
                .font(.title2)
                Text("Book your favourite movie")
                    .font(.callout)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Button {
                
            } label: {
                Image("bro")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            }

        }
    }
}

struct HeaderVeiw_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
