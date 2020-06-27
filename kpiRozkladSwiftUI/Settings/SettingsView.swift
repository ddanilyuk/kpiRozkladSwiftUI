//
//  SettingsView.swift
//  kpiRozkladSwiftUI
//
//  Created by Денис Данилюк on 27.06.2020.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext

    var body: some View {
        
        NavigationView {
            ZStack {
                Color.init(UIColor.secondarySystemBackground).edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .center) {
                    Spacer()
                    Text("Settings")
                    Spacer()
                    Button("Reload data") {
                        deleteAllFromCoreData(managedContext: managedObjectContext)
                        
                        getGroups() { lessons in
                            updateCoreData(lessons: lessons, managedContext: managedObjectContext)
                        }
                    }
                    Spacer()

                }
                .frame(width: 100, height: 100, alignment: .center)
                
            }
            
            .navigationBarTitle(Text("Налаштування"))
        }
        
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
