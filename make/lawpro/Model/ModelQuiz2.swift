//
//  ModelQuiz2.swift
//  lawpro
//
//  Created by devsenior on 06/09/2021.
//

import UIKit


class ModelQuiz2: NSObject {
    var id : Int = 0
    var question : String = ""
    var ans : String = ""
    var key :Int = 0
    var firstpass : Int = 0
    
    init(id:Int,question:String,ans:String,key:Int,firstpass:Int) {
        self.id = id
        self.question = question
        self.ans = ans
        self.key = key
        self.firstpass = firstpass
  
    }
}
