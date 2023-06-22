//
//  ViewController.swift
//  QR_Drop
//
//  Created by Salih Yusuf Göktaş on 14.06.2023.
//

import UIKit
import VisionKit

class ViewControllerFirst: UIViewController {
	
	@IBOutlet weak var scanningButtonStyle: UIButton!
	@IBOutlet weak var goGenerateButtonStyle: UIButton!
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var goSettingsButtonStyle: UIButton!
	
	var scannerAvailable: Bool {
		DataScannerViewController.isSupported && DataScannerViewController.isAvailable
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		buttonStyle()
		func buttonStyle(){
			
			scanningButtonStyle.layer.cornerRadius = 15.0
			scanningButtonStyle.layer.shadowColor = UIColor.darkGray.cgColor
			scanningButtonStyle.layer.shadowRadius = 4
			scanningButtonStyle.layer.shadowOpacity = 0.5
			scanningButtonStyle.layer.shadowOffset = CGSize(width: 0, height: 0)
			
			goGenerateButtonStyle.layer.cornerRadius = 15.0
			goGenerateButtonStyle.layer.shadowColor = UIColor.darkGray.cgColor
			goGenerateButtonStyle.layer.shadowRadius = 4
			goGenerateButtonStyle.layer.shadowOpacity = 0.5
			goGenerateButtonStyle.layer.shadowOffset = CGSize(width: 0, height: 0)
			
			goSettingsButtonStyle.layer.cornerRadius = 15.0
			goSettingsButtonStyle.layer.shadowColor = UIColor.darkGray.cgColor
			goSettingsButtonStyle.layer.shadowRadius = 4
			goSettingsButtonStyle.layer.shadowOpacity = 0.5
			goSettingsButtonStyle.layer.shadowOffset = CGSize(width: 0, height: 0)
			
		}

		let qrGif = UIImage.gifImageWithName("qr code scanning")
		imageView.image = qrGif
	}
	
	@IBAction func scanningButton(_ sender: Any) {
	guard scannerAvailable == true else { return }
 
 let regonizedDataTypes:Set<DataScannerViewController.RecognizedDataType> = [
   .text(),
   .barcode()
 ]
 
 let dataScanner = DataScannerViewController(recognizedDataTypes: regonizedDataTypes, isHighlightingEnabled: true)
 dataScanner.delegate = self
 present(dataScanner, animated: true) {
   try? dataScanner.startScanning()
 }
}
	
	
	@IBAction func goSettingsButton(_ sender: UIButton) {
		self.performSegue(withIdentifier: "goViewControllerThird", sender: self)
	}
	
	@IBAction func goGenerateButton(_ sender: UIButton) {
		self.performSegue(withIdentifier: "goViewControllerSecond", sender: self)
	}
	
}

extension ViewControllerFirst: DataScannerViewControllerDelegate {
  
  func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
	switch item {
	case .text(let text):
	  print("text: \(text.transcript)")
	  UIPasteboard.general.string = text.transcript
	  dataScanner.stopScanning()
	  dataScanner.dismiss(animated: true)
	case .barcode(let code):
	  guard let urlString = code.payloadStringValue, let url = URL(string: urlString) else { return }
	  UIApplication.shared.open(url)
	  dataScanner.stopScanning()
	  dataScanner.dismiss(animated: true)
	default:
	  print("Unexpected item")
	}
  }
	
  
}
