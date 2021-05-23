//
//  Task.swift
//  Offline
//
//  Created by Pavel Sakhanko on 20.05.21.
//

struct TestTask: Codable, Identifiable {
    let id: Int
    let title: String
    let completed: Bool
}
