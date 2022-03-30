//
//  BackgroundThreadBC.swift
//  SwiftUI-Intermediate
//
//  Created by Vahtee Boo on 30.03.2022.
//

import SwiftUI

class BackgroundThreadViewModel: ObservableObject {
    
    @Published var dataArray = [String]()
    
    func fetchData() {
        
        DispatchQueue.global(qos: .background).async {
            let newData = self.downloadData()
            
            print("CHECK 1: \(Thread.isMainThread)")
            print("CHECK 2: \(Thread.current)")
            
            DispatchQueue.main.async {
                self.dataArray = newData
                print("CHECK 3: \(Thread.isMainThread)")
                print("CHECK 4: \(Thread.current)")
            }
        }
        
    }
    
    private func downloadData() -> [String] {
        var data = [String]()
        
        for x in 0..<100 {
            data.append("\(x)")
                print(data)
        }
        return data
    }
    
}

struct BackgroundThreadBC: View {
    
    @StateObject var vm = BackgroundThreadViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                Text("LOAD DATA")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        vm.fetchData()
                    }
                
                ForEach(vm.dataArray, id: \.self) { item in
                    Text(item)
                        .font(.headline)
                        .foregroundColor(.red)
                }
            }
        }
    }
}

struct BackgroundThreadBC_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundThreadBC()
    }
}
