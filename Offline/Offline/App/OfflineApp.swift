//
//  OfflineApp.swift
//  Offline
//
//  Created by Pavel Sakhanko on 20.05.21.
//

import SwiftUI

@main
struct OfflineApp: App {
    let persistenceController = PersistenceController.shared
  
    var serviceLocator: ServiceLocator {
      let serviceLocator = ServiceLocator()
      serviceLocator.register(NetworkService())
      return serviceLocator
    }

    var body: some Scene {
      WindowGroup {
        GifsFeedView(viewModel: TaskViewModel(locator: serviceLocator))
          .environment(\.managedObjectContext, persistenceController.container.viewContext)
      }
    }
}
