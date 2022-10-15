//
//  TableViewController.swift
//  EBikeV1-TestA
//
//  Created by Rick Mc on 9/5/18.
//  Copyright © 2018 Rick Mc. All rights reserved.
//

import UIKit
import CoreData

class TableViewController : UITableViewController {

    let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    static var tableText = Array(repeating: "", count: 20)
    var fEntries: [NSManagedObject] = []
    var searchText : String = ""
    let textCellIndentifier = "feedCell"
    let feedProcess = NewsFeedClient.sharedInstance
    
    var tapGesture = UITapGestureRecognizer()
    
    static var feedListAdded = [String]()
    static var urlListAdded = [String]()
    
  
    @IBOutlet var feedTableView: UITableView!

    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        displayList()
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(TableViewController.myviewTapped(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        self.tableView.addGestureRecognizer(tapGesture)
        self.tableView.isUserInteractionEnabled = true
 
        
// Longpress lines
//        let longPressGesture:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(TableViewController.longPress(_:)))
//        longPressGesture.minimumPressDuration = 0.1
//        longPressGesture.delegate = self as? UIGestureRecognizerDelegate
//        self.tableView.addGestureRecognizer(longPressGesture)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableViewController.tableText.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIndentifier, for: indexPath as IndexPath)
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = TableViewController.tableText[indexPath.row]
                return cell
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Favorite") { (action, view, bool) in
            debugPrint("Favorite")
            bool(true)
            TableViewController.feedListAdded.append(TableViewController.tableText[indexPath.row])
            TableViewController.urlListAdded.append(TableViewController.urlListAdded[indexPath.row])
            
                self.save(title:TableViewController.tableText[indexPath.row], url:TableViewController.urlListAdded[indexPath.row])
        }

        debugPrint(TableViewController.feedListAdded)
        
        action.backgroundColor = UIColor.blue
        let configuration = UISwipeActionsConfiguration(actions: [action])
        return configuration
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let swipeAction = UISwipeActionsConfiguration(actions: [])
        swipeAction.performsFirstActionWithFullSwipe = false // This is the line which disables full swipe
        return swipeAction
    }
    
    @objc func longPress(_ longPressGestureRecognizer: UILongPressGestureRecognizer) {
        
        if longPressGestureRecognizer.state == UIGestureRecognizer.State.began {
            
            let touchPoint = longPressGestureRecognizer.location(in: self.view)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                let urlArticle = TableViewController.urlListAdded[indexPath.row]
                if let urlArticle = URL(string: urlArticle), UIApplication.shared.canOpenURL(urlArticle) {
                    //UIApplication.shared.openURL(urlArticle)
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
                   //UIApplication.shared.openURL(urlArticle)
                   UIApplication.shared.open(URL(string: "\(urlArticle)")!)
               }
           }
        }
    
    func save(title: String, url : String) {
        
        let fEntry = CoreDataStack.sharedManager.insertEntry(title: title, url: url)
        
        if fEntry != nil {
            fEntries.append(fEntry!)
            tableView.reloadData()
        }
    }
    
    func displayList()
    {
    
       // var textA : String = ""
        
        self.startLoading();
        
        let _ = feedProcess().getListArticles(searchText) { (data, error) in
            
                    let textList = data!["articles"] as! Array<Any>?
                  //  var articlesList : String = ""
          //          var itemText : String = ""
                    var articleCount = 0
                    if(textList?.count  == nil ){
                        articleCount = 1
                        debugPrint("There aren't any articles loaded.")
                    } else {
                        articleCount = textList!.count as Int
                    }
                    var urlText = Array(repeating: "", count: 20)
                    var titleText = Array(repeating: "", count: 20)
                   
                    // var articleCount = textList?.count as! Int
                    // Have to determine how to handle null
//                    if (textList?.count) == nil { articleCount = 1 }
                    if articleCount == 0 { articleCount = 1 }
                    if articleCount > 20 { articleCount = 20 }
                    for item in 0 ... articleCount - 1 {
                    let itemText = textList![item] as! [String : Any]
                        titleText[item].append(itemText["title"] as! String)
                        urlText[item].append(itemText["url"] as! String)
                            }
                    TableViewController.urlListAdded = urlText
                    TableViewController.tableText = titleText
                    debugPrint(TableViewController.tableText)
                    debugPrint("TotalAdded :", titleText)
                    DispatchQueue.main.async {
                            self.stopLoading()
                            self.tableView.reloadData()
                    }
                 }
            }
    
    func startLoading(){
        activityIndicator.center = self.view.center;
        activityIndicator.hidesWhenStopped = true;
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndicator.color = UIColor.gray
        view.addSubview(activityIndicator);
        activityIndicator.startAnimating();
        UIApplication.shared.beginIgnoringInteractionEvents();
        
    }
    
    func stopLoading(){
        
        activityIndicator.stopAnimating();
        UIApplication.shared.endIgnoringInteractionEvents();
    }
}




