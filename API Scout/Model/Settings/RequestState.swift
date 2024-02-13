//
//  RequestState.swift
//  API Scout
//
//  Created by Lucas on 2/8/24.
//

import Foundation
import SwiftUI
import SwiftData
import CodeEditor

class RequestState: ObservableObject {
    @State var activeRequest = Request()
    @State var requestHasBeenSelected = false
}
