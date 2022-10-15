//
//  WallPaperViewController.swift
//  EBikeV1-TestA
//
//  Created by modview on 9/17/22.
//  Copyright © 2022 Rick Mc. All rights reserved.
//
import UIKit

struct Item {
    var imageName: String
}


class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var myCustomViewController = EMotoViewController()
    
    let motoRow = EMotoViewController.currentRow
    
    var items: [Item] = [Item(imageName:EMotoViewController.itemFileNames[0]),
                        Item(imageName:EMotoViewController.itemFileNames[1]),
                        Item(imageName:EMotoViewController.itemFileNames[2]),
                        Item(imageName:EMotoViewController.itemFileNames[3]),
                        Item(imageName:EMotoViewController.itemFileNames[4]),
                        Item(imageName:EMotoViewController.itemFileNames[5]),
                        Item(imageName:EMotoViewController.itemFileNames[6]),
                        Item(imageName:EMotoViewController.itemFileNames[7]),
                        Item(imageName:EMotoViewController.itemFileNames[8]),
                        Item(imageName:EMotoViewController.itemFileNames[9]),
                        Item(imageName:EMotoViewController.itemFileNames[10]),
                        Item(imageName:EMotoViewController.itemFileNames[11])]
    
    // firstImage, secondImage, thirdImage, forthImage, fifthImage, sixImage, seventhImage, eightImage, ninthImage, tenthImage, eleventhImage, twelvethImage
    
    

    var collectionViewFlowLayout: UICollectionViewFlowLayout!
    let cellidentifier = "itemCollectionViewCell"
    let viewImageSegueIdentifier = "viewImageSegueIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupCollectionView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupCollectionViewItemSize()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let item = sender as! Item
        if segue.identifier == viewImageSegueIdentifier {
            if let vc = segue.destination as? ImageViewerViewController {
                vc.imageName = item.imageName
            }
        }
    }
    private func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: "itemCollectionViewCell", bundle:nil )
        collectionView.register(nib, forCellWithReuseIdentifier: cellidentifier)
        
    }
    
    private func setupCollectionViewItemSize(){
        if collectionViewFlowLayout == nil {
            let numberOfItemPerRow: CGFloat = 2
            let lineSpacing: CGFloat = 5
            let interItemSpacing: CGFloat = 2
            
            let width = (collectionView.frame.width - (numberOfItemPerRow - 1) * interItemSpacing) / 2
            
            // / numberOfItemPerRow
            
            let height = width
            
            collectionViewFlowLayout = UICollectionViewFlowLayout()
            
            collectionViewFlowLayout.itemSize = CGSize(width: width, height: height)
            collectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
            collectionViewFlowLayout.scrollDirection = .vertical
            collectionViewFlowLayout.minimumLineSpacing = lineSpacing
            collectionViewFlowLayout.minimumInteritemSpacing = interItemSpacing
            
            collectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellidentifier, for: indexPath) as! itemCollectionViewCell
        
        cell.imageView.image = UIImage(named: items[indexPath.item].imageName)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.item]
        performSegue(withIdentifier: viewImageSegueIdentifier, sender: item)
    }
}
