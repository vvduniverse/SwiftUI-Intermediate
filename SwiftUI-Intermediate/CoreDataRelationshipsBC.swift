//
//  CoreDataRelationshipsBC.swift
//  SwiftUI-Intermediate
//
//  Created by Vahtee Boo on 29.03.2022.
//

import SwiftUI
import CoreData

// 3 entities
// BusinessEntity
// DepartmentEntity
// EmployeeEntity

class CoreDataManager {
    static let instance = CoreDataManager()
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error loading Core Data. \(error)")
            }
        }
        context = container.viewContext
    }
    
    func save() {
        do {
            try context.save()
            print("Saved successfully!")
        } catch let error {
            print("Error saving Core Data. \(error.localizedDescription)")
        }
    }
}

class CoreDataRelationshipViewModel: ObservableObject {
    
    let manager = CoreDataManager.instance
    @Published var businesses = [BusinessEntity]()
    
    init() {
        getBusinesses()
    }
    
    func getBusinesses() {
        let request = NSFetchRequest<BusinessEntity>(entityName: "CoreDataContainer")
        
        do {
            businesses = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching. \(error.localizedDescription)")
        }
    }
    
    func addBusiness() {
        let newBusiness = BusinessEntity(context: manager.context)
        newBusiness.name = "Apple"
        save()
    }
    
    func save() {
        manager.save()
    }
}

struct CoreDataRelationshipsBC: View {
    
    @StateObject var vm = CoreDataRelationshipViewModel()
    @State var textFieldText = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    HStack {
                        TextField("Add fruit here...", text: $textFieldText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .shadow(color: .gray, radius: 5, x: 5, y: 5)
                        
                        Button {
                            vm.addBusiness()
//                            guard !textFieldText.isEmpty else { return }
//                            vm.addFruit(text: textFieldText)
//                            textFieldText = ""
                        } label: {
                            Text("Submit")
                        }
                        .buttonStyle(.borderedProminent)
                        .shadow(color: .gray, radius: 5, x: 5, y: 5)
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("Relationships")
        }
    }
}

struct CoreDataRelationshipsBC_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataRelationshipsBC()
    }
}
