//
//  ViewController.swift
//  lawpro
//
//  Created by devsenior on 04/09/2021.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController {

    
    
    let realm = try! Realm()
    override func viewWillAppear(_ animated: Bool) {
       
      
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let countM = realm.objects(ModelHints.self).filter("id == 1")
        if countM.count == 0 {
            addModelHints()
        }
        
       
    }
    func addModelHints(){
        let myHint = ModelHints()
        myHint.id = 1
        myHint.hint = 20
        try! realm.write {
            realm.add(myHint)
        }
    }


    @IBAction func ButtonNext(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "InsdeAppsViewController") as! InsdeAppsViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func ButtonPlay(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LevelViewController") as! LevelViewController
        vc.modalPresentationStyle = .fullScreen
       
        self.present(vc, animated: true, completion: nil)
    }
    

    
    @IBAction func ButtonSetting(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
}

