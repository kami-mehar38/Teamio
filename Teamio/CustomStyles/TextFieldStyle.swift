//
//  TextFieldStyle.swift
//  Teamio
//
//  Created by Kamran Ramzan on 05/05/2021.
//

import SwiftUI

struct OvalTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(25)
            .background(Color.white)
            .cornerRadius(50)
            .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(Color.init(hex: "#4F4F4F"), lineWidth: 0.25))
    }
}
