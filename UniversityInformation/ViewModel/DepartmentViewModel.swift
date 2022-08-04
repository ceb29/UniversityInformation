//
//  DepartmentViewModel.swift
//  UniversityInformation
//
//  Created by admin on 7/27/22.
//

import Foundation

class DepartmentViewModel: ObservableObject{
    @Published var departments : [DepartmentViewData] = []
    @Published var error : Bool = false
 
    func getDepartments(){
        DepartmentApiService.sharedService.getData(comp: {[weak self] data, error in
            var departmentsViewData : [DepartmentViewData] = []
            
            if error != nil || data == nil{
                self?.setError(status: true)
                return
            }
            
            for department in data!.departments{
                var subjects : [String]
                
                if department.numberOfpublicationsPerYr == nil || department.numberOfpublicationsPerYr == 0{
                    continue
                }

                if department.subjects == nil || department.subjects?.count == 0{
                    subjects = ["no subjects found"]
                }
                else{
                    subjects = department.subjects!
                }
                
                departmentsViewData.append(DepartmentViewData(deptName: department.deptName, subjects: subjects, numberOfTeachers: department.numberOfTeachers, numberOfpublicationsPerYr: department.numberOfpublicationsPerYr!))
                departmentsViewData = departmentsViewData.sorted {$0.numberOfpublicationsPerYr < $1.numberOfpublicationsPerYr}
            }
            
            DispatchQueue.main.async {
                self?.error = false
                self?.departments = departmentsViewData
            }
        })
    }
    
    func setError(status : Bool){
        DispatchQueue.main.async {
            self.error = true
        }
    }
}

struct DepartmentViewData : Hashable{
    var deptName : String
    var subjects : [String]
    var numberOfTeachers : Int
    var numberOfpublicationsPerYr : Int
}
