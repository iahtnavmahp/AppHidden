//
//  ClickTitleViewController.swift
//  lawpro
//
//  Created by devsenior on 06/09/2021.
//
import AVFoundation
import UIKit
import SwiftKeychainWrapper

class ClickTitleViewController: UIViewController,UICollectionViewDelegate {
    
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var BackgrounWhite: UIView!
    @IBOutlet weak var FrameTitle: UIView!
    
    
    @IBOutlet weak var LabelTitle: UILabel!

    
    @IBOutlet weak var textDescrptions: UITextView!
    @IBOutlet weak var ButtonFavorite: UIButton!
    let InsdeView = InsdeAppsViewController()
    var datatitle: String = ""
    var datadescrption: String = ""
    var indexNext:Int = 0
    var dataFav : Int = 0
    var isFav : Bool = true
    var DataCategory: [ModelCategory] = [ModelCategory]()
    override func viewWillAppear(_ animated: Bool) {
        SQLService.shared.getDataCategory{data,error in
            if let data = data{
                if self.isFav {
                    self.DataCategory = data
                }else{
                    for i in data {
                        if i.fav == 1 {
                            self.DataCategory.append(i)
                        }
                    }
                }
            }
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        LabelTitle.text = datatitle
        textDescrptions.text = datadescrption
        
        BackgrounWhite.layer.cornerRadius = 20
        FrameTitle.layer.cornerRadius = 15
        
       
        
        if dataFav == 1 {
            ButtonFavorite.setBackgroundImage(UIImage.init(named: "favorite"), for: .normal)
        }
    }
    
    @IBAction func ButtonPrevious(_ sender: Any) {
        if indexNext  > 0{
            indexNext -= 1
            LabelTitle.text = self.DataCategory[indexNext].title
            textDescrptions.text = self.DataCategory[indexNext].descrption
            setImageFav()
        }
    }
    
    @IBAction func ButtonFavorite(_ sender: Any) {
        if DataCategory[indexNext].fav == 0{
            
            DataCategory[indexNext].fav = 1
            ButtonFavorite.setBackgroundImage(UIImage.init(named: "favorite"), for: .normal)
            SQLService.shared.addFavoriteDatabase(id: DataCategory[indexNext].id, favorite: 1)
        }else{
            DataCategory[indexNext].fav = 0
            ButtonFavorite.setBackgroundImage(UIImage.init(named: "unfavorite"), for: .normal)
            SQLService.shared.addFavoriteDatabase(id: DataCategory[indexNext].id, favorite: 0)
        }
   

    }
    
    
    @IBAction func ButtonNext(_ sender: UIButton) {
        if indexNext < self.DataCategory.count - 1 {
            indexNext += 1
            LabelTitle.text = self.DataCategory[indexNext].title
            textDescrptions.text = self.DataCategory[indexNext].descrption
            setImageFav()
        }
        
    }
    
    @IBAction func Back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    func setImageFav(){
        if DataCategory[indexNext].fav == 1 {
            ButtonFavorite.setBackgroundImage(UIImage.init(named: "favorite"), for: .normal)
        }else{
            ButtonFavorite.setBackgroundImage(UIImage.init(named: "unfavorite"), for: .normal)
        }
    }
}
