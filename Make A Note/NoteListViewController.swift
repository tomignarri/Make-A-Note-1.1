import UIKit

class NoteListViewController: UITableViewController, AddNoteViewControllerDelegate, UINavigationControllerDelegate {
    
    var items: [NoteItem]
    
    required init?(coder aDecoder: NSCoder) {
        items = [NoteItem]()
        super.init(coder: aDecoder)
        loadNotelistItems()
    }
    
    // Protocol conforming to addNoteVC.
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
    
    // Update the selected cell after editing or creating a note.
    func addNoteViewController(_ controller: AddNoteViewController, didFinishEditing item: NoteItem) {
        
        // This function only runs if the cell selected is a part of the array.
        if let index = items.index(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(for: cell, with: item)
            }
        }
        dismiss(animated: true, completion: nil)
        saveNotelistItems()
    }
    
    // Segue to AddNoteVC with or without data that already exists in selected cell(addNote or editNote).
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddNote" {
            let navigationController = segue.destination as! UINavigationController
            
            // The "top view" is the active controller in the nav controller.
            let controller = navigationController.topViewController as! AddNoteViewController
            controller.delegate = self
        } else if segue.identifier == "EditNote" {
                let navigationController = segue.destination as! UINavigationController
                let controller = navigationController.topViewController as! AddNoteViewController
                controller.delegate = self
                if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                    controller.itemToEdit = items[indexPath.row]
                }
            }
    }
    
    // Create rows based on size of items array.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    // Populate rows in NoteListVC table based on NoteItem content.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteItem", for: indexPath)
        let item = items[indexPath.row] //asks for the object that corresponds to the row number
        configureText(for: cell, with: item)
        return cell
    }
    
    // Apply the information in the note item to the individual cell in NoteListVC table.
    func configureText(for cell: UITableViewCell, with item: NoteItem) {
        let label = cell.viewWithTag(1) as! UILabel
        label.text = item.noteContent
    }
    
    // Delete a cell.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        items.remove(at: indexPath.row)
        let indexPaths = [indexPath] //use a single object array becasue delete rows and insert rows require an array
        tableView.deleteRows(at: indexPaths, with: .automatic)
        saveNotelistItems()
    }
    
    // Prevent selected cell from remaining selected when returning to NoteListVC.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Functions to save data in directory.
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
    
    // Functions to load data from directory.
    func loadNotelistItems() {
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path) {
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            items = unarchiver.decodeObject(forKey: "NotelistItems") as! [NoteItem]
            unarchiver.finishDecoding()
        }
    }
}
