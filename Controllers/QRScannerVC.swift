//
//  QRCodeScannerClass.swift
//  UMES Health
//
//  Created by Ikenna on 8/14/23.
//

import UIKit
import AVFoundation

class QRCodeScannerVC: UIViewController {
    @IBOutlet weak var qrCodeLink: UILabel!
    var qrCodeScanner: QRCodeScanner?
    @IBOutlet var startButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "QR Code Scanner"
        
        startButton.layer.cornerRadius = 6.0
    }

    @IBAction func startButtonTapped(_ sender: UIButton) {
        if qrCodeScanner == nil {
            qrCodeScanner = QRCodeScanner()
            qrCodeScanner?.setupScanner(on: view, delegate: self)
        } else {
            qrCodeScanner?.stopScanner()
            qrCodeScanner = nil
            startButton.isHidden = false
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        qrCodeScanner?.stopScanner()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

extension QRCodeScannerVC: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
           let qrCodeString = metadataObject.stringValue,
           let qrCodeURL = URL(string: qrCodeString) {
            
            qrCodeScanner?.stopScanner()
            qrCodeScanner = nil
            startButton.isHidden = false
            
            if UIApplication.shared.canOpenURL(qrCodeURL) {
                UIApplication.shared.open(qrCodeURL, options: [:], completionHandler: nil)
            }
        }
    }
}
