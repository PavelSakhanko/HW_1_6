//
//  OfflineApp.swift
//  Offline
//
//  Created by Pavel Sakhanko on 20.05.21.
//

import SwiftUI
import CoreData

@main
struct OfflineApp: App {

  var persistentContainer: NSPersistentCloudKitContainer = {
    let container = NSPersistentCloudKitContainer(name: "Offline")
    container.loadPersistentStores(completionHandler: { (_, error) in
        if let error = error as NSError? {
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    })
    return container
  }()

  mutating func saveContext () {
    let context = persistentContainer.viewContext
    if context.hasChanges {
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
  }

  var context: NSManagedObjectContext {
      return persistentContainer.viewContext
  }

  var serviceLocator: ServiceLocator {
    let serviceLocator = ServiceLocator()
    serviceLocator.register(NetworkService())
    serviceLocator.register(StorageService(viewContext: context))
    return serviceLocator
  }

  var body: some Scene {
    WindowGroup {
      TasksFeedView(viewModel: TaskViewModel(locator: serviceLocator))
    }
  }
}
