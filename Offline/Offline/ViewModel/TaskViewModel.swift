//
//  GifViewModel.swift
//  Offline
//
//  Created by Pavel Sakhanko on 20.05.21.
//

import Foundation
import CoreData

class TaskViewModel: ObservableObject {

    @Published var taskFeedItems = [TestTask]()
    @Published var networkService: NetworkService?
    @Published var storageService: StorageService?

    let locator: ServiceLocator

    init(locator: ServiceLocator) {
      self.locator = locator
      self.networkService = getNetworkService()
      self.storageService = getStorageService()

      selectDataSource()
    }

    func selectDataSource() {
      switch NetworkHelper().connection() {
      case .wifi, .cellular:
        loadTasksFromNetwork()
      case .unavailable, .none:
        loadTasksFromDB()
      }
    }

    func getNetworkService() -> NetworkService? {
      guard let service: NetworkService = locator.resolve() else { return nil }
      return service
    }

    func getStorageService() -> StorageService? {
      guard let service: StorageService = locator.resolve() else { return nil }
      return service
    }

    func loadTasksFromDB() {
      let tasksFromDBArray = try? storageService?.read()
      addTasksInTaskFeedItems(tasks: tasksFromDBArray ?? [TestTask]())
    }

    func loadTasksFromNetwork(currentItem: TestTask? = nil) {
      networkService?.startDataTask(
        completionHandler: parseFromResponse(data:response:error:)
      )
    }

    private func parseFromResponse(data: Data?, response: URLResponse?, error: Error?) {
      guard error == nil,
            let data = data,
            let tasks = networkService?.parseFromData(data: data)
      else {
          return
      }

      addTasksInTaskFeedItems(tasks: tasks)
    }

    private func addTasksInTaskFeedItems(tasks: [TestTask]) {
      DispatchQueue.main.async {
        self.taskFeedItems = []
        self.taskFeedItems.append(contentsOf: tasks)
      }
    }
}
