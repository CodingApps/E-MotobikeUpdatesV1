//
//  FavoriteViewController.swift
//  EBikeV1-TestA
//
//  Created by Rick Mc on 9/15/18.
//  Copyright © 2018 Rick Mc. All rights reserved.
//

import UIKit
import CoreData

class FavViewController : UITableViewController {
    
    var tableText = Array(repeating: "", count: 20)
    var currentRow : Int = 0
    let textCellIndentifier = "favCell"
    
    var tapGesture = UITapGestureRecognizer()
    
    var fEntries: [NSManagedObject] = []
    
    @IBOutlet var favTableView: UITableView!
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(TableViewController.myviewTapped(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        self.tableView.addGestureRecognizer(tapGesture)
        self.tableView.isUserInteractionEnabled = true
        
// Long press lines
//        let longPressGesture:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(FavViewController.longPress(_:)))
//        longPressGesture.minimumPressDuration = 1.0
//        longPressGesture.delegate = self as? UIGestureRecognizerDelegate
//        self.tableView.addGestureRecognizer(longPressGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let listArticles = TableViewController.feedListAdded
        debugPrint(listArticles)
        return listArticles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let listArticles = TableViewController.feedListAdded
        
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIndentifier, for: indexPath as IndexPath)
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = listArticles[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       
  //     var listArticles = TableViewController.feedListAdded
       
      if editingStyle == .delete {
        print("Deleted")

          let name = TableViewController.feedListAdded[indexPath.row];
          let url = TableViewController.urlListAdded[indexPath.row];
          TableViewController.feedListAdded.remove(at: indexPath.row);
          tableView.deleteRows(at: [indexPath], with: .automatic);
 
          
          CoreDataStack.sharedManager.deleteEntry(name: name, ssn: url);
          
          
     //   saveFavsRevised(delEntry: indexPath.row);
      }
    }

    
    // savefavs(at: indexPath.row)
    
//    func saveFavsRevised(delEntry : FavTextArray) {
//
//        let fEntry = CoreDataStack.sharedManager.deleteEntry(fEntry: delEntry)
//        tableView.reloadData()
        
//        if fEntry != nil {
//            fEntries.delete(fEntry!)
//            tableView.reloadData()
      
    
    @objc func longPress(_ longPressGestureRecognizer: UILongPressGestureRecognizer) {
        
        if longPressGestureRecognizer.state == UIGestureRecognizer.State.began {
            
            let touchPoint = longPressGestureRecognizer.location(in: self.view)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                let urlArticle = TableViewController.urlListAdded[indexPath.row]
                if let urlArticle = URL(string: urlArticle), UIApplication.shared.canOpenURL(urlArticle) {
                   // UIApplication.shared.openURL(urlArticle)
                    UIApplication.shared.open(URL(string: "\(urlArticle)")!)
                }
            }
        }
    }
    
    @objc func myviewTapped(_ sender: UITapGestureRecognizer) {
        let touchPoint = tapGesture.location(in: self.view)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                let urlArticle = TableViewController.urlListAdded[indexPath.row]
                if let urlArticle = URL(string: urlArticle), UIApplication.shared.canOpenURL(urlArticle) {
                    UIApplication.shared.open(URL(string: "\(urlArticle)")!)
                }
            }
         }
}


