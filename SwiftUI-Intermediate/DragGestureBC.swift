//
//  DragGestureBC.swift
//  SwiftUI-Intermediate
//
//  Created by Vahtee Boo on 23.03.2022.
//

import SwiftUI

struct DragGestureBC: View {
    
    @State private var offset: CGSize = .zero
    
    var body: some View {
        ZStack {
            
            VStack {
                Text("\(offset.width)")
                Text("\(offset.height)")
                Spacer()
            }
            
            RoundedRectangle(cornerRadius: 20)
                .fill(.mint)
                .frame(width: 300, height: 500)
                .offset(offset)
                .scaleEffect(getScaleAmount())
                .rotationEffect(Angle(degrees: getRotationAMount()))
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            withAnimation(.spring()) {
                                offset = value.translation
                            }
                        }
                        .onEnded { value in
                            withAnimation(.spring()) {
                                offset = .zero
                                //                        offset = CGSize(width: 0, height: 0)
                            }
                        }
            )
        }
    }
    
    func getScaleAmount() -> CGFloat {
        let max = UIScreen.main.bounds.width / 2
        let currentAmount = abs(offset.width)
        let percentage = currentAmount / max
        return 1.0 - min(percentage, 0.25)
//        return 1.0 - min(percentage, 0.5) * 0.5
    }
    
    func getRotationAMount() -> Double {
        let max = UIScreen.main.bounds.width / 2
        let currentAmount = offset.width
        let percentage = currentAmount / max
        let percentageAsDouble = Double(percentage)
        let maxAngle: Double = 10
        return percentageAsDouble * maxAngle
    }
}

struct DragGestureBC_Previews: PreviewProvider {
    static var previews: some View {
        DragGestureBC()
    }
}
