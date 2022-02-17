//
//  Persistence.swift
//  dbtest
//
//  Created by 坪田和樹 on 2022/02/17.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for i in 0..<WebList.count {
            let newItem = Item(context: viewContext)
            newItem.id = UUID()
            newItem.name = WebList[i].name
            newItem.url = WebList[i].url
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer
    // db接続失敗
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "dbtest")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
