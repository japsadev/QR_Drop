//
//  ViewControllerFourth.swift
//  QR_Drop
//
//  Created by Salih Yusuf Göktaş on 16.06.2023.
//

import UIKit

class ViewControllerFourth: UIViewController {

	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var backButtonStyle: UIButton!
	override func viewDidLoad() {
        super.viewDidLoad()

		buttonStyle()
		
		let qrGif = UIImage.gifImageWithName("about")
		imageView.image = qrGif
		
		
		func buttonStyle(){
			
			backButtonStyle.layer.cornerRadius = 15.0
			backButtonStyle.layer.shadowColor = UIColor.darkGray.cgColor
			backButtonStyle.layer.shadowRadius = 4
			backButtonStyle.layer.shadowOpacity = 0.5
			backButtonStyle.layer.shadowOffset = CGSize(width: 0, height: 0)
		}
        
    }

	@IBAction func backButton(_ sender: Any) {
		self.dismiss(animated: true, completion: nil)
	}
	
}
