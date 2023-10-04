//
//  QRCodeScanner.swift
//  UMES Health
//
//  Created by Ikenna on 8/14/23.
//

import SwiftUI
import AVFoundation

struct QRCodeScanner {
    private var captureSession: AVCaptureSession?
    private var previewLayer: AVCaptureVideoPreviewLayer?
    private var delegate: AVCaptureMetadataOutputObjectsDelegate?
    
    mutating func setupScanner(on view: UIView, delegate: AVCaptureMetadataOutputObjectsDelegate) {
        self.delegate = delegate
        
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        guard let videoInput = try? AVCaptureDeviceInput(device: videoCaptureDevice) else { return }
        
        if captureSession?.canAddInput(videoInput) ?? false {
            captureSession?.addInput(videoInput)
        } else {
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if captureSession?.canAddOutput(metadataOutput) ?? false {
            captureSession?.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(delegate, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        previewLayer?.frame = view.layer.bounds
        previewLayer?.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer!)
        
        captureSession?.startRunning()
    }
    
    func stopScanner() {
        captureSession?.stopRunning()
        previewLayer?.removeFromSuperlayer()
    }
}
