//
//  ViewControllerSecond.swift
//  QR_Drop
//
//  Created by Salih Yusuf Göktaş on 15.06.2023.
//

import UIKit

class ViewControllerSecond: UIViewController {
	
	@IBOutlet weak var backButtonStyle: UIButton!
	@IBOutlet weak var textFieldButtonStyle: UITextField!
	@IBOutlet weak var qrImageView: UIImageView!
	@IBOutlet weak var generateButtonStyle: UIButton!
	@IBOutlet weak var saveButtonStyle: UIButton!
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		buttonStyle()
		
		func buttonStyle(){
			
			backButtonStyle.layer.cornerRadius = 15.0
			backButtonStyle.layer.shadowColor = UIColor.darkGray.cgColor
			backButtonStyle.layer.shadowRadius = 4
			backButtonStyle.layer.shadowOpacity = 0.5
			backButtonStyle.layer.shadowOffset = CGSize(width: 0, height: 0)
			
			saveButtonStyle.layer.cornerRadius = 15.0
			saveButtonStyle.layer.shadowColor = UIColor.darkGray.cgColor
			saveButtonStyle.layer.shadowRadius = 4
			saveButtonStyle.layer.shadowOpacity = 0.5
			saveButtonStyle.layer.shadowOffset = CGSize(width: 0, height: 0)
			
			generateButtonStyle.layer.cornerRadius = 15.0
			generateButtonStyle.layer.shadowColor = UIColor.darkGray.cgColor
			generateButtonStyle.layer.shadowRadius = 4
			generateButtonStyle.layer.shadowOpacity = 0.5
			generateButtonStyle.layer.shadowOffset = CGSize(width: 0, height: 0)
			
			qrImageView.layer.borderWidth = 5
			qrImageView.layer.borderColor = UIColor.systemBlue.cgColor
			qrImageView.clipsToBounds = true
			qrImageView.layer.masksToBounds = true
		}
		
		let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeTheKeyboard))
		view.addGestureRecognizer(gestureRecognizer)
		
	}
	
	@objc func closeTheKeyboard() {

	view.endEditing(true)

	}
	
	@IBAction func backButton(_ sender: UIButton) {
		self.dismiss(animated: true, completion: nil)
	}
	
	@IBAction func generateButton(_ sender: Any) {
		
		let myName = textFieldButtonStyle.text
		if let name = myName {
			let combinedString = "\(name)\n\(Date())"
			qrImageView.image = generateQRCode(Name:combinedString)
			
		}
		
	}
	
	func generateQRCode(Name:String) -> UIImage? {
		
		let name_data = Name.data(using:String.Encoding.ascii)
		
		if let filter = CIFilter(name:"CIQRCodeGenerator" ){
			filter.setValue (name_data, forKey: "inputMessage")
			
			let transform = CGAffineTransform(scaleX: 3, y: 3)
			if let output = filter.outputImage?.transformed (by: transform){
				return UIImage(ciImage:output)
			}
			
		}
			return nil
	}
	@IBAction func saveButton(_ sender: Any) {
		let imageData = qrImageView.image!.pngData()
		let compresedImage = UIImage(data: imageData!)
		UIImageWriteToSavedPhotosAlbum(compresedImage!, nil, nil, nil)
		
		let alert = UIAlertController(title: "Saved", message: "The QR code image you created has been saved to your photos.", preferredStyle: .alert)
		let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
		alert.addAction(okAction)
		self.present(alert, animated: true, completion: nil)
		
		
	}
	
}
