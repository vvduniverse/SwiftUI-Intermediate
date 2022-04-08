//
//  DownloadingImagesViewModel.swift
//  SwiftUI-Intermediate
//
//  Created by Vahtee Boo on 08.04.2022.
//

import Foundation
import Combine

class DownloadingImagesViewModel: ObservableObject {
    
    @Published var dataArray = [PhotoModel]()
    var cancellables = Set<AnyCancellable>()
    
    let dataService = PhotoModelDataService.instance
    
    init() {
        
    }
    
    func addSubscribers() {
        dataService.$photoModels
            .sink { [weak self] returnedPhotoModels in
                self?.dataArray = returnedPhotoModels
            }
            .store(in: &cancellables)
    }
}
