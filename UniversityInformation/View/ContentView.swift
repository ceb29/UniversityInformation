//
//  ContentView.swift
//  UniversityInformation
//
//  Created by admin on 7/27/22.
//

import SwiftUI

struct ContentView: View {
    var departments = ["test1", "test2"]
    @StateObject private var departmentsService = DepartmentApiService()
    var body: some View {
        NavigationView(){
            List{
                ForEach(departmentsService.departments, id: \.self){department in
                    NavigationLink(destination: DepartmentView()){
                        VStack{
                            HStack{
                                Text("Dept Name: ")
                                Text(department.deptName)
                            }
                            HStack{
                                Text("Teachers: ")
                                Text("Publications")
                            }
                        }
                        
                    }
                }
            }
            .onAppear {departmentsService.getData()}
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
