//
//  MaskBC.swift
//  SwiftUI-Intermediate
//
//  Created by Vahtee Boo on 24.03.2022.
//

import SwiftUI



struct MaskBC: View {

    @State private var rating = 4

    var body: some View {
        ZStack {
            starsView
                .overlay(overlayView.mask(starsView))
        }
    }
    
    private var overlayView: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
//                Rectangle()
//                    .foregroundColor(.yellow)
//                    .fill(LinearGradient(colors: [.blue, .yellow], startPoint: .top, endPoint: .bottom))
                VStack(spacing: 0) {
                    Color.blue
                    Color.yellow
                }
                    .frame(width: CGFloat(rating) / 5 * geometry.size.width)
            }
        }
        .allowsHitTesting(false)
    }

    private var starsView: some View {
        HStack {
            ForEach(1..<6) { index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            rating = index
                        }
                    }
            }
        }

    }
}


//struct MaskBC: View {
//
//    @State private var rating = 4
//
//    var body: some View {
//        ZStack {
//            starsView
//        }
//    }
//
//    private var starsView: some View {
//        HStack {
//            ForEach(1..<6) { index in
//                Image(systemName: "star.fill")
//                    .font(.largeTitle)
//                    .foregroundColor(rating < index ? .gray : .yellow)
//                    .onTapGesture {
//                        rating = index
//                    }
//            }
//        }
//
//    }
//}
struct MaskBC_Previews: PreviewProvider {
    static var previews: some View {
        MaskBC()
    }
}


