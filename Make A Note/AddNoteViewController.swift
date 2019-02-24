import UIKit

protocol AddNoteViewControllerDelegate: class {
    func addNoteViewControllerDidCancel(_ controller: AddNoteViewController)
    func addNoteViewController(_ controller: AddNoteViewController, didFinishAdding item: NoteItem)
    func addNoteViewController(_ controller: AddNoteViewController, didFinishEditing item: NoteItem)
}

class AddNoteViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, ColorDelegate {
    
    // E5FD91 : NAV BAR COLOR
    
    var colorIdentifier = "color"
    var itemToEdit: NoteItem?
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    weak var delegate: AddNoteViewControllerDelegate?
    
    // On pressing done, set content of text view and current text color to NoteItem object.
    @IBAction func done(_ sender: Any) {
        if let item = itemToEdit {
        item.noteContent = textView.text!
        item.textColor = textView.textColor!
        delegate?.addNoteViewController(self, didFinishEditing: item)
        } else {
            let item = NoteItem()
            item.noteContent = textView.text!
            item.textColor = textView.textColor!
            delegate?.addNoteViewController(self, didFinishAdding: item)
        }
    }
    
    // Cancel a note that is in progress.
    @IBAction func cancel(_ sender: Any) {
        delegate?.addNoteViewControllerDidCancel(self)
    }
    
    // Segue to ColorPickerVC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ColorPickerViewController {
            // AddNoteViewController is delegate of cpvc.
            destination.delegate = self
        }
    }
    
    // Function to conform to ColorPickerVC protocol.
    func onColorReady(type: UIColor) {
        textView.textColor = type
    }
    
    // Done button should only be enabled if there soemthing has been written.
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text! as NSString
        let newText = oldText.replacingCharacters(in: range, with: string) as NSString
        doneBarButton.isEnabled = (newText.length > 0)
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textView.delegate = self
        textView.textColor = UIColor.black
        if let item = itemToEdit {
            title = "Edit Note"
            textView.text = item.noteContent
            textView.textColor = item.textColor
            doneBarButton.isEnabled = true
        }
    }
    
    // Remove keyboard after tapping outside text view.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
