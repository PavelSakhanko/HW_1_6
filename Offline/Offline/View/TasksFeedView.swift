//
//  TasksFeedView.swift
//  Offline
//
//  Created by Pavel Sakhanko on 20.05.21.
//

import SwiftUI
import Reachability

struct TasksFeedView: View {

    @ObservedObject var viewModel: TaskViewModel

    var body: some View {
        NavigationView {
            VStack {
              List(viewModel.taskFeedItems) { task in
                  NavigationLink(destination: TaskDetailView(task: task)) {
                    Text(task.title)
                    Text("\(task.completed.description)")
                        .font(.system(size: 11))
                        .foregroundColor(Color.gray)
                  }
                }
            }
            .navigationBarTitle(Text("TODO:"))
            .onAppear {
              
            }.onDisappear {
              NetworkHelper().removeSelf()
              saveInDB()
            }
        }
    }

    func saveInDB() {
      viewModel.taskFeedItems.forEach { task in
        viewModel.storageService?.create(
          title: task.title,
          completed: task.completed)
      }
    }
}
