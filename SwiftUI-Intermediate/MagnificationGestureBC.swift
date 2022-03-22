//
//  MagnificationGestureBC.swift
//  SwiftUI-Intermediate
//
//  Created by Vahtee Boo on 22.03.2022.
//

import SwiftUI

struct MagnificationGestureBC: View {
    
    @State private var currentAmount: CGFloat = 0
    @State private var lastAmount: CGFloat = 0
    
    var body: some View {
        
        VStack(spacing: 10) {
            HStack {
                Circle().frame(width: 35, height: 35)
                Text("Swiftful Thinking")
                Spacer()
                Image(systemName: "ellipsis")
            }
            .padding(.horizontal)
            Image("juliette")
                .resizable()
                .scaledToFit()
                .frame(height: 300)
                .scaleEffect(1 + currentAmount)
                .gesture(
                MagnificationGesture()
                    .onChanged { value in
                        currentAmount = value - 1
                    }
                    .onEnded { value in
                        withAnimation(.spring()) {
                            currentAmount = 0
                        }
                    }
                )
            HStack {
                Image(systemName: "heart.fill")
                Image(systemName: "text.bubble.fill")
Spacer()
            
            }
            .padding(.horizontal)
            .font(.headline)
            Text("This is the caption for my photo!")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
        }
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//            .font(.title)
//            .padding(40)
//            .background(Color.orange.cornerRadius(15))
//            .scaleEffect(1 + currentAmount + lastAmount)
//            .gesture(
//            MagnificationGesture()
//                .onChanged { value in
//                    currentAmount = value - 1
//                    print("current: \(currentAmount)")
//                }
//                .onEnded { value in
//                    lastAmount += currentAmount
//                    print("last: \(lastAmount)")
//                    currentAmount = 0
//                }
//            )
    }
}

struct MagnificationGestureBC_Previews: PreviewProvider {
    static var previews: some View {
        MagnificationGestureBC()
    }
}
