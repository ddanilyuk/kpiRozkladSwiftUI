//
//  Server.swift
//  kpiRozkladSwiftUI
//
//  Created by Денис Данилюк on 26.06.2020.
//

import UIKit


func getGroups(complition: @escaping ([Lesson]) -> ()) {
    guard let url = URL(string: "https://api.rozklad.org.ua/v2/groups/5489/lessons") else { return }
    print(url)
    let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
        guard let data = data else { return }
        let decoder = JSONDecoder()
        do {
            if let JSONString = String(data: data, encoding: String.Encoding.utf8) {
               print(JSONString)
            }
            guard let serverFULLDATA = try? decoder.decode(WelcomeLessons.self, from: data) else { return }
            complition(serverFULLDATA.data)
        }
    }
    task.resume()
}
