//
//  ContentView.swift
//  UniversityInformation
//
//  Created by admin on 7/27/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var departmentViewModel = DepartmentViewModel()
    
    var body: some View {
        NavigationView(){
            DepartmentsListView(departments: departmentViewModel.departments, error: departmentViewModel.error)
                .onAppear {departmentViewModel.getDepartments()}
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
