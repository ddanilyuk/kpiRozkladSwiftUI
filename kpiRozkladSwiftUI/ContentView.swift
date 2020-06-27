//
//  ContentView.swift
//  kpiRozkladSwiftUI
//
//  Created by Денис Данилюк on 26.06.2020.
//

import SwiftUI






struct ContentView: View {
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .systemBlue
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.systemBlue], for: .normal)
//        if #available(iOS, *13.0)
        UITableView.appearance().backgroundColor = AppColors.tintUIColor
    }
    
    var body: some View {

        TabView {
            LessonsView()
            .tabItem {
                Image(systemName: "list.bullet")
                Text("Розклад")
            }
            
            SettingsView()
            .tabItem {
                Image(systemName: "gear")
                Text("Налаштування")
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        ForEach(["iPhone X", "iPhone 8"], id: \.self) { deviceName in
        ContentView()
            .environment(\.colorScheme, .light)
//        }
//            .preferredColorScheme(.)
    }
}
