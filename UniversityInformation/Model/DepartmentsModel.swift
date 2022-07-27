//
//  DepartmentsModel.swift
//  UniversityInformation
//
//  Created by admin on 7/27/22.
//

import Foundation

struct DepartmentsModel: Codable{
    var departments : [Department]
    
    enum CodingKeys: String, CodingKey{
        case departments = "Departments"
    }
}

struct Department : Codable{
    var deptName : String
    var subjects : [String]
    var numberOfTeachers : Int
    var numberOfpublicationsPerYr : Int? //can be nil
}


