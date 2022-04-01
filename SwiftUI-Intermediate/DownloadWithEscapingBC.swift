//
//  DownloadWithEscapingBC.swift
//  SwiftUI-Intermediate
//
//  Created by Vahtee Boo on 01.04.2022.
//

import SwiftUI

struct PostModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DonwloadWithEscapingViewModel: ObservableObject {
    
    @Published var posts = [PostModel]()
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        downloadData(fromURL: url) { returnedData in
            if let data = returnedData {
                guard let newPosts = try? JSONDecoder().decode([PostModel].self, from: data) else { return }
                DispatchQueue.main.async { [weak self] in
                    self?.posts = newPosts
                }
            } else {
                print("No data returned.")
            }
        }
    }
    
    
    func downloadData(fromURL url: URL, completionHandler: @escaping (_ data: Data?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data,
                  error == nil,
                  let response = response as? HTTPURLResponse,
                  response.statusCode >= 200 && response.statusCode < 300 else {
                print("ERROR downloading data.")
                completionHandler(nil)
                return
            }
            completionHandler(data)
        }
        .resume()
    }
}

struct DownloadWithEscapingBC: View {
    
    @StateObject var vm = DonwloadWithEscapingViewModel()
    
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundColor(.gray)
                }
            }
        }
        //        .frame(maxWidth: .infinity, alignment: .leading)
        .listStyle(InsetListStyle())
    }
}

struct DownloadWithEscapingBC_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithEscapingBC()
    }
}
