//
//  NSCustomPersistentContainer.swift
//  kpiRozkladSwiftUI
//
//  Created by Денис Данилюк on 28.06.2020.
//

import UIKit
import CoreData

class NSCustomPersistentContainer: NSPersistentContainer {
    override open class func defaultDirectoryURL() -> URL {
        var storeURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.ddanilyuk.kpiRozkladSwiftUI")
        storeURL = storeURL?.appendingPathComponent("LessonData")
        return storeURL!
    }
}
