//
//  Task.swift
//  Offline
//
//  Created by Pavel Sakhanko on 20.05.21.
//

struct Task: Codable, Identifiable {
    public var id: Int
    public var title: String
    public var completed: Bool
}
