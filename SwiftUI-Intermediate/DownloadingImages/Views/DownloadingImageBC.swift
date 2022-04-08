//
//  DownloadingImageBC.swift
//  SwiftUI-Intermediate
//
//  Created by Vahtee Boo on 08.04.2022.
//

import SwiftUI

struct DownloadingImageBC: View {
    
    @StateObject var vm = DownloadingImagesViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.dataArray) { model in
                    Text(model.title)
                }
            }
            .navigationTitle("Downloading Images!")
        }
    }
}

struct DownloadingImageBC_Previews: PreviewProvider {
    static var previews: some View {
        DownloadingImageBC()
    }
}
