//
//  AboutUSViewController.swift
//  lawpro
//
//  Created by devsenior on 15/09/2021.
//

import UIKit

class AboutUSViewController: UIViewController {
    @IBOutlet weak var lblText: UITextView!
    @IBOutlet weak var lblTitle: UILabel!
    var isScr: Int = 0
    let textA:String = "Devsenior founded in 2020 by MRSONPRO, Devsenior is one of the startup companies specializing in developing applications on two operating systems iOS .We are a passionate group to create affecting people's lives by creating IT products that they like to use for everyday life. We like to work with new technology and demonstrate a full commitment to agile workflow for a streamlined organization. We are product oriented, not only committed to user-friendly applications but also work with high quality code for sustainable development."
    let textB:String = """
 Privacy policy
    
    GENERAL

    Mathman has adopted this privacy policy (“Privacy Policy”) to explain how we collect, use and share information. By using or accessing our mobile applications, website or tools (“Services”), you agree to the terms of this Privacy Policy. Mathman reserves the right to modify this Privacy Policy at reasonable times, so please review it frequently. Your continued use of Services will signify your acceptance of the changes to this Privacy Policy.

    Personal data

    Personal data (“Personal Data”) is any information that that specifically identifies you as an individual.

    We collect Personal Data to a minimal possible extent which includes only device ID and related information to a device necessary for the successful operation of our Services. We do not collect and store IP-address, age, name, etc.

    Automatically Collected Information

    Application may collect certain information automatically, including, but not limited to, the type of mobile device you use, your mobile devices unique device ID, the IP address of your mobile device, your mobile operating system, the type of mobile Internet browsers you use, and information about the way you use the Application.

    Other information

    The Other Information we process may include, but is not limited to technical information, such as information about your device, your browser type, screen resolution, device type, language, version and type of operating system, SDK version, API key, application version, Android Vendor, geo location, levels achieved, in-app purchases.

    Purpose of storing the data

    Mathman may use or share data collected through the Services for purposes such as understanding or improving our Services.

    Our Third Party Service Providers

    We cannot provide all services necessary for the successful operation of our Apps by ourselves. We therefore share collected Information with our Providers. When using the Third Party Services, you adhere to their data processing practices.

    You recognize and agree that Mathman is not liable for the Third Party Service Provider’s terms and conditions and their use of your Information.

    Google Wallet: If you choose to use Google Checkout to finalize and pay for your order, you will provide your credit card number directly to Google Checkout. Google’s Privacy Policy will apply to the information you provide to the Google Checkout web site.
 """
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isScr == 0 {
            lblText?.text = textA
            lblTitle?.text = "ABOUT"
        }else{
            lblText?.text = textB
            lblTitle?.text = "PRIVACY POLICY"
        }
    }

    @IBAction func ButtonBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
