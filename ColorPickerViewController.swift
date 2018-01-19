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

    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    
    var colorPicked = ""
    var colors = ["blue", "red", "green"]
    
    /////////////////////////////////
    var delegate:PizzaDelegate?
    /////////////////////////////////
    
    @IBAction func done(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        //assign value of selected row to NoteItem.textColor
    }
    
    
    
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
        //THIS METHOD CAN'T RETURN A STRING...WHY IS THAT?
        if indexPath.row == 0 {
            //colorPicked = "blue"
            //print("is", colorPicked)
            delegate?.onPizzaReady(type: UIColor.blue) //type is green string (or color type if possible)
        }
        if indexPath.row == 1 {
            //colorPicked = "red"
            //print("is", colorPicked)
            delegate?.onPizzaReady(type: UIColor.red) //type is green string (or color type if possible)
        }
        if indexPath.row == 2 {
            //colorPicked = "green"
            //print("is", colorPicked)
            delegate?.onPizzaReady(type: UIColor.green) //type is green string (or color type if possible)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

}
