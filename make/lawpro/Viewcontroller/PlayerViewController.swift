//
//  PlayerViewController.swift
//  lawpro
//
//  Created by devsenior on 07/09/2021.
//

import UIKit
import SwiftKeychainWrapper
import RealmSwift

class PlayerViewController: UIViewController {
 
    
    
    let realm = try! Realm()
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    @IBOutlet weak var viewPoint: UIView!
    @IBOutlet weak var LabelPoint: UILabel!
    @IBOutlet weak var FrameLabel: UIView!
   
    @IBOutlet weak var lblLevel: UILabel!
    
    @IBOutlet weak var LabelQuestion: UILabel!
    
    @IBOutlet weak var BtnLabelUser: UIButton!
    var isFirstPass :Int = 0
    var pointHints :Int = 0
    var DataQuiz2: [ModelQuiz2] = [ModelQuiz2]()
    var isAppend:Bool = true
    var dataLevel:Int = 0
    var dataQuestion:String = ""
    var dataAns:String = ""
    var isStr :Bool = true
    var strAns :String = ""
    var idx:Int = 0
    var wordListArray = String()
    var arrAns:[Character] = []
    var idxArrAns = 0
    var listChar :[Character] = []
    var isHintCell :[Int] = []
    var charAns : [Character] = []
    var arrAnsLet : [Character] = []
    var countAdd : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FrameLabel.layer.cornerRadius = 20
        arrAns = Array(dataAns)
        countAdd = 20 - dataAns.count
        for _ in 1...countAdd {
            
            let a = randomChar()
            arrAns.append(Character(a))
        }
        
        arrAnsLet = Array(dataAns)
        for _ in 1...20 {
            let a = randomString(length: 1)
            listChar.append(Character(a))
            
        }
        print("char \(listChar.count)")
        print("char \(listChar)")
        viewPoint.layer.cornerRadius = 15
        // MARK:- REALM
        let result = realm.objects(ModelHints.self).filter("id == 1").first
        pointHints = result?.hint ?? -999
        LabelPoint?.text = String(result?.hint ?? -999)
        LabelQuestion.text = dataQuestion
        
        //========================================
        lblLevel.clipsToBounds = true
        lblLevel.layer.cornerRadius = 20
        lblLevel.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMinXMinYCorner]
        lblLevel?.text = "Level \(dataLevel + 1)"
        let nib1 = UINib(nibName: "IputTextCollectionViewCell", bundle:nil)
        myCollectionView.register(nib1, forCellWithReuseIdentifier: "IputTextCollectionViewCell")
        let nib2 = UINib(nibName: "TextCLVCell", bundle:nil)
        myCollectionView.register(nib2, forCellWithReuseIdentifier: "TextCLVCell")
        SQLService.shared.getQuiz2(){data,error in
            if let data = data{
                self.DataQuiz2 = data
                
            }
            
        }
        
        
    }
  
    

    // MARK:- Click Button Use Hints
    @IBAction func ClickHints(_ sender: Any) {
        if pointHints > 0{
            pointHints -= 1
            updateHints(update: pointHints)
            clickUseHints()
            LabelPoint?.text = String(pointHints)
            
        }else{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PopUpHintViewController") as! PopUpHintViewController
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            vc.lblStr  = "End Of The Hints"
           
            self.present(vc, animated: false, completion: nil)
        }
       
      
    }
    
//    @IBAction func ButtonHint(_ sender: Any) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HintViewController") as! HintViewController
//        vc.modalPresentationStyle = .fullScreen
//
//        self.present(vc, animated: true, completion: nil)
//    }
    // MARK:- Update Hints
    func updateHints(update:Int){
        let result = realm.objects(ModelHints.self).filter("id == 1").first
        try! realm.write {
            result!.hint = update
                }
    }
    // MARK:- Create a random Character
    func randomChar() -> String{
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ "
        return String((0..<1).map{ _ in letters.randomElement()! })
    }
    // MARK:- Create a random String
    func randomString(length: Int) -> String {
        
        if isStr == true {
            isStr = false
            strAns = String((0..<length).map{ _ in arrAns.randomElement()! })
            idx += 1
            return strAns
        }else{
            if idx < 20 {
                idx += 1
                for (i,e) in arrAns.enumerated() {
                    if String(e) == strAns {
                        arrAns.remove(at: i)
                        break
                    }
                    
                }
                strAns = String((0..<length).map{ _ in arrAns.randomElement()! })
                return strAns
            }else{
                idx += 1
                return String(arrAns)
            }
            
        }
        
        
    }
    
    func randomAnswer(presoname: String){
        let pro = presoname + randomString(length: 1)
        wordListArray = pro
        
    }
    
}

extension PlayerViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    // MARK:- numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if section == 0 {
            return dataAns.count
        }else{
            
            return 20
        }
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
    UICollectionViewCell {
        if indexPath.section == 0{
            let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "TextCLVCell", for: indexPath) as!TextCLVCell
            
            return cell
        }else{
            let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "IputTextCollectionViewCell", for: indexPath) as!IputTextCollectionViewCell
            
            cell.LabelInput?.text = String(listChar[indexPath.row])
            
            
            
            return cell
        }
        
        
    }
    
    //    func collectionView(_ collectionView: UICollectionView,
    //                        viewForSupplementaryElementOfKind : String,
    //                        at indexPath: IndexPath) -> UICollectionReusableView {
    //        return UICollectionReusableView()
    //    }
    
}

extension PlayerViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    // MARK:- didSelectItem
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if isHintCell.count < dataAns.count && indexPath.section == 1 {
            
            if isAppend == true {
                isHintCell.append(indexPath.row)
                
                let cell = collectionView.cellForItem(at: IndexPath.init(row: idxArrAns, section: 0)) as! TextCLVCell 
                cell.Namekey?.text = String(listChar[indexPath.row])
                charAns.append(listChar[indexPath.row])
                
                myCollectionView.cellForItem(at: indexPath)?.isHidden = true
                idxArrAns += 1
            }else{
                var isN :Bool = true
                for (i,e) in isHintCell.enumerated() {
                    if e == -1 {
                        isN = false
                        isHintCell[i] = indexPath.row
                        charAns[i] = listChar[indexPath.row]
                        guard let cell = collectionView.cellForItem(at: IndexPath.init(row: i, section: 0)) as? TextCLVCell else {
                            return
                        }
                        cell.Namekey?.text = String(listChar[indexPath.row])
                        myCollectionView.cellForItem(at: indexPath)?.isHidden = true
                        break
                    }
                }
                if isN {
                    isHintCell.append(indexPath.row)
                    
                    guard let cell = collectionView.cellForItem(at: IndexPath.init(row: idxArrAns, section: 0)) as? TextCLVCell else {
                        return
                    }
                    cell.Namekey?.text = String(listChar[indexPath.row])
                    charAns.append(listChar[indexPath.row])
                    
                    myCollectionView.cellForItem(at: indexPath)?.isHidden = true
                    idxArrAns += 1
                }
            }
            if charAns.count == dataAns.count{
                if String(charAns) == dataAns {
                    if isFirstPass == 0 {
                        pointHints = pointHints + 5
                        updateHints(update: pointHints)
                        LabelPoint?.text = String(pointHints)
                        addPass(id: dataLevel + 1)
                    }
                    unlockLevel(id: dataLevel + 2)
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "PopUpCheckViewController") as! PopUpCheckViewController
                    vc.modalPresentationStyle = .overFullScreen
                    vc.modalTransitionStyle = .crossDissolve
                    vc.strQes = dataQuestion
                    vc.strAns = dataAns
                    vc.idxLevel = dataLevel + 1
                    vc.strImage = "Continute"
                    self.present(vc, animated: true, completion: nil)
                }else{
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "PopUpCheckViewController") as! PopUpCheckViewController
                    vc.modalPresentationStyle = .overFullScreen
                    vc.modalTransitionStyle = .crossDissolve
                    vc.strQes = dataQuestion
                    vc.strAns = "FALSE"
                    vc.strImage = "TryAgain"
                    vc.idxLevel = dataLevel
                    self.present(vc, animated: true, completion: nil)
                    
                }
                
            }
        
            
            
        }else if isHintCell.count > indexPath.row && indexPath.section == 0 {
            if isHintCell[indexPath.row] != -2 {
                isAppend = false
                myCollectionView.cellForItem(at: IndexPath.init(row: isHintCell[indexPath.row], section: 1))?.isHidden = false
                if isHintCell[indexPath.row] != -1{
                    isHintCell[indexPath.row] = -1
                    charAns[indexPath.row] = "."
                  
                }
                
                guard let cell = collectionView.cellForItem(at: indexPath) as? TextCLVCell else {
                    return
                }
                cell.Namekey?.text = ""
            }
        }
        
        
        
    }
    // MARK:- sizeForItemAt
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt
                            indexPath: IndexPath) -> CGSize {
    
            if (UIDevice.current.userInterfaceIdiom == .pad){
                return CGSize(width: 60,height: 60)
            }else{
               
                return CGSize(width: 30, height: 30)
            }
            
       
      
        
    }
    // MARK:- numberOfSections
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    // MARK:- func Click Use hints
    func clickUseHints(){
        if charAns.count > 0 {
            var isY : Bool = true
            var isC : Character = "."
            for (i,e) in isHintCell.enumerated(){
                if e == -1 {
                    isY = false
                    charAns[i] = arrAnsLet[i]
                    isC = arrAnsLet[i]
                    
                    isHintCell[i] = -2
                    guard let cell = myCollectionView.cellForItem(at: IndexPath.init(row: i, section: 0)) as? TextCLVCell else {
                        return
                    }
                    cell.Namekey.textColor = UIColor.red
                    cell.Namekey?.text = String(arrAnsLet[i])
                    logicHints(isC: isC)
                    break
                }
            }
            if isY {
                charAns.append(arrAnsLet[idxArrAns])
                
                print("count \(charAns.count)")
                isHintCell.append(-2)
                guard let cell = myCollectionView.cellForItem(at: IndexPath.init(row: idxArrAns, section: 0)) as? TextCLVCell else {
                    return
                }
                cell.Namekey.textColor = UIColor.red
                cell.Namekey?.text = String(arrAnsLet[idxArrAns])
                logicHints(isC: arrAnsLet[idxArrAns])
                idxArrAns += 1
            }
        }else{
           
            charAns.append(arrAnsLet[0])
            isHintCell.append(-2)
            guard let cell = myCollectionView.cellForItem(at: IndexPath.init(row: idxArrAns, section: 0)) as? TextCLVCell else {
                return
            }
            cell.Namekey.textColor = UIColor.red
            cell.Namekey?.text = String(arrAnsLet[0])
            logicHints(isC: arrAnsLet[0])
            idxArrAns += 1
        }
        var checkChar : Int = 0
        for i in charAns{
            if i == "." {
                checkChar += 1
                break
            }
        }
        if charAns.count == dataAns.count && checkChar != 1{
            if String(charAns) == dataAns {
                if isFirstPass == 0 {
                    pointHints = pointHints + 5
                    updateHints(update: pointHints)
                    LabelPoint?.text = String(pointHints)
                    addPass(id: dataLevel + 1)
                }
                unlockLevel(id: dataLevel + 2)
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "PopUpCheckViewController") as! PopUpCheckViewController
                vc.modalPresentationStyle = .overFullScreen
                vc.modalTransitionStyle = .crossDissolve
                vc.strQes = dataQuestion
                vc.strAns = dataAns
                vc.strImage = "Continute"
                vc.idxLevel = dataLevel + 1
                self.present(vc, animated: true, completion: nil)
            }else{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "PopUpCheckViewController") as! PopUpCheckViewController
                vc.modalPresentationStyle = .overFullScreen
                vc.modalTransitionStyle = .crossDissolve
                
                vc.strQes = dataQuestion
                vc.strAns = "FALSE"
                vc.strImage = "TryAgain"
                vc.idxLevel = dataLevel
                self.present(vc, animated: true, completion: nil)
                
            }
            
        }
        print("ishint \(isHintCell)")
        print("ischar \(charAns)")
    }
    // MARK:- func Logic Hints
    func logicHints(isC :Character){
        var idx : Int  = 0
        var idx0 : Int = 0
        
        for i in charAns{
            if i == isC {
                idx += 1
                idx0 += 1
            }
         
        }
        var idx1 : Int = 0
        for i in listChar{
            if i == isC {
                idx1 += 1
            }
        }
       print("and \(idx0)")
        print("and \(idx1)")
        for (i,e) in listChar.enumerated(){
            
            if e == isC {
                idx -= 1
                guard let cell = myCollectionView.cellForItem(at: IndexPath.init(row: i, section: 1)) as? IputTextCollectionViewCell else {
                    return
                }
                if cell.isHidden {
                    for (i,e) in charAns.enumerated(){
                        if e == isC && isHintCell[i] != -2 && e != arrAnsLet[i] && idx0 > idx1{
                            
                            guard let cell = myCollectionView.cellForItem(at: IndexPath.init(row: i, section: 0)) as? TextCLVCell else {
                                return
                            }
                            cell.Namekey?.text = ""
                            isHintCell[i] = -1
                            charAns[i] = "."
                            cell.Namekey.textColor = UIColor.black
                            break
                        }
                    }
                }else{
                    cell.isHidden = true
                }
                
                if idx == 0{
                    break
                }
                
                
            }
        }
    }
    // MARK:- func Unlock Level
    
    func unlockLevel(id:Int){
        SQLService.shared.updateKey(id: id)
    }
    // MARK:- func Add Pass
    func addPass(id:Int){
        SQLService.shared.updatePass(id: id)
    }
    
}

    
    

