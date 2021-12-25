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
}

struct Infos {
    static func getInfos(workoutType: WorkoutType) -> [Info] {
        var infos = [Info]()
        infos.append(Info(imageName: workoutType.imageString, title: workoutType.title, description: workoutType.workoutDesc))
        infos.append(Info(imageName: workoutType.imageString, title: "Benefits", description: workoutType.benefitsDesc))
        infos.append(Info(imageName: workoutType.imageString, title: "Don't Forget to Warm Up!", description: "A good warm-up before a workout dilates your blood vessels, ensuring that your muscles are well supplied with oxygen."))
        return infos
    }
}
