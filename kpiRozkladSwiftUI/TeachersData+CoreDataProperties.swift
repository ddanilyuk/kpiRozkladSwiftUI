//
//  TeachersData+CoreDataProperties.swift
//  kpiRozkladSwiftUI
//
//  Created by Денис Данилюк on 28.06.2020.
//
//

import Foundation
import CoreData


extension TeachersData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TeachersData> {
        return NSFetchRequest<TeachersData>(entityName: "TeachersData")
    }

    @NSManaged public var teacherFullName: String?
    @NSManaged public var teacherID: Int32
    @NSManaged public var teacherName: String?
    @NSManaged public var teacherRating: String?
    @NSManaged public var teacherShortName: String?
    @NSManaged public var teacherURL: String?
    @NSManaged public var teachersRelationship: LessonData?
    
    public var wrappedTeacher: Teacher {
        Teacher(teacherID: Int(teacherID), teacherURL: teacherURL ?? "", teacherName: teacherName ?? "", teacherFullName: teacherFullName ?? "", teacherShortName: teacherShortName ?? "", teacherRating: teacherRating ?? "")
    }

}
