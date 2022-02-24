//
//  Category.swift
//  lawpro
//
//  Created by devsenior on 06/09/2021.
//

import UIKit
import SQLite.Swift

class ModelCategory: NSObject {
    var id : String = ""
    var title : String = ""
    var descrption : String = ""
    var fav : Int = 0

    init(id:String ,title:String ,descrption:String ,fav:Int ) {
        self.id = id
        self.title = title
        self.descrption = descrption
        self.fav = fav
    }
    
}

