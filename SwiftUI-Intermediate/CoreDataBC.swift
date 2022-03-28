//
//  CoreDataBC.swift
//  SwiftUI-Intermediate
//
//  Created by Vahtee Boo on 28.03.2022.
//

import SwiftUI
import CoreData

class CoreDataViewModel: ObservableObject {
    
    let container: NSPersistentContainer
    @Published var savedEntitties = [FruitEntity]()
    
    init() {
        container = NSPersistentContainer(name: "FruitsContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading core data \(error)")
            }
        }
        fetchFruits()
    }
    
    func fetchFruits() {
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
        
        do {
            savedEntitties = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    func addFruit(text: String) {
        let newFruit = FruitEntity(context: container.viewContext)
        newFruit.name = text
        saveData()
    }
    
    func updateFruit(entity: FruitEntity) {
        let currentName = entity.name ?? ""
        let newName = currentName + "!"
        entity.name = newName
        saveData()
    }
    
    func deleteFruit(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = savedEntitties[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchFruits()
        } catch let error {
            print("Error savint. \(error)")
        }
    }
}

struct CoreDataBC: View {
    
    @StateObject var vm = CoreDataViewModel()
    @State var textFieldText = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                HStack {
                    TextField("Add fruit here...", text: $textFieldText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .shadow(color: .gray, radius: 5, x: 5, y: 5)
                    
                    Button {
                        guard !textFieldText.isEmpty else { return }
                        vm.addFruit(text: textFieldText)
                        textFieldText = ""
                    } label: {
                        Text("Submit")
                    }
                    .buttonStyle(.borderedProminent)
                    .shadow(color: .gray, radius: 5, x: 5, y: 5)
                }
                .padding(.horizontal)

                
                List {
                    ForEach(vm.savedEntitties) { entity in
                        Text(entity.name ?? "")
                            .onTapGesture {
                                vm.updateFruit(entity: entity)
                            }
                    }
                    .onDelete(perform: vm.deleteFruit)
                }
                .listStyle(PlainListStyle())
              
            }
            .navigationTitle("Fruits")
    }
}
}

struct CoreDataBC_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataBC()
    }
}
