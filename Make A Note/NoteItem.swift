import Foundation
import UIKit

class NoteItem: NSObject, NSCoding {
    
    var noteContent = ""
    var textColor: UIColor = UIColor.black

    //CONFORMING TO NSCODING
    func encode(with aCoder: NSCoder) {
        aCoder.encode(noteContent, forKey: "noteContent")
        aCoder.encode(textColor, forKey: "textColor")
    }
    
    required init?(coder aDecoder: NSCoder) {
        noteContent = aDecoder.decodeObject(forKey: "noteContent") as! String
        textColor = aDecoder.decodeObject(forKey: "textColor") as! UIColor
        super.init()
    }
    
    override init() {
        super.init()
    }
}
