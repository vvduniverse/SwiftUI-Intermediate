//
//  GeometryReaderBC.swift
//  SwiftUI-Intermediate
//
//  Created by Vahtee Boo on 23.03.2022.
//

import SwiftUI

struct GeometryReaderBC: View {
    
    func getPercentage(geo: GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.width / 2
        let currentX = geo.frame(in: .global).midX
        return Double(1 - (currentX / maxDistance))
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<20) { index in
                    GeometryReader { geometry in
                        RoundedRectangle(cornerRadius: 20).fill(.mint)
                            .rotation3DEffect(
                                Angle(degrees: getPercentage(geo: geometry) * 40), axis: (x: 0.0, y: 1.0, z: 0.0))
                    }
                    .frame(width: 300, height: 250)
                    .padding()
                }
            }
        }
    }
}

//struct GeometryReaderBC: View {
//    var body: some View {
//        GeometryReader { geometry in
//            HStack(spacing: 0) {
//                Rectangle()
//                    .fill(.blue)
//                    .frame(width: geometry.size.width * 2 / 3)
//                Rectangle()
//                    .fill(.yellow)
//            }
//        }
//        .ignoresSafeArea()
//    }
//}

struct GeometryReaderBC_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderBC()
            .previewInterfaceOrientation(.portrait)
    }
}
