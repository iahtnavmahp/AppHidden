//
//  TextCLVCell.swift
//  lawpro
//
//  Created by devsenior on 26/09/2021.
//

import UIKit

class TextCLVCell: UICollectionViewCell {
    @IBOutlet weak var ImageBackgroup: UIImageView!
    @IBOutlet weak var Namekey: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ImageBackgroup.layer.cornerRadius = 7
       
    }

}
