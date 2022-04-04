//
//  FileManagerBC.swift
//  SwiftUI-Intermediate
//
//  Created by Vahtee Boo on 04.04.2022.
//

import SwiftUI

class LocalFileManager {
    
    static let instance = LocalFileManager()
    let folderName = "MyApp_Images"
    
    init() {
        createFolderIfNeeded()
    }
    
    func createFolderIfNeeded() {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName)
                .path else {
            return
        }
        
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
                print("Success creating folder.")
            } catch let error {
                print("Error creating folder \(error)")
            }
        }
    }
    
    func deleteFolder() {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName)
                .path else {
            return
        }
        do {
            try FileManager.default.removeItem(atPath: path)
            print("Success deleting folder.")
        } catch let error {
            print("Error deleting folder. \(error )")
        }
    }
    
    func saveImage(image: UIImage, name: String) -> String {
        
        guard
            let data = image.jpegData(compressionQuality: 1.0),
            let path = getPathForImage(name: name) else {
            return "Error getting data."
        }
        
//        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        let directory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
//        let directory3 = FileManager.default.temporaryDirectory
//        let path = directory?.appendingPathComponent("\(name).jpeg")
//        print(directory)
//        print(path)
//        print(directory2)
//        print(directory3)
        
        do {
            try data.write(to: path)
            print(path)
            return "Success saving!"
        } catch let error {
            return "Error saving. \(error)"
        }
    }
    
    func getImage(name: String) -> UIImage? {
        guard
            let path = getPathForImage(name: name)?.path,
            FileManager.default.fileExists(atPath: path) else {
            print("Error getting path.")
            return nil
        }
        
        return UIImage(contentsOfFile: path)
    }
    
    func deleteImage(name: String) -> String {
        guard
            let path = getPathForImage(name: name)?.path,
            FileManager.default.fileExists(atPath: path) else {
            return "Error getting path."
            
        }
        
        do {
            try FileManager.default.removeItem(atPath: path)
            return "Successfully deleted."
        } catch let error {
            return "Error deleting image. \(error)"
        }
    }
    
    func getPathForImage(name: String) -> URL? {
        guard let path = FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
            .appendingPathComponent("\(name).jpeg") else {
            print("Error getting path.")
            return nil
        }
        return path
    }
}

class FileManagerViewModel: ObservableObject {
    
    @Published var image: UIImage?
    let imageName = "juliette"
    let manager = LocalFileManager.instance
    @Published var infoMessage = ""
    
    init() {
        getImageFromAssetsFolde()
//        getImageFromFileManager()
    }
    
    func getImageFromAssetsFolde() {
        image = UIImage(named: imageName)
    }
    
    func getImageFromFileManager() {
        image = manager.getImage(name: imageName)
    }
    
    func saveImage() {
        guard let image = image else { return }
        infoMessage = manager.saveImage(image: image, name: imageName)
    }
    
    func deleteImage() {
        infoMessage = manager.deleteImage(name: imageName)
        manager.deleteFolder()
    }
}

struct FileManagerBC: View {
    
    @StateObject var vm = FileManagerViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if let image = vm.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                
                HStack {
                    Button {
                        vm.saveImage()
                    } label: {
                        Text("Save to FM")
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button {
                        vm.deleteImage()
                    } label: {
                        Text("Delete from FM")
                    }
                    .buttonStyle(.borderedProminent)
                }
                
                Text(vm.infoMessage)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.purple)
                Spacer()
            }
            .navigationTitle("File Manager")
        }
    }
}

struct FileManagerBC_Previews: PreviewProvider {
    static var previews: some View {
        FileManagerBC()
    }
}
