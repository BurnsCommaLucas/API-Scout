//
//  HeaderEntry.swift
//  API Scout
//
//  Created by Lucas on 2/5/24.
//

import Foundation

struct HeaderEntry: Codable, Identifiable, Hashable {
    var id = UUID()
    var name = ""
    var value = ""
    var enabled = true
}
