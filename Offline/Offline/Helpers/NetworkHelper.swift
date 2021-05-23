//
//  NetworkHelper.swift
//  Offline
//
//  Created by Pavel Sakhanko on 20.05.21.
//

import Foundation
import Reachability

class NetworkHelper {

  let reachability = try! Reachability()

  func connection() -> Reachability.Connection {
    reachability.connection
  }

  func add() {
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(reachabilityChanged(note:)),
      name: .reachabilityChanged, object: reachability
    )
    do {
        try reachability.startNotifier()
    } catch {
        print("Unable to start notifier")
    }
  }

  func removeSelf() {
    reachability.stopNotifier()
    NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
  }

  @objc func reachabilityChanged(note: Notification) {
      let reachability = note.object as! Reachability

      switch reachability.connection {
      case .wifi:
          print("Wifi Connection")
      case .cellular:
          print("Cellular Connection")
      case .unavailable:
          print("No Connection")
      case .none:
          print("No Connection")
      }
  }
}
