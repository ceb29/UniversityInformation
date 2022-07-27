//
//  ContentView.swift
//  UniversityInformation
//
//  Created by admin on 7/27/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var departmentsService = DepartmentApiService()
    
    var body: some View {
        NavigationView(){
            DepartmentsListView(departments: departmentsService.departments, error: departmentsService.error)
                .onAppear {departmentsService.getData()}
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
