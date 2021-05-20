//
//  ContentView.swift
//  Offline
//
//  Created by Pavel Sakhanko on 20.05.21.
//

import SwiftUI

struct GifsFeedView: View {

    @ObservedObject var viewModel: TaskViewModel

    var body: some View {
        NavigationView {
            VStack {
              List(viewModel.taskFeedItems) { task in
                  Text(task.title)
                  Text("\(task.completed.description)")
                      .font(.system(size: 11))
                      .foregroundColor(Color.gray)
                }
            }
            .navigationBarTitle(Text("TODO:"))
        }
    }
}
