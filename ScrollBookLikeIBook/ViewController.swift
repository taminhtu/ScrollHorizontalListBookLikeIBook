//
//  ViewController.swift
//  ScrollBookLikeIBook
//
//  Created by Ta Minh Tu on 9/9/18.
//  Copyright © 2018 Ta Minh Tu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    var listBook = [Book]()
    
    @IBOutlet weak var tableViewObj: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CategoryRow
        cell.setData(listBook: self.listBook)
        return cell
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // load data
        let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=learnswift") // get the list of book from google book api
        URLSession.shared.dataTask(with: ((url)! as URL), completionHandler: {(data, response, error) -> Void in
            if (error != nil) {
                print(error?.localizedDescription)
            } else {
                if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                    
                    if let actorArray = jsonObj!.value(forKey: "items") as? NSArray {
                        for actor in actorArray{
                            //print (actor);
                            if let actorDict = actor as? NSDictionary {
                                
                                let volumeInfo = actorDict["volumeInfo"] as? [String: AnyObject]
                                
                                let imageLinks = volumeInfo!["imageLinks"] as? [String: AnyObject]
                                
                                var title = volumeInfo!["title"] as? String;
                                title = title?.trimmingCharacters(in: .whitespacesAndNewlines);
                                
                                var subTitle = volumeInfo!["subtitle"] as? String;
                                subTitle = subTitle?.trimmingCharacters(in: .whitespacesAndNewlines);
                                
                                if (volumeInfo != nil && imageLinks != nil) {
                                    var smallThumbnail = imageLinks!["smallThumbnail"] as! String;
                                    
                                    //print(volumeInfo)
                                    if (smallThumbnail != nil && title != nil && smallThumbnail != "" && title != "") {
                                        self.listBook.append(Book(title: title!, subTitle: subTitle, smallThumbnail: smallThumbnail))
                                    }
                                }
                            }
                        }
                    }
                    
                    OperationQueue.main.addOperation({
                        self.tableViewObj.reloadData()
                    })
                }
            }
        }).resume()
        
        reloadInputViews();
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


