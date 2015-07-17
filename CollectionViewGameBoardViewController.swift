//
//  CollectionViewGameBoardViewController.swift
//  FourInARow
//
//  Created by rony klein on 4/28/15.
//  Copyright (c) 2015 rony klein. All rights reserved.
//

import UIKit
import Social
class CollectionViewGameBoardViewController: UIViewController ,UICollectionViewDataSource ,UICollectionViewDelegate{
    
    var name1 : String!
    var name2 : String!
    var timer1 = 0
    var timer2 = 0
    
    @IBOutlet weak var gameBoard: UICollectionView!
    
    @IBOutlet weak var statuslabel: UILabel!
    
    @IBAction func shareon(sender: AnyObject) {
        if game.gameEnded {
            var wintext : String
            var winner : String
            var loser : String
            var wintime : Int
            var ShareToFacebook : SLComposeViewController =
            SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            if game.currentStatus == GameStatus.Draw {
                wintext = ("\(name1) and \(name2) played the game four in a row and reached a draw")
            }
            else {
                if game.currentStatus == GameStatus.xWon {
                    winner = name1
                    loser = name2
                    wintime = timer1
                }
                else {
                    winner = name2
                    loser = name1
                    wintime = timer2
                }
                
                wintext = ("\(winner) won \(loser) in \(wintime) seconds in the game of four in a row" )
            }
            ShareToFacebook.setInitialText(wintext)
            self.presentViewController(ShareToFacebook, animated: true, completion: nil)
        }
        
    }
    @IBOutlet weak var gameTime2: UILabel!
    @IBOutlet weak var gameTime1: UILabel!
    @IBOutlet weak var timerLabel2: UILabel!
    @IBOutlet weak var timerLabel1: UILabel!
    var game = GameManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        timerLabel1.text = "time for \(name1):"
        timerLabel2.text = "time for \(name2):"
        changeLabel()
        startTimer()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 64
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! MyGameCell
        
        
        return cell
        
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if !game.gameEnded {
            let cell = gameBoard.cellForItemAtIndexPath(indexPath) as? MyGameCell
            if (game.isActiveInItem(indexPath.item)) {
                if game.currentStatus == GameStatus.xPlaying {
                    cell?.displayx()
                    game.setMode(BrickMode.X, inItem: indexPath.item)
                    
                }
                else {
                    cell?.displayo()
                    game.setMode(BrickMode.O, inItem: indexPath.item)
                }
                changeLabel()
            }
        }
    }
    func changeLabel() {
        if game.currentStatus == GameStatus.xPlaying {
            statuslabel.text = "\(name1) as x is playing"
        }
        else if game.currentStatus == GameStatus.oPlaying {
            statuslabel.text = "\(name2) as o is playing"
        }
        else if game.currentStatus == GameStatus.Draw {
            statuslabel.text = "Draw"
        }
        else if game.currentStatus == GameStatus.oWon {
            statuslabel.text = "\(name2) won the game"
        }
        else {
            statuslabel.text = "\(name1) won the game"
        }
    }
    func startTimer() {
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "timeChange", userInfo: nil, repeats: true)
        
    }
    func timeChange(){
        if !game.gameEnded {
            if game.currentStatus == GameStatus.xPlaying {
                timer1 += 1
                gameTime1.text = "\(timer1)"
            }
            else if game.currentStatus == GameStatus.oPlaying {
                timer2 += 1
                gameTime2.text = "\(timer2)"
            }
        }
        
    }
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
