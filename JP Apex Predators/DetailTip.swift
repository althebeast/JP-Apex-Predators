//
//  DetailTip.swift
//  JP Apex Predators
//
//  Created by Alperen Sarışan on 27.01.2024.
//

import Foundation
import TipKit

struct DetailTip: Tip {
    var title: Text {
        Text("See this image on full size!")
    }
    
    var message: Text?{
        Text("If you want to see this image full size, you can click on the image.")
    }
}
