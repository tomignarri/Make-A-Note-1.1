//
//  AddNoteViewController.swift
//  Make A Note
//
//  Created by Thomas Ignarri on 8/3/17.
//  Copyright © 2017 Thomas Ignarri. All rights reserved.
//

import UIKit

protocol AddNoteViewControllerDelegate: class {
    func addNoteViewControllerDidCancel(_ controller: AddNoteViewController)
    func addNoteViewController(_ controller: AddNoteViewController, didFinishAdding item: NoteItem)
    func addNoteViewController(_ controller: AddNoteViewController, didFinishEditing item: NoteItem)
}

class AddNoteViewController: UITableViewController, UITextFieldDelegate {
    
    var itemToEdit: NoteItem?
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!

    weak var delegate: AddNoteViewControllerDelegate?
    
    @IBAction func done(_ sender: Any) {
        if let item = itemToEdit {
        item.noteTitle = textField.text!
        item.noteContent = textView.text!
        delegate?.addNoteViewController(self, didFinishEditing: item)
        } else {
            let item = NoteItem()
            item.noteTitle = textField.text!
            item.noteContent = textView.text!
            delegate?.addNoteViewController(self, didFinishAdding: item)
        }
    }

    @IBAction func cancel(_ sender: Any) {
        delegate?.addNoteViewControllerDidCancel(self)
    }
    
    //RESEARCH THIS NEXT TIME YOU'RE WORKING
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text! as NSString
        
        
        let newText = oldText.replacingCharacters(in: range, with: string) as NSString
        //let newTextView = oldTextView.replacingCharacters(in: range, with: string) as NSString
        
        doneBarButton.isEnabled = (newText.length > 0)
        
        return true
    }
    ////////////////////////////////////
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.noteTitle
            textView.text = item.noteContent
            doneBarButton.isEnabled = true /////ENABLE DONE IN EDIT MODE
        }
    }

}
