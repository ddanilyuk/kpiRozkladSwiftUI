//
//  AppColors.swift
//  kpiRozkladSwiftUI
//
//  Created by Денис Данилюк on 27.06.2020.
//

import UIKit
import SwiftUI


struct AppColors {
    
    static let tint: Color = { () -> Color in
        if #available(iOS 13, *) {
            let uiColor = UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    /// Return the color for Dark Mode
                    return UIColor.black
                    
                } else {
                    /// Return the color for Light Mode
                    return UIColor.tertiarySystemGroupedBackground
                }
            }
            return Color(uiColor)
        } else {
            /// Return a fallback color for iOS 12 and lower.
            return Color(UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1))
        }
    }()
    
    
    static let tintUIColor: UIColor = { () -> UIColor in
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    /// Return the color for Dark Mode
                    return UIColor.black
                    
                } else {
                    /// Return the color for Light Mode
                    return UIColor.tertiarySystemGroupedBackground
                }
            }
        } else {
            /// Return a fallback color for iOS 12 and lower.
            return UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
        }
    }()



}
