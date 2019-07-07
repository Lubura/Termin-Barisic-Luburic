//
//  ImportDataService.swift
//  Termin
//
//  Created by Marko Barisic on 06/07/2019.
//  Copyright © 2019 Marko Barisic. All rights reserved.
//

import Foundation

class ImportDataService {
    
    func importPlayers(){
        if let url = Bundle.main.url(forResource: "playersHuligani", withExtension: "json"){
            do {
                let data = try Data(contentsOf: url)
                let object = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                if let jsonResult = object as? [String:Any], let player = jsonResult["huligani"] as? [Any] {
                    for json in player {
                        if let jsonData = json as? [String:Any]{
                            Player.createFrom(json: jsonData)
                        }
                    }
                }
            } catch {
                // handle error
            }
        }
//        print(DataController.shared.deletePlayer(key: "Drle"))
//        print(DataController.shared.viewPlayerDetails(key: "Čoki"))
    }
}
