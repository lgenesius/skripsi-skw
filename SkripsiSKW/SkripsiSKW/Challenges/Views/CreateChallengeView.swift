//
//  CreateChallengeView.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 23/12/21.
//

import SwiftUI

struct CreateChallengeView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var formVM: ChallengeFormViewModel = ChallengeFormViewModel()
    
    var body: some View {
        ZStack {
            Color.sambucus
                .ignoresSafeArea()
            
            VStack {
                competitionField
                datePicker
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(Text("Create Competition"))
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("cancel")
                            .foregroundColor(.notYoCheese)
                    }
                }
                
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        Text("Save")
                            .foregroundColor(.notYoCheese)
                    }
                }
            }
        }
    }
}

extension CreateChallengeView {
    
    @ViewBuilder
    private var competitionField: some View {
        FormField(value: $formVM.competitionName, placeholder: "competition name")
    }
    
    @ViewBuilder
    private var datePicker: some View {
        VStack {
            DatePickerView(selectedDate: $formVM.startDate, dateDescription: "Start Date")
            DatePickerView(selectedDate: $formVM.endDate, dateDescription: "End Date")
        }.padding(16)
    }
}

struct CreateChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        CreateChallengeView()
    }
}
