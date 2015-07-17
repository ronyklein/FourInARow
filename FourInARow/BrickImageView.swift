//
//  BrickImageView.swift
//  FourInARow
//
//  Created by rony klein on 4/20/15.
//  Copyright (c) 2015 rony klein. All rights reserved.
//

import UIKit

class BrickImageView: UIImageView {

    var mode : BrickMode = .Empty{
        didSet{
            switch mode{
            case .Empty:
                self.image = nil
                case .O:
                self.image = UIImage(named: "o")
            case .X:
                self.image = UIImage(named: "x")
            }
        }
    }
}
