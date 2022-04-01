//
//  DownloadWithCombineBC.swift
//  SwiftUI-Intermediate
//
//  Created by Vahtee Boo on 01.04.2022.
//

import SwiftUI
import Combine

struct PostModelA: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadWithCombineViewModel: ObservableObject {
    
    @Published var posts = [PostModelA]()
    var cancellables = Set<AnyCancellable>()
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
//        1. create the publisher
//        2. subscribe publisher on background thread
//        3. recieve on main thread
//        4. tryMap (check that the data is good)
//        5. decode (decode data into PostModels)
//        6. sink (put the item into our app)
//        7. store (cancel subscription if needed)
        URLSession.shared.dataTaskPublisher(for: url)
//            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PostModelA].self, decoder: JSONDecoder())
//            .replaceError(with: [])
//            .sink(receiveValue: { [weak self] returnedPosts in
//                self?.posts = returnedPosts
//            })
            .sink { completion in
                switch completion {
                case .finished:
                    print("finished!")
                case .failure(let error):
                    print("There was an error: \(error)")
                }
            } receiveValue: { [weak self] returnedPosts in
                self?.posts = returnedPosts
            }
            .store(in: &cancellables)
    }
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}

struct DownloadWithCombineBC: View {
    
    @StateObject var vm = DownloadWithCombineViewModel()
    
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
        .listStyle(InsetListStyle())
    }
}

struct DownloadWithCombineBC_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithCombineBC()
    }
}
