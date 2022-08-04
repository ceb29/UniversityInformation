//
//  DepartmentsListView.swift
//  UniversityInformation
//
//  Created by admin on 7/27/22.
//

import SwiftUI

struct DepartmentsListView: View {
    var departments : [DepartmentViewData]
    var error : Bool
    var body: some View {
        if !error{
            VStack{
                Text("Departments")
                List{
                    ForEach(departments, id: \.self){department in
                        NavigationLink(destination: DepartmentView(departName: department.deptName, subjects: department.subjects)){
                            VStack{
                                HStack{
                                    Text("Dept Name: ")
                                    Text(department.deptName)
                                    Spacer()
                                }
                                HStack{
                                    Text("Teachers: ")
                                    Text(String(department.numberOfTeachers))
                                    Text("Publications: ")
                                    Text(String(department.numberOfpublicationsPerYr))
                                    Spacer()
                                }
                            }
                        }
                    }
                    .listRowInsets(EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12))
                }
                Spacer()
            }
        }
        else{
            Text("failed to load data")
        }
    }
}

