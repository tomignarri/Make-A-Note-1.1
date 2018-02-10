//
//  ColorPickerViewController.swift
//  Make A Note
//
//  Created by Thomas Ignarri on 12/28/17.
//  Copyright © 2017 Thomas Ignarri. All rights reserved.
//

import UIKit

protocol ColorDelegate {
    func onColorReady(type: UIColor)
}

class ColorPickerViewController: UITableViewController {

    var colorPicked = ""
    var colors = ["Blue", "Red", "Green"]
    var delegate:ColorDelegate?
    
    //number of rows as determined by length of color array
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colors.count
    }
    
    //configure cell text with colors array strings
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ColorItem", for: indexPath)
        let label = cell.viewWithTag(1) as! UILabel
        label.text = colors[indexPath.row]
        return cell
    }
    
    //cell selection that sets text color
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            delegate?.onColorReady(type: UIColor.blue)
        }
        if indexPath.row == 1 {
            delegate?.onColorReady(type: UIColor.red)
        }
        if indexPath.row == 2 {
            delegate?.onColorReady(type: UIColor.green)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
