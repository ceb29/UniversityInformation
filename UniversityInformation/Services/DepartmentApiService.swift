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
        //function to set error while inside getData
        DispatchQueue.main.async {
            self.error = value
        }
    }
    
    func getData(){
        //get url for api call and check if url is nil, if so need to set error
        let urlRequest = URL(string: "https://mocki.io/v1/aadecc9b-7e10-405b-9978-e47745dac5b1")
        guard urlRequest != nil else{
            setError(value: true)
            print("error with url")
            return
        }
        
        //datatask used for getting api data and decoding into model stuctures
        let datatask = URLSession.shared.dataTask(with: urlRequest!, completionHandler: {data, response, error in
            //check if error from url session
            guard error == nil else{
                self.setError(value: true)
                print("error with datatask")
                return
            }
            
            //make sure data is not empty before decoding
            guard data != nil else{
                self.setError(value: true)
                print("error, data is nil")
                return
            }
            
            // use jsondecoder to decode into model structure
            // then using the model setup a viewmodel to pass to published object
            // if there is an error set published error to true
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
