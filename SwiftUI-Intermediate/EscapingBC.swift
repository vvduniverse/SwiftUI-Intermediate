//
//  EscapingBC.swift
//  SwiftUI-Intermediate
//
//  Created by Vahtee Boo on 31.03.2022.
//

import SwiftUI

class EsvapingViewModel: ObservableObject {
    
    @Published var text = "Hello"
    
//    func getData() {
//        let newData = downloadData()
//        text = newData
//    }
    
//    func getData() {
//        downloadData3 { [weak self] returnedData in
//            self?.text = returnedData
//        }
//    }
    
//    func getData() {
//        downloadData4 { [weak self] returnedResult in
//            self?.text = returnedResult.data
//        }
//    }
    
    func getData() {
        downloadData5 { [weak self] returnedResult in
            self?.text = returnedResult.data
        }
    }
    
    func downloadData() -> String {
        return "New data!"
    }
    
    func downloadData2(completionHandler: (_ data: String) -> Void) {
        completionHandler("New data!")
    }
    
    func downloadData3(completionHandler: @escaping (_ data: String) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            completionHandler("New data!")
        }
    }
    
    func downloadData4(completionHandler: @escaping (DownloadResult) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let result = DownloadResult(data: "New data!")
            completionHandler(result)
        }
    }
    
    func downloadData5(completionHandler: @escaping DownloadCompletion) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let result = DownloadResult(data: "New data!")
            completionHandler(result)
        }
    }
}

struct DownloadResult {
    let data: String
}

typealias DownloadCompletion = (DownloadResult) -> ()

struct EscapingBC: View {
    
    @StateObject var vm = EsvapingViewModel()
    
    var body: some View {
        Text(vm.text)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(.blue)
            .onTapGesture {
                vm.getData()
            }
    }
}

struct EscapingBC_Previews: PreviewProvider {
    static var previews: some View {
        EscapingBC()
    }
}
