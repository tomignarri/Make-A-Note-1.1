//
//  NoteItem.swift
//  Make A Note
//
//  Created by Thomas Ignarri on 8/2/17.
//  Copyright © 2017 Thomas Ignarri. All rights reserved.
//

import Foundation

class NoteItem: NSObject, NSCoding {
    
    var noteTitle = ""
    var noteContent = ""

    //CONFORMING TO NSCODING
    func encode(with aCoder: NSCoder) {
        aCoder.encode(noteTitle, forKey: "noteTitle")
        aCoder.encode(noteContent, forKey: "noteContent")
    }
    required init?(coder aDecoder: NSCoder) {
        noteTitle = aDecoder.decodeObject(forKey: "noteTitle") as! String
        noteContent = aDecoder.decodeObject(forKey: "noteContent") as! String
        super.init()
    }
    override init() {
        super.init()
    }
    //CONFORMING TO NSCODING
}
