//
//  CreateChallengeView.swift
//  SkripsiSKW
//
//  Created by Jackie Leonardy on 23/12/21.
//

import SwiftUI

struct CreateChallengeView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var createFormVM: ChallengeFormViewModel = ChallengeFormViewModel()
    @EnvironmentObject var sessionVM: SessionViewModel
    
    @State private var startButton: Bool = false
    @State private var endButton: Bool = false
    
    var body: some View {
        if #available(iOS 15.0, *) {
            mainBody
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(Text("Create Competition"))
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel")
                            .foregroundColor(.notYoCheese)
                    }
                }
                
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        createFormVM
                            .createChallenge(sessionVM: sessionVM) {
                                if !createFormVM.alertPresented {
                                    presentationMode.wrappedValue.dismiss()
                                }
                                createFormVM.isLoading = false
                            }
                    } label: {
                        Text("Save")
                            .foregroundColor(.notYoCheese)
                    }
                    .opacity(createFormVM.isValid ? 1.0 : 0.5)
                    .disabled(!createFormVM.isValid)
                }
            }
            .alert(
                createFormVM.getAlertData().title,
                isPresented: $createFormVM.alertPresented
            ) {
                Button("Ok", role: .cancel, action: {})
            } message: {
                Text(createFormVM.getAlertData().message)
            }
        } else {
            mainBody
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(Text("Create Competition"))
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading:
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Cancel")
                            .foregroundColor(.notYoCheese)
                    }),
                trailing:
                    Button(action: {
                        createFormVM
                            .createChallenge(sessionVM: sessionVM) {
                                if !createFormVM.alertPresented {
                                    presentationMode.wrappedValue.dismiss()
                                }
                                createFormVM.isLoading = false
                            }
                    }, label: {
                        Text("Save")
                            .foregroundColor(.notYoCheese)
                    })
                    .opacity(createFormVM.isValid ? 1.0 : 0.5)
                    .disabled(!createFormVM.isValid)
            )
            .alert(isPresented: $createFormVM.alertPresented) {
                Alert(title: Text(createFormVM.getAlertData().title), message: Text(createFormVM.getAlertData().message), dismissButton: .cancel(Text("Ok")))
            }
        }
    }
}

extension CreateChallengeView {
    
    @ViewBuilder
    private var mainBody: some View {
        ZStack {
            Color.sambucus
                .ignoresSafeArea()
            
            ScrollView {
                VStack (alignment: .leading, spacing: 24) {
                    competitionName
                    competitionDecription
                    competitionPeriodSegmented
                    datePicker
                    Spacer()
                }
                .padding(.top, 24)
            }
            
            VStack {
                startDatePicker
                endDatePicker
            }
            
            LoadingCard(isLoading: createFormVM.isLoading, message: "Creating Competition...")
        }
    }
    
    @ViewBuilder
    private var competitionName: some View {
        VStack(alignment: .leading) {
            Text("Competition Name")
                .modifier(TextModifier(color: .snowflake, size: 17, weight: .regular))
                .padding(.horizontal)
            FormField(value: $createFormVM.competitionName, placeholder: "Competition name")
            
            ErrorText(errorMessage: createFormVM.competitionNameErrorMessage)
        }
    }
    
    @ViewBuilder
    private var startDatePicker: some View {
        if self.startButton {
            ZStack {
                Color.navyPeony
                    .ignoresSafeArea()
                    .opacity(0.5)
                    .gesture(
                        TapGesture()
                            .onEnded { _ in
                                withAnimation {
                                    self.startButton.toggle()
                                }
                        }
                    )
                    .animation(.easeInOut(duration: 0.5))
                    
                DatePickerView(selectedDate: $createFormVM.startDate, dateDescription: "Start Date")
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
                    .gesture(
                        TapGesture()
                            .onEnded { _ in
                                withAnimation {
                                    self.endButton.toggle()
                                }
                        }
                    )
                    .animation(.easeInOut(duration: 0.5))
                
                DatePickerView(selectedDate: $createFormVM.endDate, dateDescription: "End Date")
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
            .animation(.easeInOut(duration: 052))
        }
    }
    
    @ViewBuilder
    private var competitionDecription: some View {
        VStack(alignment: .leading) {
            Text("Competition Description")
                .modifier(TextModifier(color: .snowflake, size: 17, weight: .regular))
                .padding(.horizontal)
            
            TextEditorField(value: $createFormVM.competitionDescription, placeholder: "Describe your Competition")
            
            ErrorText(errorMessage: createFormVM.competitionDescriptionErrorMessage)
        }
    }
    
    @ViewBuilder
    private var competitionPeriodSegmented: some View {
        VStack(alignment: .leading) {
            Text("Competition Period")
                .modifier(TextModifier(color: .snowflake, size: 17, weight: .regular))
                .padding(.horizontal)
            
            Picker("", selection: $createFormVM.competitionField) {
                ForEach(competitionPeriod.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }.pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal, 16)
        }
    }
    
    
    @ViewBuilder
    private var datePicker: some View {
        VStack(spacing: 14) {
            datePickerStart
            datePickerEnd
        }
    }
    
    @ViewBuilder
    private var datePickerStart: some View {
        HStack {
            Text("Start Date")
                .modifier(TextModifier(color: Color.snowflake, size: 17, weight: .regular))
            Spacer()
            PlainButton(label: createFormVM.startDateString()) {
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
    }
    
    @ViewBuilder
    private var datePickerEnd: some View {
        HStack {
            Text("End Date")
                .modifier(TextModifier(color: Color.snowflake, size: 17, weight: .regular))
            Spacer()
            PlainButton(label: createFormVM.endDateString()) {
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
