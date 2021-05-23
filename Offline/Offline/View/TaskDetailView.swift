//
//  TaskDetailView.swift
//  Offline
//
//  Created by Pavel Sakhanko on 20.05.21.
//

import SwiftUI

struct TaskDetailView: View {
    var task: TestTask
  
    var body: some View {
      Text(task.title)
    }
}
