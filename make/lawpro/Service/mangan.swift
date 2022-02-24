//
//  mangan.swift
//  lawpro
//
//  Created by devsenior on 26/09/2021.
//

import UIKit
import Foundation
import SQLite

class mangan {
    var personListData = [ModelQuiz2]()
    var movieName = [String]()
    var Quiz = [Int] ()
    var personName = [String]()
    var wordListArray = String()
    var x : Int = 0
    var quizCount : [Int]  = []
    var clubNumberQuiz: [Int] = []
    var indexPersonArray = [Int]()
    var indexxClubArray = [Int]()
    var dictionary = [String : Int]()
    var stringGuessed = [String]()
    var clubName = [String]()
    var stringHold = [String]()
    var person_wiki = [String]()
    var p_is_guessed_array = [Int]()
    var p_is_guessed_array_by_quiz = [Int]()
    
    
    // MARK:- Create a random String
    public func randomString(length: Int) -> String {
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    public func randomAnswer(with personName: String) {
        let string = personName + randomString(length: 1)
        wordListArray = string
    }
    
    public func transformUppercase(_ stringArray: [String]) -> [String] {
        var uppercasedString = [String]()
        for items in stringArray {
            uppercasedString.append(items.uppercased())
        }
        return uppercasedString
    }
    
    func indexPersonQuiz() {
        while x < 600 {
            x += 15
            quizCount.append(x)
        }
    }
    
    func indexClubquiz() {
        while x < 1140 {
            x += 30
            clubNumberQuiz.append(x)
        }
    }
    
    //MARK: - find blankspace
    
    func find_whitespace(_ string: String) -> Int {
        var index = 0
        if let i = string.firstIndex(of: " ") {
            index = (i.utf16Offset(in: string))
        } else {
           // no white space
        }
        return index
    }
    
//    //MARK:- get data from sqlLite
//    public func setUpData() {
//        Sqldata.shared.getDataQuiz { (respone, error) in
//            if let listData = respone {
//                self.personListData = listData
//            }
//        }
//    }
//
 
    
    //MARK:- Fetch Quizs follow by level
    public func handleClubQuizWithLevel(_ level : Int) {
        switch level {
        case 0:
            Quiz.removeAll()
            clubName.removeAll()
            person_wiki.removeAll()
            p_is_guessed_array_by_quiz.removeAll()
            if personListData.count > 0{
                for items in personListData[0...(clubNumberQuiz[0] - 1)] {
                    Quiz.append(items.id)
    //                clubName.append(items.Image)
                    person_wiki.append(items.ans)
                   
                }
            }
            
        case 1:
            Quiz.removeAll()
            clubName.removeAll()
            person_wiki.removeAll()
            p_is_guessed_array_by_quiz.removeAll()
            for items in personListData[1...(clubNumberQuiz[2] - 1)] {
                Quiz.append(items.id)
//                clubName.append(items.Image)
                person_wiki.append(items.ans)
               
            }
        case 2:
            Quiz.removeAll()
            clubName.removeAll()
            person_wiki.removeAll()
            p_is_guessed_array_by_quiz.removeAll()
            for items in personListData[2...(clubNumberQuiz[3] - 1)] {
                Quiz.append(items.id)
//                clubName.append(items.Image)
                person_wiki.append(items.ans)
               
            }
        case 3:
            Quiz.removeAll()
            clubName.removeAll()
            person_wiki.removeAll()
            p_is_guessed_array_by_quiz.removeAll()
            for items in personListData[3...(clubNumberQuiz[4] - 1)] {
                Quiz.append(items.id)
//                clubName.append(items.Image)
                person_wiki.append(items.ans)
               
            }
        default:
            print("default!")
            
        }
    }
}
