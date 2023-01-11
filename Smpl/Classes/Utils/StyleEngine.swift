//
//  StyleEngine.swift
//  Smpl
//
//  Created by CanGokceaslan on 6.12.2022.
//

import Foundation;
import SwiftUI;


struct StylesObject {
    var backgroundColor: String?;
    var color: String?;
}

func renderStyles(view: any View,style: StylesObject)-> any View{
    return view;
}
