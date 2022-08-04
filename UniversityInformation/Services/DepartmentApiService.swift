//
//  DepartmentApiService.swift
//  UniversityInformation
//
//  Created by admin on 7/27/22.
//

import Foundation

class DepartmentApiService{
    static let sharedService = DepartmentApiService()
    
    private init(){
        
    }
    
    func getData(comp: @escaping (DepartmentsModel?, APIerror?) -> ()){
        let urlRequest = URL(string: "https://mocki.io/v1/aadecc9b-7e10-405b-9978-e47745dac5b1")
        
        guard urlRequest != nil else{
            comp(nil, APIerror.urlNil)
            return
        }
        
        let datatask = URLSession.shared.dataTask(with: urlRequest!, completionHandler: {data, response, error in
            guard error == nil else{
                comp(nil, APIerror.datataskError)
                return
            }
            
            guard data != nil else{
                comp(nil, APIerror.dataNil)
                return
            }
            
            let decoder = JSONDecoder()
            
            do{
                let departmentModel = try decoder.decode(DepartmentsModel.self, from: data!)
                comp(departmentModel, nil)
            }
            catch{
                comp(nil, APIerror.decoderError)
            }
        })
        datatask.resume()
    }
    
}

enum APIerror : Error{
    case urlNil
    case dataNil
    case datataskError
    case decoderError
}
