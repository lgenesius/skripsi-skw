//
//  BadgeAdd.swift
//  SkripsiSKW
//
//  Created by Kevin Leon on 22/12/21.
//

import SwiftUI
import SDWebImageSwiftUI

public enum BadgeAlert {
    case error
    case done
    case remove
    case null
    
    func getAlertMessage() -> (title: String, message: String) {
        switch self {
            case .error:
                return ("Error: ", "You can't add more than 3 badges, remove one!")
            case .done:
                return ("Done: ", "Successfully added the Badge")
            case .remove:
                return ("Remove: ", "Successfully removed the Badge")
            case .null :
                return ("", ":")
        }
    }
}

struct BadgeAdd: View {
    @ObservedObject var badgesViewModel : BadgeViewModel
    @ObservedObject var badgesListVM: BadgeListViewModel
    @EnvironmentObject var sessionVM: SessionViewModel
    @Binding var errorAlert: BadgeAlert
    @Binding var badgeAlert: Bool
    
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
                                            Text("Received Date \(badgesViewModel.userBadge.recievedDate.shortDate)").bold().font(.system(size: 9)).foregroundColor(.white).padding(.bottom, 9)
                                        }
                }.foregroundColor(Color.white)
            }.frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height/3.5).cornerRadius(13)
        
            
            if badgesViewModel.userBadge.progress >= badgesViewModel.userBadge.goal && !badgesViewModel.userBadge.isHighlighted {
                            Button(action: {
                                UserService.highlightBadge(id: badgesViewModel.userBadge.id ?? "") { canAdd, error  in
                                    if error != nil { return }
                                    if !canAdd {
                                        withAnimation {
                                            errorAlert = .error
                                            badgeAlert.toggle()
                                        }
                                    } else {
                                        withAnimation {
                                            badgesListVM.fetchUserBadges(sessionVM: sessionVM)
                                            badgesListVM.showBadgeDetail.toggle()
                                            errorAlert = .done
                                            badgeAlert.toggle()
                                        }
                                    }
                                }
                            }, label: {
                                Text("Add to Highlight").bold().foregroundColor(.white)
                            }).frame(width: UIScreen.main.bounds.width/2).padding(.vertical, 5).border(Color.insignia).background(Color.insignia).cornerRadius(8)
                        } else if badgesViewModel.userBadge.isHighlighted {
                            Button(action: {
                                UserService.removeBadge(id: badgesViewModel.userBadge.id ?? "") { error in
                                    if error != nil { return }
                                    badgesListVM.fetchUserBadges(sessionVM: sessionVM)
                                    withAnimation {
                                        errorAlert = .remove
                                        badgesListVM.showBadgeDetail.toggle()
                                        badgeAlert.toggle()
                                    }
                                }   
                            }, label: {
                                Text("Remove").bold().foregroundColor(.white)
                            }).frame(width: UIScreen.main.bounds.width/2).padding(.vertical, 5).border(Color.insignia).background(Color.insignia).cornerRadius(8)
                        }
            
        }
    }
}

