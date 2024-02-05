//
//  RequestRunner.swift
//  apiBoss
//
//  Created by Lucas on 2/1/24.
//

import Foundation
import SwiftUI

struct RequestRunner {
    @Binding var selectedRequest: Request
    @Binding var requestHasBeenRun: Bool
    @Binding var responseContents: ResponseData

    /// Runs the request bound to the ``RequestRunner`` and updates other bound variables as appropriate with the result of that run
    func run() {
        // create get request
        guard let url: URL = URL(string: selectedRequest.url) else {
            print("Invalid URL \(selectedRequest.url)")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = selectedRequest.method.rawValue
        
        if selectedRequest.bodyType != .NONE && selectedRequest.method != .GET {
            // TODO allow encoding selection?
            request.httpBody = selectedRequest.bodyData.data(using: .utf8)
            request.setValue(selectedRequest.bodyType.headerValue, forHTTPHeaderField: "Content-Type")
        }
        
        let session = URLSession(configuration: .ephemeral)
        
        session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                // Handle common errors nicely (could not connect, 404, etc)
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            responseContents = ResponseData(body: data, response: response, error: error)
            requestHasBeenRun = true
        }.resume()
    }
}
