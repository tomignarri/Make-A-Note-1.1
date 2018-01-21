//
//  ColorPickerViewController.swift
//  Make A Note
//
//  Created by Thomas Ignarri on 12/28/17.
//  Copyright © 2017 Thomas Ignarri. All rights reserved.
//

import UIKit

protocol PizzaDelegate {
    func onPizzaReady(type: UIColor)
}

class ColorPickerViewController: UITableViewController {

    var colorPicked = ""
    var colors = ["Blue", "Red", "Green"]
    
    var delegate:PizzaDelegate?
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colors.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ColorItem", for: indexPath)
        let label = cell.viewWithTag(1) as! UILabel
        label.text = colors[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //THIS METHOD CAN'T RETURN A STRING...WHY?
        
        if indexPath.row == 0 {
            delegate?.onPizzaReady(type: UIColor.blue)
        }
        if indexPath.row == 1 {
            delegate?.onPizzaReady(type: UIColor.red)
        }
        if indexPath.row == 2 {
            delegate?.onPizzaReady(type: UIColor.green)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

}
