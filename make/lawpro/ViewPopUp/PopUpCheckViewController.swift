//
//  PopUpCheckViewController.swift
//  lawpro
//
//  Created by Pham Van Thai on 11/11/2021.
//

import UIKit

class PopUpCheckViewController: UIViewController {
    @IBOutlet weak var lblQes: UILabel!
    
    @IBOutlet weak var lblAns: UILabel!
    @IBOutlet weak var imgBtn: UIButton!
    var strImage :String = ""
    var strQes :String = ""
    var strAns :String = ""
    var idxLevel : Int = 0
    var DataQuiz :[ModelQuiz2] = [ModelQuiz2]()
    override func viewDidLoad() {
        super.viewDidLoad()
        lblQes?.text = strQes
        if strImage == "TryAgain" {
            lblAns.textColor = UIColor.red
        }
        lblAns?.text = strAns
        imgBtn.setBackgroundImage(UIImage.init(named: strImage), for: .normal)
        SQLService.shared.getQuiz2(){data,error in
            if let data = data{
                self.DataQuiz = data
                
            }
            
        }

        // Do any additional setup after loading the view.
    }
    @IBAction func isTrue(_ sender: Any) {
        if idxLevel < 50{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PlayerViewController") as! PlayerViewController
            vc.modalPresentationStyle = .fullScreen
            vc.dataLevel = idxLevel
            vc.dataQuestion = DataQuiz[idxLevel].question
            vc.dataAns =  DataQuiz[idxLevel].ans
            print(DataQuiz[idxLevel].firstpass)
                
                self.present(vc, animated: false, completion: nil)
        }
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
