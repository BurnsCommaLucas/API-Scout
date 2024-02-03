//
//  RightClickable.swift
//  apiBoss
//
//  Created by Lucas on 2/2/24.
//

import SwiftUI

struct RightClickableSwiftUIView: NSViewRepresentable {
    func updateNSView(_ nsView: RightClickableView, context: NSViewRepresentableContext<RightClickableSwiftUIView>) {
        print("Update")
    }
    
    func makeNSView(context: Context) -> RightClickableView {
        RightClickableView()
    }
}

class RightClickableView: NSView {
    override func mouseDown(with theEvent: NSEvent) {
        print("left mouse")
    }
    
    override func rightMouseDown(with theEvent: NSEvent) {
        print("right mouse")
    }
}
