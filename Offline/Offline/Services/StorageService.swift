//
//  StorageService.swift
//  Offline
//
//  Created by Pavel Sakhanko on 20.05.21.
//

import CoreData
import SwiftUI

protocol StorageServiceProtocol {
  func create(title: String, completed: Bool)
  func read() throws -> [TestTask]
  func update()
  func delete(task: Task)
}

class StorageService: StorageServiceProtocol {

  let viewContext: NSManagedObjectContext

  init(viewContext: NSManagedObjectContext) {
    self.viewContext = viewContext
  }

  func create(title: String, completed: Bool) {
      let newTask = Task(context: self.viewContext)
      newTask.id = Int16.random(in: 1...5000)
      newTask.title = title
      newTask.completed = completed
      newTask.timestamp = Date()
      saveData()
  }

  func read() throws -> [TestTask] {
    let tasks = try self.viewContext.fetch(Task.fetchRequest() as NSFetchRequest<Task>)
    var tasksFromDB = [TestTask]()

    tasks.forEach { task in
      let task = TestTask(
        id: Int(task.id),
        title: task.title ?? "",
        completed: task.completed
      )
      tasksFromDB.append(task)
    }
    return tasksFromDB
  }

  func update() {}

  func delete(task: Task) {
    self.viewContext.delete(task)
    saveData()
  }

  fileprivate func saveData() {
    do {
      try self.viewContext.save()
    } catch {
      print(error.localizedDescription)
    }
  }
}
