//
//  ImageViewerViewController.swift
//  EBikeV1-TestA
//
//  Created by modview on 9/17/22.
//  Copyright © 2022 Rick Mc. All rights reserved.
//

import Foundation

import UIKit

class ImageViewerViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var imageName: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupImageView()
    }
    
    @IBAction func save(_ sender: Any) {
      guard let image = imageView.image else { return }
        UIImageWriteToSavedPhotosAlbum(imageView.image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)),nil )
        }
    

    private func setupImageView() {
        guard let name = imageName else { return }
        
        if let image = UIImage(named: name) {
            imageView.image = image
        }
    }

    @objc func image(_ image: UIImage, didFinishSavingWithError error:Error?, contextInfo: UnsafeRawPointer) {
    if let error = error {
        let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title:"OK", style: .default))
    } else {
                let ac = UIAlertController(title: "Saved!", message: "Your Wallpaper image has been saved to your photos.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title:"OK", style:.default))
                present(ac, animated:true)
            }
    }
}
        
