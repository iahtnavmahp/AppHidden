//
//  LevelCollectionViewCell.swift
//  lawpro
//
//  Created by devsenior on 08/09/2021.
//

import UIKit

class LevelCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var Backgroun: UIView!
    @IBOutlet weak var LabelLevel: UILabel!
    @IBOutlet weak var Imageblock: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Backgroun.layer.cornerRadius = 20
       
        
    }

}
