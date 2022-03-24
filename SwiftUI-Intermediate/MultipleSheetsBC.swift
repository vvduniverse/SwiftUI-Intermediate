//
//  MultipleSheetsBC.swift
//  SwiftUI-Intermediate
//
//  Created by Vahtee Boo on 24.03.2022.
//

// 1 - use a binding
// 2 - use multiple .sheets
// 3 - use $item
// 4 - use $item (like a pro)

import SwiftUI

struct RandomModel: Identifiable {
    let id = UUID().uuidString
    let title: String
}

// 3 - use $item (like a pro)

struct MultipleSheetsBC: View {
    
    @State private var selectedModel: RandomModel?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(0..<30) { index in
                    Button("Button \(index)") {
                        selectedModel = RandomModel(title: "\(index)")
                    }
                }
            }
            .sheet(item: $selectedModel) { model in
                NextScreen(selectedModel: model)
            }
        }
    }
}

struct NextScreen: View {
    
    let selectedModel: RandomModel
    
    var body: some View {
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}

struct MultipleSheetsBC_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSheetsBC()
    }
}
//struct RandomModel: Identifiable {
//    let id = UUID().uuidString
//    let title: String
//}

//// 3 - use $item
//
//struct MultipleSheetsBC: View {
//
//    @State private var selectedModel: RandomModel?
//    var body: some View {
//        VStack(spacing: 20) {
//            Button("Button 1") {
//                selectedModel = RandomModel(title: "ONE")
//            }
//            Button("Button 2") {
//                selectedModel = RandomModel(title: "TWO")
//            }
//        }
//        .sheet(item: $selectedModel) { model in
//            NextScreen(selectedModel: model)
//        }
//    }
//}
//
//struct NextScreen: View {
//
//    let selectedModel: RandomModel
//
//    var body: some View {
//        Text(selectedModel.title)
//            .font(.largeTitle)
//    }
//}
//
//struct MultipleSheetsBC_Previews: PreviewProvider {
//    static var previews: some View {
//        MultipleSheetsBC()
//    }
//}

//struct RandomModel: Identifiable {
//    let id = UUID().uuidString
//    let title: String
//}
//
//// 2 - use multiple .sheets
//
//struct MultipleSheetsBC: View {
//
//    @State private var selectedModel = RandomModel(title: "Starting Title")
//    @State private var showSheet1 = false
//    @State private var showSheet2 = false
//
//    var body: some View {
//        VStack(spacing: 20) {
//            Button("Button 1") {
////                selectedModel = RandomModel(title: "ONE")
//                showSheet1.toggle()
//            }
//            .sheet(isPresented: $showSheet1) {
//                NextScreen(selectedModel: RandomModel(title: "ONE"))
//            }
//            Button("Button 2") {
////                selectedModel = RandomModel(title: "TWO")
//                showSheet2.toggle()
//            }
//            .sheet(isPresented: $showSheet2) {
//                NextScreen(selectedModel: RandomModel(title: "TWO"))
//            }
//        }
//    }
//}
//
//struct NextScreen: View {
//
//    let selectedModel: RandomModel
//
//    var body: some View {
//        Text(selectedModel.title)
//            .font(.largeTitle)
//    }
//}
//
//struct MultipleSheetsBC_Previews: PreviewProvider {
//    static var previews: some View {
//        MultipleSheetsBC()
//    }
//}

//struct RandomModel: Identifiable {
//    let id = UUID().uuidString
//    let title: String
//}
//
//// 1 - use a binding
//
//struct MultipleSheetsBC: View {
//
//    @State private var selectedModel = RandomModel(title: "Starting Title")
//    @State private var showSheet = false
//
//    var body: some View {
//        VStack(spacing: 20) {
//            Button("Button 1") {
//                selectedModel = RandomModel(title: "ONE")
//                showSheet.toggle()
//            }
//            Button("Button 2") {
//                selectedModel = RandomModel(title: "TWO")
//                showSheet.toggle()
//            }
//        }
//        .sheet(isPresented: $showSheet) {
//            NextScreen(selectedModel: $selectedModel)
//        }
//    }
//}
//
//struct NextScreen: View {
//
//    @Binding var selectedModel: RandomModel
//
//    var body: some View {
//        Text(selectedModel.title)
//            .font(.largeTitle)
//    }
//}
//
//struct MultipleSheetsBC_Previews: PreviewProvider {
//    static var previews: some View {
//        MultipleSheetsBC()
//    }
//}

// isn't working correctly
//
//struct RandomModel: Identifiable {
//    let id = UUID().uuidString
//    let title: String
//}
//
//
//struct MultipleSheetsBC: View {
//
//    @State private var selectedModel = RandomModel(title: "Starting Title")
//    @State private var showSheet = false
//
//    var body: some View {
//        VStack(spacing: 20) {
//            Button("Button 1") {
//                selectedModel = RandomModel(title: "ONE")
//                showSheet.toggle()
//            }
//            Button("Button 2") {
//                selectedModel = RandomModel(title: "TWO")
//                showSheet.toggle()
//            }
//        }
//        .sheet(isPresented: $showSheet) {
//            NextScreen(selectedModel: selectedModel)
//        }
//    }
//}
//
//struct NextScreen: View {
//
//    let selectedModel: RandomModel
//
//    var body: some View {
//        Text(selectedModel.title)
//            .font(.largeTitle)
//    }
//}
//
//struct MultipleSheetsBC_Previews: PreviewProvider {
//    static var previews: some View {
//        MultipleSheetsBC()
//    }
//}
