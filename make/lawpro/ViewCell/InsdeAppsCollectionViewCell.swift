//
//  InsdeAppsCollectionViewCell.swift
//  lawpro
//
//  Created by devsenior on 05/09/2021.
//

import UIKit

class InsdeAppsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var backgrooun: UIView!
    @IBOutlet weak var LabelName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgrooun.layer.cornerRadius = 20
        LabelName.font = UIFont(name: "Roboto", size: 20)
     
    }

}
