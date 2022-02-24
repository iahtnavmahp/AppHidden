//
//  IputTextCollectionViewCell.swift
//  lawpro
//
//  Created by devsenior on 23/09/2021.
//

import UIKit

class IputTextCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var ImageBackgroup: UIImageView!
    @IBOutlet weak var LabelInput: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        ImageBackgroup.layer.cornerRadius = 7
        
    }

}
