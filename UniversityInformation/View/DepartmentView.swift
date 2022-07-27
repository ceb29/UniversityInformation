//
//  DepartmentView.swift
//  UniversityInformation
//
//  Created by admin on 7/27/22.
//

import SwiftUI

struct DepartmentView: View {
    var departName : String
    var subjects : [String]
    
    var body: some View {
        Text(departName)
        List{
            ForEach(subjects, id: \.self){subject in
                Text(subject)
            }
        }
        Spacer()
        //.navigationBarTitle(departName)
    }
}

