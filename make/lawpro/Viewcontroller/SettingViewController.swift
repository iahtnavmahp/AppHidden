//
//  SettingViewController.swift
//  lawpro
//
//  Created by devsenior on 06/09/2021.
//

import UIKit
import StoreKit

class SettingViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        listA.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "SettingCollectionViewCell", for: indexPath) as!SettingCollectionViewCell
        cell.lblName?.text = listA[indexPath.row]
        if indexPath.row == 1 {
            cell.imgSetting.image = UIImage.init(named: "like 1")
        }else if indexPath.row == 2 {
            cell.imgSetting.image = UIImage.init(named: "information-button 1-2")
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt
                            indexPath: IndexPath) -> CGSize {
        return CGSize(width: myCollectionView.frame.width - 20,height: 80)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if let urlStr = NSURL(string: "https://apps.apple.com/app/id1596335932") {
                let objectsToShare = [urlStr]
                let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)

                if UIDevice.current.userInterfaceIdiom == .pad {
                    if let popup = activityVC.popoverPresentationController {
                        popup.sourceView = self.view
                        popup.sourceRect = CGRect(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 4, width: 0, height: 0)
                    }
                }
                self.present(activityVC, animated: true, completion: nil)
            }
        }else if indexPath.row == 1 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "FavoriteViewController") as! FavoriteViewController
                	vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }else if indexPath.row == 2{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AboutUSViewController") as! AboutUSViewController
            vc.modalPresentationStyle = .fullScreen
            vc.isScr = 0
            self.present(vc, animated: true, completion: nil)
        }else{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AboutUSViewController") as! AboutUSViewController
            vc.modalPresentationStyle = .fullScreen
            vc.isScr = 1
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    let listA : [String] = ["Share this apps","Favorite","About us","Privacy policy"]
    @IBOutlet weak var myCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib1 = UINib(nibName: "SettingCollectionViewCell", bundle:nil)
        myCollectionView.register(nib1, forCellWithReuseIdentifier: "SettingCollectionViewCell")
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
    }
 
    
    
//    @IBAction func ButtonRateApp(_ sender: Any) {
//        guard let scene = view.window?.windowScene else {
//            print("no scene")
//            return
//        }
//        SKStoreReviewController.requestReview(in: scene)
//    }
    
   
    @IBAction func ButtonBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
