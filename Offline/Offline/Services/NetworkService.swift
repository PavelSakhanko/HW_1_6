//
//  NetworkService.swift
//  Offline
//
//  Created by Pavel Sakhanko on 20.05.21.
//

import Foundation

protocol NetworkServiceProtocol {
  func makeRequestFromURL() -> String
  func startDataTask(completionHandler: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void)
  func parseFromData(data: Data) -> [TestTask]
}

class NetworkService: NetworkServiceProtocol {
  func makeRequestFromURL() -> String {
      var urlComponents = URLComponents()
      urlComponents.scheme = "https"
      urlComponents.host = "jsonplaceholder.typicode.com"
      urlComponents.path = "/todos"

      return urlComponents.url!.absoluteString
  }

  func startDataTask(completionHandler: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
      let urlString = makeRequestFromURL()
      guard let url = URL(string: urlString) else { return }
      let task = URLSession.shared.dataTask(with: url, completionHandler: completionHandler)
      task.resume()
  }

  func parseFromData(data: Data) -> [TestTask] {
      var response: [TestTask]?
      do {
          response = try JSONDecoder().decode([TestTask].self, from: data)
      } catch {
          return []
      }

      return response ?? []
  }
}
