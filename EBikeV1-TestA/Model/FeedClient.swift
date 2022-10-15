//
//  FeedClient.swift
//  EBikeV1-TestA
//
//  Created by Rick Mc on 9/5/18.
//  Copyright © 2018 Rick Mc. All rights reserved.
//

import Foundation
class NewsFeedClient {
    
    var session = URLSession.shared
    func getListArticles(_ articleHeading: String, completionHandlerForArticle: @escaping (_ text1: AnyObject?, _ error: NSError?)-> Void) -> URLSessionTask {
        
        // Constants.NewsFeedParameterValues.q
        
        debugPrint("Text line")
        let methodParameters = [
            Constants.NewsFeedParameterKeys.Keywords:articleHeading,
            Constants.NewsFeedParameterKeys.Page:Constants.NewsFeedParameterValues.pageSize,
            Constants.NewsFeedParameterKeys.Language:Constants.NewsFeedParameterValues.language,
            Constants.NewsFeedParameterKeys.APIKey:Constants.NewsFeedParameterValues.apiKey
        ]
        
        let request = URLRequest(url: newsfeedURLFromParameters(methodParameters as [String : AnyObject]))
        
        debugPrint(request)
        
        let task = session.dataTask(with:request) { (data, response, error) in
            func sendError(_ error: String) {
                debugPrint(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForArticle(nil, NSError(domain:"taskForGETMethod", code: 1, userInfo:userInfo))
            }
            guard (error == nil) else {
                sendError("There's an error with the request: \(String(describing:error))")
                return
            }
            guard let data = data else {
                sendError("No data was returned by the request.")
                return
            }
            self.convertDataWithCompletionHandler(data: data, completionHandlerForConvertData: completionHandlerForArticle)
            }
        task.resume()
        debugPrint("Method : ", methodParameters)
        debugPrint("Task : " , task)
        return task
        }
    

private func convertDataWithCompletionHandler(data:Data, completionHandlerForConvertData: (_ result: AnyObject?, _ error: NSError?) -> Void) {
    
    var parsedResult: AnyObject! = nil
    
    do  {
        parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
        completionHandlerForConvertData(nil, NSError(domain: "convertDataWithCompletionHandler", code:1, userInfo:userInfo))
        }
        completionHandlerForConvertData(parsedResult, nil)
        }


        private func newsfeedURLFromParameters(_ parameters: [String:AnyObject]) -> URL {
            
            var components = URLComponents()
            components.scheme = Constants.NewsFeed.APIScheme
            components.host = Constants.NewsFeed.APIHost
            components.path = Constants.NewsFeed.APIPath
            components.queryItems = [URLQueryItem]()
            
            for(key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                components.queryItems!.append(queryItem)
            }
            return components.url!
        }
    
    class func sharedInstance() -> NewsFeedClient {
        struct Singleton {
            static var sharedInstance = NewsFeedClient()
        }
        return Singleton.sharedInstance
    }
    
//    static let sharedInstance = NewsFeedClient()
    
    func searchFeedsB() {
        var textA : String = "StuffItem"
        self.getListArticles(textA) { (data, error) in
            debugPrint("Returned article info :", data)
            let textList = data!["articles"] as! Array<Any>?
            var articlesList : String = ""
            for item in 1...8 {
                let temp = textList![item] as! [String:Any]
                articlesList.append(temp["title"] as! String)
                 articlesList.append(temp["url"] as! String)
                debugPrint("searchFeeds Text : ", textList)
            }
            debugPrint("List : ", articlesList)
        }
    }
    
    
    
}
