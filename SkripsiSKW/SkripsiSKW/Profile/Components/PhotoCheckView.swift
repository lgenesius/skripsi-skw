//
//  PhotoCheckView.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 07/01/22.
//

import SwiftUI

struct PhotoCheckView: View {
    @Binding var isPresented: Bool
    @Binding var imageData: Data
    
    var body: some View {
        if isPresented {
            ZStack {
                Color.black
                    .opacity(0.8)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    Image(uiImage: UIImage(data: imageData)!)
                        .resizable()
                        .scaledToFill()
                        .frame(width: Screen.width / 2, height: Screen.width / 2)
                        .clipShape(Circle())
                    
                    Text("Do you want to change?")
                        .foregroundColor(.white)
                        .padding(.top, 5)
                    
                    HStack(spacing: 20) {
                        Button {
                            withAnimation {
                                isPresented = false
                                imageData = Data()
                            }
                        } label: {
                            Text("Cancel")
                                .foregroundColor(.white)
                                .frame(width: 100, height: 50)
                                .background(Color.insignia)
                                .cornerRadius(10)
                        }

                        Button {
                            
                        } label: {
                            Text("Yes")
                                .foregroundColor(.white)
                                .frame(width: 100, height: 50)
                                .background(Color.insignia)
                                .cornerRadius(10)
                        }

                    }
                    Spacer()
                }
            }
            
        }
    }
}

struct PhotoCheckView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoCheckView(isPresented: .constant(true), imageData: .constant(Data()))
    }
}
