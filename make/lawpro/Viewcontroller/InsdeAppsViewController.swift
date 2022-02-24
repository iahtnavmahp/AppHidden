//
//  InsdeAppsViewController.swift
//  lawpro
//
//  Created by devsenior on 05/09/2021.
//

import UIKit

  var thissong = 0
class InsdeAppsViewController: UIViewController {

    @IBOutlet weak var collection: UICollectionView!
    
    
    var DataQuiz2: [ModelQuiz2] = [ModelQuiz2]()
    var DataCategory: [ModelCategory] = [ModelCategory]()
   
    
    var indexItem:Int?
    override func viewWillAppear(_ animated: Bool) {
        SQLService.shared.getDataCategory(){data,error in
            if let data = data{
                self.DataCategory = data
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
extension InsdeAppsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int { //numberOfSections muốn bao nhiêu nhóm trong CollectionView
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
    //numberOfItemsInSection muốn bao nhiêu dữ liệu
        return DataCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
    //cellForItemAt indexPath muốn hiển thị gì trong CollectionView
        UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InsdeAppsCollectionViewCell", for: indexPath) as!InsdeAppsCollectionViewCell

        cell.backgrooun.backgroundColor = UIColor(red: 206/255, green: 218/255, blue: 255/255, alpha: 1.0) //206, 218, 255
        cell.LabelName.text = self.DataCategory[indexPath.row].title

        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind : String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        return UICollectionReusableView()
    }
   
}

extension InsdeAppsViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        //khoảng cách giữa các hàng hoặc cột liên tiếp của một phần.
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //didSelectItemAt indexPath click item
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ClickTitleViewController") as! ClickTitleViewController
        vc.modalPresentationStyle = .fullScreen
        vc.datatitle = self.DataCategory[indexPath.row].title
        vc.datadescrption = self.DataCategory[indexPath.row].descrption
        vc.dataFav = self.DataCategory[indexPath.row].fav
        vc.indexNext = indexPath.row
        thissong = indexPath.row
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
