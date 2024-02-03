//
//  Extensions.swift
//  apiBoss
//
//  Created by Lucas on 2/2/24.
//

import SwiftUI

extension String {
   func widthOfString(usingFont font: Font) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}
