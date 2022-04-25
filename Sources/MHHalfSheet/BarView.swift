//
//  BarView.swift
//  
//
//  Created by Mark Houston on 4/25/22.
//

import SwiftUI

struct BarView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: 40, height: 3, alignment: .center)
            .foregroundColor(.gray)
            .opacity(0.6)
    }
}
