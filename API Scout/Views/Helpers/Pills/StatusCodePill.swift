//
//  StatusCode.swift
//  API Scout
//
//  Created by Lucas on 2/3/24.
//

import SwiftUI

struct StatusCodePill: View {
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
            
            let fullDesc = "\(safeCode) \(desc)".uppercased()

            Pill(fullDesc, backgroundColor:  { _ in
                safeCode < 400 ? .green : .red
            })
        }
    }
}

#Preview {
    Group {
        StatusCodePill(code: 200)
        StatusCodePill(code: 302)
        StatusCodePill(code: 403)
        StatusCodePill(code: 501)
    }
}
