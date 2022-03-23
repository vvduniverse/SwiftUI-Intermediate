//
//  DragGestureBC2.swift
//  SwiftUI-Intermediate
//
//  Created by Vahtee Boo on 23.03.2022.
//

import SwiftUI

struct DragGestureBC2: View {
    
    @State private var startingOffstY = UIScreen.main.bounds.height * 0.85
    @State private var currentDragOffsetY: CGFloat = 0
    @State private var endingOffsetY: CGFloat = 0
    
    let thresholdValue: CGFloat = 250
    
    var body: some View {
        ZStack {
            
            Color.mint.ignoresSafeArea()
            
            MySignUpView()
                .offset(y: startingOffstY)
                .offset(y: currentDragOffsetY)
                .offset(y: endingOffsetY)
                .gesture(
                DragGesture()
                    .onChanged { value in
                        withAnimation(.spring()) {
                            currentDragOffsetY = value.translation.height
                        }
                    }
                    .onEnded { value in
                        withAnimation(.spring()) {
                            if currentDragOffsetY < -thresholdValue {
                                endingOffsetY = -startingOffstY
                            } else if endingOffsetY != 0 && currentDragOffsetY > thresholdValue {
                                endingOffsetY = 0
                            }
                                currentDragOffsetY = 0
                        }
                    }
                )
//            Text("\(currentDragOffsetY)")
        }
        .ignoresSafeArea(edges: .bottom )
    }
}

struct DragGestureBC2_Previews: PreviewProvider {
    static var previews: some View {
        DragGestureBC2()
    }
}

struct MySignUpView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "chevron.up")
                .padding(.top)
            Text("Sign up")
                .font(.headline)
                .fontWeight(.semibold)
            
            Image(systemName: "flame.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Text("Arguably the most important of the gestures the Drag Gesture allows ut to easily and naturally move items around the screen! In this vide we will learn how to implement the DragGesture() and then explore two advanced examples of how these gestures are being used in applications.")
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Text("CREATE AN ACCOUNT")
                .foregroundColor(.white)
                .font(.headline)
                .padding()
                .padding(.horizontal)
                .background(Color.black.cornerRadius(10))
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(30)
    }
}
