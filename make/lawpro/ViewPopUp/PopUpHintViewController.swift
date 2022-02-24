//
//  PopUpHintViewController.swift
//  lawpro
//
//  Created by Pham Van Thai on 15/11/2021.
//

import UIKit

class PopUpHintViewController: UIViewController {
    var lblStr : String = ""
    
    let PlayerView = PlayerViewController()
   

    @IBOutlet weak var lblTitle: UILabel!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        lblTitle.text = lblStr
   
        // Do any additional setup after loading the view.
    }
    
    @IBAction func dismisScr(_ sender: Any) {
        
        dismiss(animated: false, completion: .none)
    }
    @IBAction func dismisScr1(_ sender: Any) {
     
        dismiss(animated: false, completion: .none)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
