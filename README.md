<h1 align="center"> E-BikeUpdates </h1> <br>

<h4 align="center">Updates covering the electric motorcycle industry</h4> <br>
 

## Intro 👨🏾‍💻👩🏾‍💻👋🏾💻✊🏾

This project allows you to select from a list of fully electric motorcycles to see the latest updates from a variety of recent articles. 

<p align="center">
  <img alt="E-BikeUpdates" title="E-BikeUpdates" src="screenshots/ebike2.gif" width=300>
</p>

## Functions 
* Load TableView of electric motorcycles. 
* Pull articles using API for selected motorcycles. 
* Implement “leadingSwipeActionsConfigurationForRowAt” to favorite articles.
* Have favorited articles saved with CoreData functions. 
* Load URL's with external browser. 
* To make your version of this, you'll need to get a free API key from newsapi.org .
<br>

## Instructions
-After selecting an E-Bike, you'll see a list of articles and can swipe right to favorite an article. You can also long-press to load the article in an external browser. 

-You can tap on the "Favorites" tab at the bottom of the article list to see the ones you've favorited. A tap on a favorited article will also load it in a browser. 

-The app can be closed, then reloaded, and the favorited articles will remain in their tab. 

-Tap "Back" on the top left to go back to the full list of electric motorcycles. 

<br>

## Submitting article info with a Swipe

After implementing the TableView for listed articles, I wanted to add a swipe to favorite option. It was interesting adding this TableView swipe, which had to update the 2nd controller tab for favorites and also persist the article info to CoreData.

``` swift
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Favorite") { (action, view, bool) in
            bool(true)
            TableViewController.feedListAdded.append(TableViewController.tableText[indexPath.row])
            TableViewController.urlListAdded.append(TableViewController.urlList[indexPath.row])
            
                self.save(title:TableViewController.tableText[indexPath.row], url:TableViewController.urlList[indexPath.row])
        }
 ```
<br>

## Article Tips

Some good articles for tips : <br>
* <a href="http://www.kaleidosblog.com/swift-core-data-how-to-store-objects" target="_blank">CoreData : How to store objects</a><br>
* <a href="https://medium.com/@jacqschweiger/how-to-segue-programmatically-using-delegates-in-swift-e333a9800f5" target="_blank">How to Segue programatically using delegates in Swift</a><br>
* <a href="https://www.codementor.io/codementorteam/core-data-tutorial-saving-and-fetching-pdphdmh50" target="_blank">CoreData 101 : Saving and Fetching</a><br>
* <a href="https://www.raywenderlich.com/1067-self-sizing-table-view-cells" target="_blank" >Self-sizing TableView cells</a>
