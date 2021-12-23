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
    @State private var startButton: Bool = false
    @State private var endButton: Bool = false
    
    var body: some View {
        ZStack {
            Color.sambucus
                .ignoresSafeArea()
            
            VStack (alignment: .leading, spacing: 8) {
                competitionName
                competitionDecription
                datePicker
                Spacer()
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
            startDatePicker
            endDatePicker
        }
    }
}

extension CreateChallengeView {
    
    @ViewBuilder
    private var competitionName: some View {
        VStack(alignment: .leading) {
            Text("Competition Name")
                .modifier(TextModifier(color: .snowflake, size: 17, weight: .regular))
                .padding(.horizontal)
            FormField(value: $formVM.competitionName, placeholder: "competition name")
        }
    }
    
    @ViewBuilder
    private var startDatePicker: some View {
        if self.startButton {
            ZStack {
                Color.navyPeony
                    .ignoresSafeArea()
                    .opacity(0.5)
                    .onTapGesture {
                        withAnimation {
                            self.startButton.toggle()
                        }
                    }
                    .animation(.easeInOut(duration: 0.2))
                    
                DatePickerView(selectedDate: $formVM.startDate, dateDescription: "Start Date")
                    .background(Color.blueDepths)
                    .overlay(
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.blueDepths, lineWidth: 1.0)
                        }
                    )
                    .frame(width: Screen.width-24)
            }
            .animation(.easeInOut(duration: 0.2))
        }
    }
    
    @ViewBuilder
    private var endDatePicker: some View {
        if self.endButton {
            ZStack {
                Color.navyPeony
                    .ignoresSafeArea()
                    .opacity(0.5)
                    .onTapGesture {
                        self.endButton.toggle()
                    }
                    .animation(.easeInOut(duration: 0.2))
                
                DatePickerView(selectedDate: $formVM.endDate, dateDescription: "End Date")
                    .padding(.horizontal, 16)
                    .background(Color.blueDepths)
                    .overlay(
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.blueDepths, lineWidth: 1.0)
                        }
                    )
                    .frame(width: Screen.width-24)
            }
            .animation(.easeInOut(duration: 0.2))
        }
    }
    
    @ViewBuilder
    private var competitionDecription: some View {
        VStack(alignment: .leading) {
            Text("Competition Name")
                .modifier(TextModifier(color: .snowflake, size: 17, weight: .regular))
                .padding(.horizontal)
            
            TextEditorField(value: $formVM.competitionDescription, placeholder: "Describe your Competition")
        }
    }
    
    @ViewBuilder
    private var datePicker: some View {
        HStack {
            Text("Start Date")
                .modifier(TextModifier(color: Color.snowflake, size: 17, weight: .regular))
            Spacer()
            PlainButton(label: formVM.startDateString()) {
                withAnimation {
                    self.startButton.toggle()
                }
            }
        }
        .padding(10)
        .background(Color.blueDepths)
        .cornerRadius(5)
        .overlay (
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.blueDepths, lineWidth: 1.0)
            }
            .allowsHitTesting(false)
        )
        .padding(.horizontal)
        
        HStack {
            Text("End Date")
                .modifier(TextModifier(color: Color.snowflake, size: 17, weight: .regular))
            Spacer()
            PlainButton(label: formVM.endDateString()) {
                withAnimation {
                    self.endButton.toggle()
                }
            }
        }
        .padding(10)
        .background(Color.blueDepths)
        .cornerRadius(5)
        .overlay (
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.blueDepths, lineWidth: 1.0)
            }
            .allowsHitTesting(false)
        )
        .padding(.horizontal)
    }
}

struct CreateChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        CreateChallengeView()
    }
}
