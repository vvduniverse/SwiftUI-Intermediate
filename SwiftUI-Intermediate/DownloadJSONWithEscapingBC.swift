//
//  DownloadJSONWithEscapingBC.swift
//  SwiftUI-Intermediate
//
//  Created by Vahtee Boo on 03.04.2022.
//

import SwiftUI

class DownloadJSONWithEscapingViewModel: ObservableObject {
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        
        guard let url = URL(string: "") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                print("No data.")
                return
            }
            
            guard error == nil else {
                print("Error: \(String(describing: error))")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Invalid response.")
                return
            }

            guard response.statusCode >= 200 && response.statusCode < 300 else {
                print("Status code should be 2xx, but is \(response.statusCode)")
                return
            }
            
            print("SUCCESSFULLY DOWNLOADED DATA!")
            print(data)
            let jsonString = String(data: data, encoding: .utf8)
            print(jsonString)
            
        }
        .resume()
    }
}

struct DownloadJSONWithEscapingBC: View {
    
    @StateObject var vm = DownloadJSONWithEscapingViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct DownloadJSONWithEscapingBC_Previews: PreviewProvider {
    static var previews: some View {
        DownloadJSONWithEscapingBC()
    }
}
