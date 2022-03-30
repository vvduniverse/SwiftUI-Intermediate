//
//  Typealias.swift
//  SwiftUI-Intermediate
//
//  Created by Vahtee Boo on 30.03.2022.
//

import SwiftUI

struct MovierModel {
    let title: String
    let director: String
    let count: Int
}

typealias TVModel = MovierModel

struct TypealiasBC: View {
    
//    @State private var item = MovierModel(title: "Ukraine", director: "God", count: 10)
    @State private var item = TVModel(title: "USA", director: "Baiden", count: 7)
    
    var body: some View {
        VStack {
            Text(item.title)
            Text(item.director)
            Text("\(item.count)")
            Divider()
        }
    }
}

struct TypealiasBC_Previews: PreviewProvider {
    static var previews: some View {
        TypealiasBC()
    }
}
