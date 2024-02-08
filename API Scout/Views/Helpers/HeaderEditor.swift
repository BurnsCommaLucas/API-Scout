//
//  HeaderEditor.swift
//  API Scout
//
//  Created by Lucas on 2/5/24.
//

import SwiftUI
import CodeEditor
import Highlightr

struct HeaderEditor: View {
    @State private var selectedRow: UUID? = nil
    @FocusState private var focus: Bool
    @EnvironmentObject var request: Request
    @EnvironmentObject var generalSettings: GeneralSettings
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            ScrollView{
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.fixed(15)), GridItem(.fixed(30))]) {
                    // Headers
                    Text("Name")
                    Text("Value")
                    Spacer()
                    Spacer()
                    
                    // Body
                    // TODO: Show the auth header inline here
                    // TODO: Show the content type header inline here
                    ForEach($request.headers) { $h in
                        // TODO: Make these blend in with the editor styles
                        TextField(text: $h.name, label: {})
                            .font(monoFont)
                        TextField(text: $h.value, label: {})
                            .font(monoFont)
                        Toggle(isOn: $h.enabled, label: {})
                        Button(action: {
                            selectedRow = h.id
                            removeHeader()
                        }, label: {
                            Label("Remove Row", systemImage: "trash")
                                .labelStyle(.iconOnly)
                        })
                    }
                }
            }
            
            HStack {
                Spacer()
                Button(action: {
                    addHeader()
                }, label: {
                    Label("Add Row", systemImage: "plus").labelStyle(.iconOnly)
                })
            }
        }
        .padding()
        .onAppear(perform: {
            if request.headers.isEmpty {
                request.headers.append(HeaderEntry())
            }
        })
    }
    
    private func addHeader() {
        request.headers.append(HeaderEntry())
    }
    
    private func removeHeader() {
        if let selectedRowButForReal = selectedRow {
            request.headers.removeAll { h in
                h.id == selectedRowButForReal
            }
        }
    }
}

struct HeaderEditor_Previews : PreviewProvider{
    @State static var headers = [
        HeaderEntry(name: "Content-Type", value: "application/json"),
        HeaderEntry(name: "User-Agent", value: "API-Scout")
    ]
    static var previews: some View {
        HeaderEditor()
            .environmentObject(Request(
                id: "", name: "", method: .POST, url: "", bodyType: .PLAIN, bodyData: "", headers: headers
            ))
            .environmentObject(GeneralSettings())
    }
}
