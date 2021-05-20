//
//  GifViewModel.swift
//  Offline
//
//  Created by Pavel Sakhanko on 20.05.21.
//

import Foundation

class TaskViewModel: ObservableObject {

    @Published var taskFeedItems = [Task]()
    @Published var networkService: NetworkService?
    private let locator: ServiceLocator

    init(locator: ServiceLocator) {
      self.locator = locator
      self.networkService = getService()
      loadGifs()
    }
  
    func getService() -> NetworkService? {
        guard let service: NetworkService = locator.resolve() else { return nil }
        return service
    }

    func loadGifs(currentItem: Task? = nil) {
        networkService?.startDataTask(
          completionHandler: parseGifsFromResponse(data:response:error:)
        )
    }

    private func parseGifsFromResponse(data: Data?, response: URLResponse?, error: Error?) {
        guard error == nil,
              let data = data,
              let tasks = networkService?.parseFromData(data: data)
        else {
            return
        }

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.taskFeedItems = []
            self.taskFeedItems.append(contentsOf: tasks)
        }
    }
}
