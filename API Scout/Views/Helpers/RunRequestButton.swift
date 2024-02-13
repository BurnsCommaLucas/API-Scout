//
//  RequestRunner.swift
//  API Scout
//
//  Created by Lucas on 2/1/24.
//

import Foundation
import SwiftUI

struct RunRequestButton: View {
    @Environment(\.modelContext) var modelContext
    @ObservedObject var activeRequest: Request
    
    /// I'm aware this is not a great place to put the "run request" logic, but also it took me like a full week to get the state management *mostly* un-busted so I'll move this around to a better place later
    var body: some View {
        
        Button() {
            activeRequest.state = RunState.PREPARING
            
            // Save the state of the request when it's run
            do {
                try modelContext.save()
            } catch {}
            
            Task {
                await run()
            }
        } label: {
            Label("Send Request", systemImage: "paperplane")
                .labelStyle(.iconOnly)
        }
        .keyboardShortcut(KeyboardShortcut(KeyEquivalent.return, modifiers: EventModifiers.command))
    }
    
    /// Runs the request bound to this view and updates that request as appropriate with the result of the run
    private func run() async {
        guard let url: URL = URL(string: activeRequest.url) else {
            print("Invalid URL '\(activeRequest.url)'")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = activeRequest.method.rawValue
        
        if activeRequest.bodyType != .NONE && activeRequest.method != .GET {
            // TODO: allow encoding selection?
            request.httpBody = activeRequest.bodyData.data(using: .utf8)
            
            // Set this before general headers to allow overriding... I guess? probably a nicer way to do this
            request.setValue(activeRequest.bodyType.headerValue, forHTTPHeaderField: "Content-Type")
        }
        
        // TODO: test if this can override important headers like auth
        activeRequest.headers.forEach { header in
            if header.enabled && header.name != "" {
                request.setValue(header.value, forHTTPHeaderField: header.name)
            }
        }
        
        let session = URLSession(configuration: .ephemeral)
        let clock = ContinuousClock()
        var duration: ContinuousClock.Instant.Duration? = nil
        
        do {
            activeRequest.state = RunState.STARTED
            var data: Data? = nil
            var response: URLResponse? = nil
            
            duration = try await clock.measure {
                (data, response) = try await session.data(for: request)
            }
            activeRequest.response = ResponseData(body: data, response: response)
        } catch {
            print(error.localizedDescription)
            activeRequest.response = ResponseData(error: error)
        }
        activeRequest.response?.duration = duration
        activeRequest.state = RunState.FINISHED
    }
}

#Preview {
    @State var activeRequest = Request()
    return RunRequestButton(activeRequest: activeRequest)
        .padding()
}
