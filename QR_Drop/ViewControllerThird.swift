//
//  ViewControllerThird.swift
//  QR_Drop
//
//  Created by Salih Yusuf Göktaş on 16.06.2023.
//

import UIKit
import MessageUI


class ViewControllerThird: UIViewController {

	@IBOutlet weak var backButtonStyle: UIButton!
	@IBOutlet weak var modeSwitch: UISwitch!
	@IBOutlet weak var emailButtonStyle: UIButton!
	@IBOutlet weak var aboutButtonStyle: UIButton!
	@IBOutlet weak var imageView: UIImageView!
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		buttonStyle()
		modeSwitch.isOn = false
		
		let qrGif = UIImage.gifImageWithName("settings")
		imageView.image = qrGif
		
		func buttonStyle(){
			
			backButtonStyle.layer.cornerRadius = 15.0
			backButtonStyle.layer.shadowColor = UIColor.darkGray.cgColor
			backButtonStyle.layer.shadowRadius = 4
			backButtonStyle.layer.shadowOpacity = 0.5
			backButtonStyle.layer.shadowOffset = CGSize(width: 0, height: 0)
			
			emailButtonStyle.layer.cornerRadius = 15.0
			emailButtonStyle.layer.shadowColor = UIColor.darkGray.cgColor
			emailButtonStyle.layer.shadowRadius = 4
			emailButtonStyle.layer.shadowOpacity = 0.5
			emailButtonStyle.layer.shadowOffset = CGSize(width: 0, height: 0)
			
			aboutButtonStyle.layer.cornerRadius = 15.0
			aboutButtonStyle.layer.shadowColor = UIColor.darkGray.cgColor
			aboutButtonStyle.layer.shadowRadius = 4
			aboutButtonStyle.layer.shadowOpacity = 0.5
			aboutButtonStyle.layer.shadowOffset = CGSize(width: 0, height: 0)
			
		}
        
    }
	@IBAction func backButton(_ sender: UIButton) {
		self.dismiss(animated: true, completion: nil)
	}
	@IBAction func valueChanged(_ sender: UISwitch) {
		if modeSwitch.isOn == false
		{
		//light
		let window = UIApplication.shared.windows [0]
			window.overrideUserInterfaceStyle = .light
		}
		else
		{
		//dark
		let window = UIApplication.shared.windows [0]
			window.overrideUserInterfaceStyle = .dark
		}
	}
	@IBAction func emailButtonTapped(_ sender: Any) {
		showMailComposer()
	}
	
	func showMailComposer() {
			
			guard MFMailComposeViewController.canSendMail() else {
				//Show alert informing the user
				return
			}
			
			let composer = MFMailComposeViewController()
			composer.mailComposeDelegate = self
			composer.setToRecipients(["sygoktas@outlook.com.tr"])
			composer.setSubject("HELP!")
			composer.setMessageBody("I love your app, but... help!", isHTML: false)
			
			present(composer, animated: true)
		}
	@IBAction func aboutButton(_ sender: Any) {
		self.performSegue(withIdentifier: "goViewControllerFourth", sender: self)
	}
}
	
extension ViewControllerThird: MFMailComposeViewControllerDelegate {
	
	func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
		
		if let _ = error {
			//Show error alert
			controller.dismiss(animated: true)
			return
		}
		
		switch result {
		case .cancelled:
			print("Cancelled")
		case .failed:
			print("Failed to send")
		case .saved:
			print("Saved")
		case .sent:
			print("Email Sent")
		@unknown default:
			break
		}
		
		controller.dismiss(animated: true)
	}
}

