//
//  ViewController.swift
//  Homework43ApplePie
//
//  Created by 黃柏嘉 on 2021/12/22.
//

import UIKit

class ViewController: UIViewController {

    //Label
    @IBOutlet weak var correctLabel: UILabel!
    @IBOutlet weak var wrongLabel: UILabel!
    @IBOutlet weak var currentWordLabel: UILabel!
    //ImageView
    @IBOutlet var appleImageViewArray: [UIImageView]!
    //Button
    @IBOutlet var buttonArray: [UIButton]!
    
    //圖片中心點
    var centerArray = [CGPoint]()
    var game:Game!
    var totalWins:Int = 0{
        didSet{
            //新遊戲
            newGame()
        }
    }
    var totalLoses:Int = 0{
        didSet{
            //新遊戲
            newGame()
        }
    }
    var topicArray = ["apple","banana","champion","delicious","elephant","foodpanda","google","halloween","iphone","jordan","kingdom","love","monkey","netflix","orange","princess","queen","rabbit","subway","tiger","uber","video","window","xcode","yellow","zoo"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //儲存當前所有蘋果圖片的中心點
        for i in appleImageViewArray{
            centerArray.append(i.center)
        }
        //設定按鈕在不同情況下的顏色
        for i in buttonArray{
            i.setTitleColor(.white, for: .normal)
            i.setTitleColor(.black, for: .disabled)
        }
        //題目洗牌
        topicArray.shuffle()
        //初始題目
        newGame()
        
    }
    
    //按下字母鍵
    @IBAction func selectLetter(_ sender: UIButton) {
        sender.isEnabled = false
        let letter = Character(sender.title(for: .normal)!.lowercased())
        let result = game.playerGuess(letter: letter)
        if result == false{
            updateAppleImageView()
        }
        updateGameState()
    }
    //重置
    func newGame(){
        if !topicArray.isEmpty{
            let newTopic = topicArray.removeFirst()
            game = Game(word: newTopic, wrongCount: 0, guessLetters: [])
            for i in buttonArray{
                i.isEnabled = true
            }
            updateLabel()
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                for i in 0...5{
                    self.appleImageViewArray[i].center = self.centerArray[i]
                }
            }
        }else{
            restartAlert()
        }
    }
    //更新文字
    func updateLabel(){
        var letters = [String]()
        for letter in game.formattedWord{
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        currentWordLabel.text = wordWithSpacing
        
        correctLabel.text = "Correct\n\(totalWins)"
        wrongLabel.text = "Wrong\n\(totalLoses)"
    }
    
   
    //判斷目前狀態
    func updateGameState(){
        if game.wrongCount == 6{
            totalLoses += 1
        }else if game.word == game.formattedWord{
            totalWins += 1
        }else{
            updateLabel()
        }
    }
    //蘋果掉落動畫
    func updateAppleImageView(){
        UIView.animate(withDuration: 1) {
            self.appleImageViewArray[self.game.wrongCount-1].frame.origin.y += 896
        }
    }
    //重置所有題目
    func restartAlert(){
        let alert = UIAlertController(title: "通知", message: "題目全部完成", preferredStyle: .alert)
        let restartAction = UIAlertAction(title: "Restart", style: .default) { restartAction in
            alert.dismiss(animated: true) {
                self.topicArray = ["apple","banana","champion","delicious","elephant","foodpanda","google","halloween","iphone","jordan","kingdom","love","monkey","netflix","orange","princess","queen","rabbit","subway","tiger","uber","video","window","xcode","yellow","zoo"]
                self.topicArray.shuffle()
            }
        }
        alert.addAction(restartAction)
        present(alert, animated: true, completion: nil)
    }
}

