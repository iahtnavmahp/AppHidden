//
//  BroadKeyCollectionViewCell.swift
//  lawpro
//
//  Created by devsenior on 26/09/2021.
//

import UIKit
import AVFoundation

class BroadKeyCollectionViewCell: UICollectionViewCell{
   
    var DataQuiz2: [ModelQuiz2] = [ModelQuiz2]()
    var intTap = 0
    var vitri = 0
    var testString = [String]()
    var countans = ""
    
    @IBOutlet weak var CLVText: UICollectionView!
    @IBOutlet weak var CLVInput: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        CLVInput.register(UINib(nibName: IputTextCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: IputTextCollectionViewCell.className)
        
        CLVText.register(UINib(nibName: TextCLVCell.className, bundle: nil), forCellWithReuseIdentifier: TextCLVCell.className)
        
        CLVText.delegate = self
        CLVText.dataSource = self
        CLVInput.delegate = self
        CLVInput.dataSource = self
        CLVText.reloadData()
        CLVInput.reloadData()
    }
    
}
extension BroadKeyCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {   
        if collectionView == CLVText {
            return countans.count
        }
        else{
            return 14
            }
        
    }
    
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.CLVText {
            let cell = CLVText.dequeueReusableCell(withReuseIdentifier:"TextCLVCell", for: indexPath) as! TextCLVCell
            
            return cell
        } else {
            let cell = CLVInput.dequeueReusableCell(withReuseIdentifier: "IputTextCollectionViewCell", for: indexPath) as! IputTextCollectionViewCell

            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
    }
    
}
extension BroadKeyCollectionViewCell: UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.CLVText {
            if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad){
                return CGSize(width: 40, height: 40)
            }
            return CGSize(width: 40, height: 40)
        }else if collectionView == self.CLVInput {
            if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad){
                return CGSize(width: 40, height: 40)
            }
            return CGSize(width: 40, height: 40)
        }
        return CGSize(width:50, height: 50)
        
    }
    // khoang cach cua cac dòng
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    // khoang cach cua cac cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}
