//
//  CategoryRow.swift
//  ScrollBookLikeIBook
//
//  Created by Ta Minh Tu on 9/9/18.
//  Copyright © 2018 Ta Minh Tu. All rights reserved.
//

import UIKit

class CategoryRow: UITableViewCell {
    @IBOutlet weak var bookCollectionView: UICollectionView!
    
    var tmpImage: UIImage?
    
    var listBook:[Book]?
}


extension CategoryRow : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookCell", for: indexPath) as! BookCollectionViewCell
        cell.bookLabel.text = listBook![indexPath.row].name
        //print(listBook![indexPath.row].imageURL)
        cell.fetchImageFromUrl(url: listBook![indexPath.row].imageURL!)
        //self.bookCollectionView.reloadData()
        return cell
    }
    
    
    
    func setData(listBook: [Book])
    {
        self.listBook = listBook
        self.initCollection()
        //print(self.listBook!.count)
        self.bookCollectionView.reloadData()
    }
    
    func initCollection()
    {
        self.bookCollectionView.dataSource = self
        self.bookCollectionView.delegate = self
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listBook!.count
    }
    
}
