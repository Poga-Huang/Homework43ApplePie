//
//  Game.swift
//  Homework43ApplePie
//
//  Created by 黃柏嘉 on 2021/12/22.
//

import Foundation

struct Game{
    var word:String
    var wrongCount:Int
    var guessLetters:[Character]
    
    //computed Property
    var formattedWord:String{
        var guessLetter = ""
        for letter in word{
            if guessLetters.contains(letter){
                guessLetter += "\(letter)"
            }else{
                guessLetter += "_"
            }
        }
        return guessLetter
    }
    //檢查輸入字母是否在答案內
    mutating func playerGuess(letter:Character)->Bool{
        guessLetters.append(letter)
        if !word.contains(letter){
            wrongCount += 1
            return false
        }else{
            return true
        }
    }
}
