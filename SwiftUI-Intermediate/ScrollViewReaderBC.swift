//
//  ScrollViewReaderBC.swift
//  SwiftUI-Intermediate
//
//  Created by Vahtee Boo on 23.03.2022.
//

import SwiftUI

struct ScrollViewReaderBC: View {
    
    @State private var scrollToIndex = 0
    @State private var textFieldText = ""
    
    var body: some View {
        
        VStack {
            TextField("Enter a # here...", text: $textFieldText)
                .frame(height: 55)
                .border(Color.gray)
                .padding(.horizontal)
                .keyboardType(.numberPad)
            
            Button("Scroll now") {
                withAnimation(.spring()) {
                    if let index = Int(textFieldText) {
                        scrollToIndex = index
                    }
                }
            }
            
            ScrollView {
                ScrollViewReader { proxy in
                    ForEach(0..<50) { index in
                        Text("This is item #\(index)")
                            .font(.headline)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .background(.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding()
                            .id(index)
                    }
                    .onChange(of: scrollToIndex) { value in
                        withAnimation(.spring()) {
                            proxy.scrollTo(value, anchor: .center)
                        }
                    }
                }
            }
        }
    }
}

//struct ScrollViewReaderBC: View {
//    var body: some View {
//        ScrollView {
//            ScrollViewReader { proxy in
//                Button("Click here to go to #33") {
//                    withAnimation(.spring()) {
//                        proxy.scrollTo(33, anchor: .center)
//                    }
//                }
//
//                ForEach(0..<50) { index in
//                    Text("This is item #\(index)")
//                        .font(.headline)
//                        .frame(height: 200)
//                        .frame(maxWidth: .infinity)
//                        .background(.white)
//                        .cornerRadius(10)
//                        .shadow(radius: 10)
//                        .padding()
//                        .id(index)
//                }
//            }
//        }
//    }
//}

struct ScrollViewReaderBC_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewReaderBC()
    }
}
