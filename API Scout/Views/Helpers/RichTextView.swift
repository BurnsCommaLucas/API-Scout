//
//  RichTextView.swift
//  apiBoss
//
//  Created by Lucas on 1/31/24.
// lmao not doing this right now
// https://danielsaidi.com/blog/2022/06/13/building-a-rich-text-editor-for-uikit-appkit-and-swiftui

import Foundation
import AppKit

public protocol RichTextViewRepresentable {
    
    var attributedString: NSAttributedString { get }
}

public class RichTextView: NSTextView, RichTextViewRepresentable {
    public var attributedString: NSAttributedString {
        get { attributedString() }
        set { textStorage?.setAttributedString(newValue) }
    }
}
