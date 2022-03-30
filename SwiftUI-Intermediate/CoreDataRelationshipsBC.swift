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
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                        Button {
                            vm.addBusiness()
                        } label: {
                            Text("Perform Action")
                        }
                        .buttonStyle(.borderedProminent)
                        .shadow(color: .gray, radius: 5, x: 5, y: 5)
                    }
//                    .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: true) {
                    HStack(alignment: .top) {
                        ForEach(vm.businesses) { business in
                            BusinessView(entity: business)
                        }
                    }
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


struct BusinessView: View {
    
    let entity: BusinessEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Name: \(entity.name ?? "")")
                .bold()
            
            if let departments = entity.departments?.allObjects as? [DepartmentEntity] {
                Text("Departments:")
                    .bold()
                ForEach(departments) { department in
                    Text(department.name ?? "")
                }
                
            }
            
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Departments:")
                    .bold()
                ForEach(employees) { employee in
                    Text(employee.name ?? "")
                }
            }
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.gray.opacity(0.5))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}
