//
//  StatusCode.swift
//  API Scout
//
//  Created by Lucas on 2/3/24.
//

import SwiftUI

struct StatusCode: View {
    var code: Int?
    
    var body: some View {
        if let safeCode = code {
            let desc = switch safeCode {
            case 200:
                "OK"
            case 418:
                "I'm a teapot"
            default:
                HTTPURLResponse.localizedString(forStatusCode: safeCode)
            }
            HStack {
                // This should probably just be an AttributedString, I went way overboard
                Text("\(safeCode) \(desc.uppercased())")
                    .foregroundStyle(.white)
                    .background(
                        RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                            .fill(safeCode < 400 ? .green : .red)
                            .padding(-9)
                    )
            }.padding()
        }
    }
}

#Preview {
    Group {
        StatusCode(code: 200)
        StatusCode(code: 302)
        StatusCode(code: 403)
        StatusCode(code: 501)
    }
}
