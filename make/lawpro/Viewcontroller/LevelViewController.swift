//
//  LevelViewController.swift
//  lawpro
//
//  Created by devsenior on 07/09/2021.
//

import UIKit
import SwiftKeychainWrapper



class LevelViewController: UIViewController {
    
    
    @IBOutlet weak var collectionview: UICollectionView!
    
    var DataQuiz2: [ModelQuiz2] = [ModelQuiz2]()
    
    override func viewWillAppear(_ animated: Bool) {
        SQLService.shared.getQuiz2(){data,error in
            if let data = data{
                self.DataQuiz2 = data
            }
            self.collectionview.reloadData()
        }
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        collectionview.register(UINib(nibName: LevelCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: LevelCollectionViewCell.className)
        
    }
    @IBAction func segueToLevelView(_ sender: UIStoryboardSegue)
    {
        
        performSegue(withIdentifier: "unToLevelView", sender: self)
        DataQuiz2.removeAll()
        SQLService.shared.getQuiz2(){data,error in
            if let data = data{
                self.DataQuiz2 = data
            }
            self.collectionview.reloadData()
        }
        
        
    }
    
    @IBAction func ButtonBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension LevelViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataQuiz2.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
    //cellForItemAt indexPath muốn hiển thị gì trong CollectionView
    UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LevelCollectionViewCell.className, for: indexPath) as!LevelCollectionViewCell
        if DataQuiz2[indexPath.row].key == 0{
            cell.Imageblock.isHidden = false
        }else{
            cell.Imageblock.isHidden = true
        }
        cell.Backgroun.backgroundColor = UIColor(red: 206/255, green: 218/255, blue: 255/255, alpha: 1.0) //206, 218, 255
        cell.LabelLevel.text = "Level \(self.DataQuiz2[indexPath.row].id)"
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind : String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        return UICollectionReusableView()
    }
 
    
}

extension LevelViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //didSelectItemAt indexPath click item
        if DataQuiz2[indexPath.row].key == 1 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PlayerViewController") as! PlayerViewController
            vc.modalPresentationStyle = .fullScreen
            vc.dataLevel = indexPath.row
            vc.dataQuestion = self.DataQuiz2[indexPath.row].question
            vc.dataAns = self.DataQuiz2[indexPath.row].ans
            vc.isFirstPass = self.DataQuiz2[indexPath.row].firstpass
            self.present(vc, animated: true, completion: nil)
        }else{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PopUpHintViewController") as! PopUpHintViewController
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            vc.lblStr  = "You Must Complete Before Question"
            
            self.present(vc, animated: false, completion: nil)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt
                            indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad{
            return CGSize(width: UIScreen.main.bounds.width/3 - 50, height: 95)
            
        }
        return CGSize(width: UIScreen.main.bounds.width/3 - 50, height: 95)
    }
    
}
