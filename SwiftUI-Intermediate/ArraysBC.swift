//
//  ArraysBC.swift
//  SwiftUI-Intermediate
//
//  Created by Vahtee Boo on 27.03.2022.
//

import SwiftUI

struct UserModel: Identifiable {
    let id = UUID().uuidString
    let name: String?
    let points: Int
    let isVerified: Bool
}

class ArrayModificationViewModel: ObservableObject {
    
    @Published var dataArray = [UserModel]()
    @Published var filteredArray = [UserModel]()
    @Published var mappedArray = [String]()
    
    init() {
        getUsers()
        updateFilteredArray()
    }
    
    func updateFilteredArray() {
    // sort
        /*
//        filteredArray = dataArray.sorted(by: { user1, user2 in
//            return user1.points > user2.points
//        })
        
        filteredArray = dataArray.sorted(by: { $0.points < $1.points })
*/
    
    // filter
        /*
        filteredArray = dataArray.filter({ user in
//            user.points > 40
//            user.isVerified
            user.name.contains("a")
        })
         */
    
    // map
        /*
//        mappedArray = dataArray.map({ user in
//            user.name
//        })
//        mappedArray = dataArray.map { $0.name }
        //for optional data
        mappedArray = dataArray.compactMap { $0.name }
        */
        
        mappedArray = dataArray
            .sorted(by: { $0.points < $1.points })
                .filter { $0.isVerified}
                .compactMap { $0.name }
    }
    
    func getUsers() {
        let user1 = UserModel(name: "Vahtang", points: 5, isVerified: true)
        let user2 = UserModel(name: "Martha", points: 15, isVerified: true)
        let user3 = UserModel(name: "Anna", points: 3, isVerified: false)
        let user4 = UserModel(name: "Helen", points: 0, isVerified: false)
        let user5 = UserModel(name: "Alex", points: 45, isVerified: true)
//        let user6 = UserModel(name: "Boris", points: 22, isVerified: false)
        let user6 = UserModel(name: nil, points: 22, isVerified: false)
        let user7 = UserModel(name: "Andrew", points: 9, isVerified: true)
        let user8 = UserModel(name: "Sofiia", points: 100, isVerified: true)
        let user9 = UserModel(name: "Julia", points: 77, isVerified: false)
//        let user10 = UserModel(name: "Nathan", points: 80, isVerified: true)
        let user10 = UserModel(name: nil, points: 80, isVerified: true)
        self.dataArray.append(contentsOf:
        [user1, user2, user3, user4, user5, user6, user7, user8, user9, user10]
        )
    }
}

struct ArraysBC: View {
    
    @StateObject var vm = ArrayModificationViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(vm.mappedArray, id: \.self) { name in
                    Text(name)
                        .font(.title)
                }
                
//                ForEach(vm.filteredArray) { user in
//                    VStack(alignment: .leading) {
//                        Text(user.name)
//                            .font(.headline)
//                        HStack {
//                            Text("Points: \(user.points)")
//                            Spacer()
//                            if user.isVerified {
//                                Image(systemName: "flame.fill")
//                            }
//                        }
//                    }
//                    .foregroundColor(.white)
//                    .padding()
//                    .background(Color.blue.cornerRadius(10))
//                    .padding(.horizontal)
//                }
            }
        }
    }
}

struct ArraysBC_Previews: PreviewProvider {
    static var previews: some View {
        ArraysBC()
    }
}
