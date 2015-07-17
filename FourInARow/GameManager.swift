//
//  GameManager.swift
//  FourInARow
//
//  Created by rony klein on 4/20/15.
//  Copyright (c) 2015 rony klein. All rights reserved.
//
//  Another comment

import UIKit
enum BrickMode{
    case Empty
    case X
    case O
}



enum GameStatus{
    case xPlaying
    case oPlaying
    case xWon
    case oWon
    case Draw
}
let kMatrixSize = 8
let kMaxRow = 7
let kMaxCol = 7
let kDistance = 3
let kStartBricks = 55
let kWinNumVal = 4
let kBrickNum = kMatrixSize * kMatrixSize
class GameManager: NSObject {
    var currentStatus : GameStatus
    var matrix : [[BrickMode]]
    var gameEnded = false

    override init() {
        
        self.currentStatus = .xPlaying
        
        let array = [BrickMode](count: kMatrixSize, repeatedValue: BrickMode.Empty)
        self.matrix = [[BrickMode]](count: kMatrixSize, repeatedValue: array)
        
        super.init()
        
        
        self.currentStatus = determindWhoStarts()
    }
    
    
    func determindWhoStarts() -> GameStatus{
        /*        let now = NSDate()
        let t = (now.timeIntervalSince1970 * 1_000_000) % 10*/
        
        let r = random()
        if r % 2 == 0{
            return .xPlaying
        } else {
            return .oPlaying
        }
    }
    /*
    1. Set all matrix to .Empty
    2. update the status to .xPlaying
    */
    
    func clear(){
        for (var i = 0; i < kMatrixSize; i++){
            for (var j = 0; j < kMatrixSize; j++){
                matrix[i][j] = BrickMode.Empty
            }
        }
        
        self.currentStatus = determindWhoStarts()
    }
    
    func setMode(mode : BrickMode, inItem item : Int) -> GameStatus{
        //update matrix
        let row = item / kMatrixSize
        let col = item % kMatrixSize
        matrix[row][col] = mode
        
        //calculate status
        
        
        //return updated status
        return calculateNewModeInItem(item)
    }
    func isActiveInItem(item : Int) -> Bool{
       let bItem = item + kMatrixSize
        let bRow = bItem / kMatrixSize
        let bCol = bItem % kMatrixSize
        let row = item / kMatrixSize
        let col = item % kMatrixSize
        if (item > kStartBricks) && (matrix[row][col] == BrickMode.Empty) {
            return true
        }
        else if (matrix[row][col] == BrickMode.Empty){
            return ((matrix[bRow][bCol] != BrickMode.Empty) && (matrix[row][col] == BrickMode.Empty))
        }
        else {
         return false
        }
    }
    private func calculateNewModeInItem(item : Int) -> GameStatus{
        let col = item % kMatrixSize
        let row = item / kMatrixSize
        var current = matrix[row][col]
        var inLine = 0
        
        
        for (var i = max(col - kDistance, 0); i <= min(col + kDistance,kMaxCol); i++){
            if matrix[row][i] == current {
                inLine += 1
                if inLine == kWinNumVal {
                    if currentStatus == GameStatus.xPlaying {
                        self.currentStatus = GameStatus.xWon
                        gameEnded = true
                        return self.currentStatus
                    }
                    else {
                        self.currentStatus = GameStatus.oWon
                        gameEnded = true
                        return self.currentStatus
                    }
                }
                
            }
                else {
                    inLine = 0 //making inLine 0 to garenty that the count will start from 0
            }
        }
        inLine = 0  //again making inLine 0 to make the next check start from 0
        
        for (var i = max(row - kDistance, 0); i <= min(row + kDistance,kMaxRow); i++){
            if matrix[i][col] == current {
                inLine += 1
                if inLine == kWinNumVal {
                    if currentStatus == GameStatus.xPlaying {
                        self.currentStatus = GameStatus.xWon
                        gameEnded = true
                        return self.currentStatus
                    }
                    else {
                        self.currentStatus = GameStatus.oWon
                        gameEnded = true
                        return self.currentStatus
                    }
                }
            }
            else {
                inLine = 0
            }
        }
        inLine = 0
        for (var i = max(max( -kDistance, -row),max(-kDistance, -col)); i <= min(min(kDistance,kMaxRow - row),min(kDistance,kMaxCol - col)); i++) {
            if matrix[row + i][col + i] == current {
                inLine += 1
                if inLine == kWinNumVal {
                    if currentStatus == GameStatus.xPlaying {
                        self.currentStatus = GameStatus.xWon
                        gameEnded = true
                        return self.currentStatus
                    }
                    else {
                        self.currentStatus = GameStatus.oWon
                        gameEnded = true
                        return self.currentStatus
                    }
                }
            }
            else {
                inLine = 0
            }
        }
        inLine = 0
        
        for (var i = max(max(-kDistance, -row),max(-kDistance, col - kMaxCol)); i <= min(min(kDistance,kMaxRow - row),min(kDistance,col)); i++) {
            if matrix[row + i][col - i] == current {
                inLine += 1
                if inLine == kWinNumVal {
                    if currentStatus == GameStatus.xPlaying {
                        self.currentStatus = GameStatus.xWon
                        gameEnded = true
                        return self.currentStatus
                    }
                    else {
                        self.currentStatus = GameStatus.oWon
                        gameEnded = true
                        return self.currentStatus
                    }
                }
            }
            else {
                inLine = 0
            }
        }
        var counter = 0
        for(var i = 0;i < kBrickNum;i++){
            if matrix[i / kMatrixSize][i % kMatrixSize] != BrickMode.Empty {
                counter++
            }
        }
        if counter == kBrickNum {
            self.currentStatus = GameStatus.Draw;
            gameEnded = true;
            return self.currentStatus;
        }
        
        if currentStatus == GameStatus.xPlaying
        {
            self.currentStatus = GameStatus.oPlaying
            return currentStatus
        }
        else
        {
            self.currentStatus = GameStatus.xPlaying
            return currentStatus
        }
    }
    func isgameEnded() -> Bool{
        return gameEnded
    }
}
