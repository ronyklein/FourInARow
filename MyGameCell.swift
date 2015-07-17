//
//  MyGameCell.swift
//  FourInARow
//
//  Created by rony klein on 4/28/15.
//  Copyright (c) 2015 rony klein. All rights reserved.
//

import UIKit

class MyGameCell: UICollectionViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    func displayo() {
        cellImage.image = UIImage(named: "o")
    }
    func displayx(){
        cellImage.image = UIImage(named: "x")
    }
}
