//
//  Info.swift
//  SkripsiSKW
//
//  Created by Luis Genesius on 24/12/21.
//

import Foundation

struct Info: Identifiable {
    let id = UUID().uuidString
    let imageName: String
    let title: String
    let description: String
    var completion: ((Bool) -> Void)?
}

struct Infos {
    static func getInfos(workoutType: WorkoutType) -> [Info] {
        var infos = [Info]()
        infos.append(
            Info(
                imageName: "info1",
                title: "Show Full Body in Camera Frame",
                description: "Please show your full body from your head to your ankle in order to improve the accuracy of the body pose-detection."
            )
        )
        infos.append(
            Info(
                imageName: "info2",
                title: "Don’t Wear Flowing or Robe-like Cloth",
                description: "Please don’t wear robe or cloak-like clothing when you started exercising using this feature because it can reduces detection accuracy."
            )
        )
        infos.append(
            Info(
                imageName: "dummy",
                title: "Please Appear Alone in Camera Frame",
                description: "Attempting to detect body poses in dense crowd scenes is likely to produce inaccurate results."
            )
        )
        infos.append(
            Info(imageName: workoutType.infoImageString,
                 title: workoutType.workoutTitleInfo,
                 description: workoutType.workoutDesc,
                 completion: { status in
                     workoutType.setDefaultStatus(status)
                 }
                )
        )
        return infos
    }
}
