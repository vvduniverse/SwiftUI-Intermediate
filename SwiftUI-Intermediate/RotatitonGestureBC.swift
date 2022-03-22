//
//  RotatitonGestureBC.swift
//  SwiftUI-Intermediate
//
//  Created by Vahtee Boo on 22.03.2022.
//

import SwiftUI

struct RotatitonGestureBC: View {
    
    @State private var angle = Angle(degrees: 0)
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding(50)
            .background(Color.mint.cornerRadius(15))
            .rotationEffect(angle)
            .gesture(
            RotationGesture()
                .onChanged { value in
                    angle = value
                }
                .onEnded { value in
                    withAnimation(.spring()) {
                        angle = Angle(degrees: 0)
                    }
                }
            )
    }
}

struct RotatitonGestureBC_Previews: PreviewProvider {
    static var previews: some View {
        RotatitonGestureBC()
    }
}
