//
//  CustomAlertViewController.swift
//  Template
//
//  Created by Avadh on 12/05/22.
//

import UIKit

class CustomAlertViewController: UIViewController {
    
    @IBOutlet weak var vwBackGround: UIView!
    @IBOutlet weak var vwImageView: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblMainTitle: UILabel!
    @IBOutlet weak var lblSubMainTitle: UILabel!
    @IBOutlet weak var btnGotIt: UIButton!
    @IBOutlet weak var stackButton: UIStackView!
    
    var mainTitle = ""
    var subTitle = ""
    var image: UIImage?
    var buttons = [UIButton]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.vwBackGround.addTapGesture {
            self.dismiss()
        }
        
        if self.image != nil {
            self.vwImageView.isHidden = false
            self.img.image = image
        }
        
        let titleAttributeStr = NSMutableAttributedString()
            .attribute(text: mainTitle, fontStyle: .semibold, size: 16, spacing: 0.5, lineHeight: nil)
        let subTitleAttributeStr = NSMutableAttributedString()
            .attribute(text: subTitle, spacing: 0.5, lineHeight: 24.0)
        lblMainTitle.attributedText = titleAttributeStr
        lblSubMainTitle.attributedText = subTitleAttributeStr
        self.lblSubMainTitle.textAlignment = .center
        
        if buttons.count > 3 {
            stackButton.axis = .vertical
            stackButton.spacing = 15
        }
        
        for button in buttons {
            stackButton.addArrangedSubview(button)
        }
        // Do any additional setup after loading the view.
    }

}

extension CustomAlertViewController {
    
    @IBAction func actionGotit(_ sender: UIButton) {
        self.dismiss()
    }
}
