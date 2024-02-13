//
//  DurationPill.swift
//  API Scout
//
//  Created by Lucas on 2/12/24.
//

import SwiftUI

struct DurationPill: View {
    var duration: ContinuousClock.Instant.Duration
    
    init(_ duration: ContinuousClock.Instant.Duration) {
        self.duration = duration
    }
    
    var body: some View {
        Pill(
            duration.formatted(.units(
                allowed: [primaryUnit],
                fractionalPart: .show(length: 2)
            ))
        )
    }
    
    private var primaryUnit: Duration.UnitsFormatStyle.Unit {
        // Attoseconds 🙄
        let (seconds, attoseconds) = duration.components
        let millis = Double(attoseconds) * 1e-15
        return switch seconds {
        case 0:
            if millis < 1 {
                // Microseconds is as low as this type goes
                .microseconds
            }
            else {
                .milliseconds
            }
        case _ where seconds < 60:
            .seconds
        case _ where seconds < 3600:
            .minutes
        case _ where seconds < 86400:
            .hours
        // Holy moly literally how
        default:
            .days
        }
    }
}

#Preview {
    ScrollView {
        DurationPill(.seconds(0.00003798423))
            .padding()
        DurationPill(.seconds(0.00213479823))
            .padding()
        DurationPill(.seconds(1.1501111))
            .padding()
        DurationPill(.seconds(62.9128347))
            .padding()
        DurationPill(.seconds(4040.9128347))
            .padding()
        DurationPill(.seconds(404000.9128347))
            .padding()
    }
}
