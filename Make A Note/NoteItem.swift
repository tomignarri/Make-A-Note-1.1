//
//  NoteItem.swift
//  Make A Note
//
//  Created by Thomas Ignarri on 8/2/17.
//  Copyright © 2017 Thomas Ignarri. All rights reserved.
//

import Foundation
import UIKit

class NoteItem: NSObject, NSCoding {
    
    var noteTitle = ""
    var noteContent = ""
    var textColor: UIColor = UIColor.black

    //CONFORMING TO NSCODING
    func encode(with aCoder: NSCoder) {
        aCoder.encode(noteTitle, forKey: "noteTitle")
        aCoder.encode(noteContent, forKey: "noteContent")
        aCoder.encode(textColor, forKey: "textColor")
    }
    required init?(coder aDecoder: NSCoder) {
        noteTitle = aDecoder.decodeObject(forKey: "noteTitle") as! String
        noteContent = aDecoder.decodeObject(forKey: "noteContent") as! String
        textColor = aDecoder.decodeObject(forKey: "textColor") as! UIColor
        super.init()
    }
    override init() {
        super.init()
    }
    //CONFORMING TO NSCODING
}
