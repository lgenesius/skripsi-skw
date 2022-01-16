//
//  BadgeAdd.swift
//  SkripsiSKW
//
//  Created by Kevin Leon on 22/12/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct BadgeAdd: View {
    @ObservedObject var badgesViewModel : BadgeViewModel
    @ObservedObject var badgesListVM: BadgeListViewModel
    
    var body: some View {
        VStack(alignment: .center){
            ZStack{
                Color.blueDepths.ignoresSafeArea()
                VStack{
                    Spacer()
                    Text("\(badgesViewModel.userBadge.name)").bold()
                    WebImage(url: URL(string: badgesViewModel.userBadge.image))
                                            .resizable()
                                            .indicator(.activity)
                                            .scaledToFill()
                                            .frame(width: 94, height: 94)
                                            .clipShape(Circle())
                                            .foregroundColor(Color.yellow)
                    
                    
                    Text("\(badgesViewModel.userBadge.description)").font(.system(size: 11)).frame(width: 173, height: 49)

                                        if badgesViewModel.userBadge.progress < badgesViewModel.userBadge.goal {
                                            Text("Progress \(badgesViewModel.userBadge.progress) / \(badgesViewModel.userBadge.goal)").bold().font(.system(size: 9)).foregroundColor(.white).padding(.bottom, 9)
                                        } else {
                                            Text("Received Date \(badgesViewModel.userBadge.recievedDate)").bold().font(.system(size: 9)).foregroundColor(.white).padding(.bottom, 9)
                                        }
                }.foregroundColor(Color.white)
            }.frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height/3.5).cornerRadius(13)
        
            
            if badgesViewModel.userBadge.progress >= badgesViewModel.userBadge.goal && !badgesViewModel.userBadge.isHighlighted {
                            Button(action: { }, label: {
                                Text("Add to Highlight").bold().foregroundColor(.white)
                            }).frame(width: UIScreen.main.bounds.width/2).padding(.vertical, 5).border(Color.insignia).background(Color.insignia).cornerRadius(8)
                        } else if badgesViewModel.userBadge.isHighlighted {
                            Button(action: { }, label: {
                                Text("Remove").bold().foregroundColor(.white)
                            }).frame(width: UIScreen.main.bounds.width/2).padding(.vertical, 5).border(Color.insignia).background(Color.insignia).cornerRadius(8)
                        }
            
        }
    }
}

