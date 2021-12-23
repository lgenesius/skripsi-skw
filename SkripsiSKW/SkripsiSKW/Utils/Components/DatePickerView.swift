//
//  DatePicker.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 23/12/21.
//

import SwiftUI

struct DatePickerView: View {
    @Binding var selectedDate: Date
    
    var dateDescription: String?
    
    var body: some View {
        VStack {
            DatePicker(selection: $selectedDate, in: Date()..., displayedComponents: .date) {
                Text(dateDescription ?? "Selected Date")
                    .modifier(TextModifier(color: Color.snowflake, size: 17, weight: .regular))
            }.datePickerStyle(
                GraphicalDatePickerStyle()
            )
        }
        
    }
}

extension DatePickerView {
    
}

struct DatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerView(selectedDate: .constant(Date()), dateDescription: "Start Date")
            .previewLayout(.sizeThatFits)
    }
}
