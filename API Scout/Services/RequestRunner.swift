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

    func run() {
        // create get request
        guard let url: URL = URL(string: selectedRequest.url) else {
            print("Invalid URL \(selectedRequest.url)")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = selectedRequest.method.rawValue
        
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
    
    //    func post() async {
    ////        let json: [String: Any] = ["title": "ABC",
    ////                                   "dict": ["1":"First", "2":"Second"]]
    ////
    ////        let jsonData = try? JSONSerialization.data(withJSONObject: json)
    //        var string = "Hey look at me it's the body contents"
    //        var data = string.data(using: .utf8)
    //
    //        // create post request
    //        let url = URL(string: "http://localhost:8080/")!
    //        var request = URLRequest(url: url)
    //        request.httpMethod = "POST"
    //
    //
    //        let task = URLSession.shared.dataTask(with: request) { data, response, error in
    //            print("Ran the ding dang thing")
    //            guard let data = data, error == nil else {
    //                print(error?.localizedDescription ?? "No data")
    //                return
    //            }
    //            print(response)
    ////            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
    ////            if let responseJSON = responseJSON as? [String: Any] {
    ////                print(responseJSON)
    ////            }
    //        }
    //
    //    }
}
