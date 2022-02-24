//
//  FavoriteViewController.swift
//  lawpro
//
//  Created by devsenior on 07/09/2021.
//

import UIKit
import SQLite

class FavoriteViewController: UIViewController {
    @IBOutlet weak var collection: UICollectionView!
    var DataCategory:[ModelCategory] = [ModelCategory]()
    
    var index = 0
    
    @IBOutlet weak var lblText: UILabel!
    override func viewWillAppear(_ animated: Bool) {
        DataCategory.removeAll()
        SQLService.shared.getDataCategory(){data,error in
            if let data = data{
                for item in data{
                    if item.fav == 1{
                        self.DataCategory.append(item)
                        
                        self.lblText.isHidden =  true
                        
                    }
                }
                self.collection.reloadData()
                
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        collection.register(UINib(nibName: InsdeAppsCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: InsdeAppsCollectionViewCell.className)
    }
    
    @IBAction func ButtonBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) ->
    //numberOfItemsInSection muốn bao nhiêu dữ liệu
    Int {return DataCategory.count}
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
    //cellForItemAt indexPath muốn hiển thị gì trong CollectionView
    UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InsdeAppsCollectionViewCell.className, for: indexPath) as!InsdeAppsCollectionViewCell
        cell.backgrooun.backgroundColor = UIColor(red: 206/255, green: 218/255, blue: 255/255, alpha: 1.0) //206, 218, 255
        cell.LabelName.text = self.DataCategory[indexPath.row].title
        
        return cell
    }
    
    
}

extension FavoriteViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        didSelectItemAt indexPath click item
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ClickTitleViewController") as! ClickTitleViewController
        vc.modalPresentationStyle = .fullScreen
        vc.datatitle = self.DataCategory[indexPath.row].title
        vc.datadescrption = self.DataCategory[indexPath.row].descrption
        vc.dataFav = self.DataCategory[indexPath.row].fav
        vc.indexNext = indexPath.row
        vc.isFav = false
        self.present(vc, animated: true, completion: nil)
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt
                            indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad{
            return CGSize(width:collection.frame.width - 20 , height: 100)
        }else{
            return CGSize(width: collection.frame.width - 20, height: 60)
        }
    }
    
    
}
