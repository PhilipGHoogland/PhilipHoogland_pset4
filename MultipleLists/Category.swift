//
//  Category.swift
//  MultipleLists
//
//  Created by Swift on 9/22/16.
//  Copyright © 2016 Swift. All rights reserved.
//

import UIKit

class Category: NSObject {

    var name = ""
    var items = [Item]()

    
    init(name: String) {
        self.name = name
    }
}

