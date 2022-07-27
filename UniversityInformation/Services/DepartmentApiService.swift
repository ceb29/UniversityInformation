//
//  DepartmentApiService.swift
//  UniversityInformation
//
//  Created by admin on 7/27/22.
//

import Foundation

class DepartmentApiService: ObservableObject{
    @Published var departments : [DepartmentViewModel] = []
    @Published var error : Bool = false
    
    func setError(value: Bool){
        DispatchQueue.main.async {
            self.error = value
        }
    }
    
    func getData(){
        let urlRequest = URL(string: "https://mocki.io/v1/aadecc9b-7e10-405b-9978-e47745dac5b1")
        guard urlRequest != nil else{
            setError(value: true)
            print("error with url")
            return
        }
        
        let datatask = URLSession.shared.dataTask(with: urlRequest!, completionHandler: {data, response, error in
            guard error == nil else{
                self.setError(value: true)
                print("error with datatask")
                return
            }
            
            guard data != nil else{
                self.setError(value: true)
                print("error, data is nil")
                return
            }
            
            let decoder = JSONDecoder()
            
            do{
                let departmentsModel = try decoder.decode(DepartmentsModel.self, from: data!)
                var departmentViewModel : [DepartmentViewModel] = []
                for department in departmentsModel.departments {
                    guard department.numberOfpublicationsPerYr != nil else{
                        continue
                    }
                    
                    if department.numberOfpublicationsPerYr == 0{
                        continue
                    }
                    departmentViewModel.append(DepartmentViewModel(deptName: department.deptName, subjects: department.subjects, numberOfTeachers: department.numberOfTeachers, numberOfpublicationsPerYr: department.numberOfpublicationsPerYr!))
                    departmentViewModel = departmentViewModel.sorted {$0.numberOfpublicationsPerYr > $1.numberOfpublicationsPerYr}
                }
                
                DispatchQueue.main.async {
                    self.departments = departmentViewModel
                }
            }
            catch{
                self.setError(value: true)
                print("error while decoding")
                print(error)
                return
            }
            
        })
        datatask.resume()
    }
    
}
