//
//  NoteListViewController.swift
//  Make A Note
//
//  Created by Thomas Ignarri on 7/31/17.
//  Copyright © 2017 Thomas Ignarri. All rights reserved.
//

import UIKit

class NoteListViewController: UITableViewController, AddNoteViewControllerDelegate, UINavigationControllerDelegate {
    
    var items: [NoteItem]
    
    required init?(coder aDecoder: NSCoder) {
        items = [NoteItem]()
        
        super.init(coder: aDecoder)
        //print("Documents folder is \(documentsDirectory())")
        //print("Data file path is \(dataFilePath())")
        loadNotelistItems()
    }
    
    //////PROTOCOL CONFORMING TO ADD NOTE VC
    func addNoteViewControllerDidCancel(_ controller: AddNoteViewController) {
        dismiss(animated: true, completion: nil) //this is just the funtionality of the cancel button
    }
    
    func addNoteViewController(_ controller: AddNoteViewController, didFinishAdding item: NoteItem) {
        let newRowIndex = items.count
        items.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        
        dismiss(animated: true, completion: nil)
        saveNotelistItems()
    }
    
    func addNoteViewController(_ controller: AddNoteViewController, didFinishEditing item: NoteItem) {
        
        if let index = items.index(of: item) { //this function only runs if the cell selected is a part of the array
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) { //find the cell for the row that was selected
                configureText(for: cell, with: item)
            }
        }
        dismiss(animated: true, completion: nil)
        saveNotelistItems()
    }
    ////////////////////////////////

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddNote" {
            let navigationController = segue.destination as! UINavigationController //segue.destination is the location of the view controller...it needs to go through the navigation controller to get to AddNoteVC
            let controller = navigationController.topViewController as! AddNoteViewController //the "top view" is the active controller in the nav controller
            controller.delegate = self
        } else if segue.identifier == "EditNote" {
                let navigationController = segue.destination as! UINavigationController
                let controller = navigationController.topViewController as! AddNoteViewController
                controller.delegate = self
                if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) { //the sender parameter refers to the cell that was tapped
                    controller.itemToEdit = items[indexPath.row]
                }
            }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteItem", for: indexPath)
        
        let item = items[indexPath.row] //asks for the object that corresponds to the row number
        
        configureText(for: cell, with: item)
        return cell
    }
    
    func configureText(for cell: UITableViewCell, with item: NoteItem) {
        let label = cell.viewWithTag(1) as! UILabel
        label.text = item.noteContent
    }
    
    
    //DELETING A CELL
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        items.remove(at: indexPath.row)
        let indexPaths = [indexPath] //use a single object array becasue delete rows and insert rows require an array
        tableView.deleteRows(at: indexPaths, with: .automatic)
        saveNotelistItems()
    }
    /////////////////
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //DIRECTORY SAVING FUNCTIONALITY
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("Notelists.plist")
    }
    
    func saveNotelistItems() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(items, forKey: "NotelistItems")
        archiver.finishEncoding()
        data.write(to: dataFilePath(), atomically: true)
    }
    //LOAD DATA METHOD
    func loadNotelistItems() {
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path) {
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            items = unarchiver.decodeObject(forKey: "NotelistItems") as! [NoteItem]
            unarchiver.finishDecoding()
        }
    }
}
