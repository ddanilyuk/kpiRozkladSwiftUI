//
//  LessonsView.swift
//  kpiRozkladSwiftUI
//
//  Created by Денис Данилюк on 27.06.2020.
//

import SwiftUI

struct LessonsView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State var week: Int = 1
    
    var body: some View {
        NavigationView {

            LessonsList(week: week)
                
            .navigationBarTitle(Text("ІВ-82"))
            
            .navigationBarItems(trailing:
                Picker("", selection: $week) {
                    Text("1").tag(1)
                    Text("2").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 120, height: .none, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            )
            
            
            
        }
    }
}

struct LessonsView_Previews: PreviewProvider {
    static var previews: some View {
        LessonsView()
    }
}
