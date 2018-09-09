//
//  Book.swift
//  ScrollBookLikeIBook
//
//  Created by Ta Minh Tu on 9/9/18.
//  Copyright © 2018 Ta Minh Tu. All rights reserved.
//

import UIKit
class Book {
    var name: String?
    var imageURL: String?
    var description: String?
    
    init (title: String, subTitle: String?, smallThumbnail: String) {
        if subTitle != nil && subTitle != "" {
            self.name = subTitle;
        }
        else {
            self.name = title;
        }
        
        
        self.imageURL  = smallThumbnail;
    }
}
