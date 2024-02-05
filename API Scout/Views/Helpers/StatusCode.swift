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
                Text("\(safeCode)")
                    .foregroundStyle(.black)
                    .background(
                        Rectangle()
                            .fill(safeCode < 400 ? .green : .red)
                            .padding([.top, .bottom], -8)
                            .padding(.leading, -9)
                    )
                    .fontWeight(.heavy)
                    .padding([.top, .leading, .bottom])
                Text(desc)
                    .foregroundStyle(.black)
                    .background(
                        Rectangle()
                            .fill(safeCode < 400 ? .green : .red)
                            .padding([.top, .bottom], -8)
                            .padding(.trailing, -9)
                            .padding(.leading, -4)
                    )
                    .fontWeight(.medium)
                    .textCase(.uppercase)
                    .padding([.top, .trailing, .bottom])
                    .padding(.leading, -4)
            }
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
