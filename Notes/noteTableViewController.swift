//
//  noteTableViewController.swift
//  Notes
//
//  Created by Asgedom Yohannes on 11/9/18.
//  Copyright © 2018 Asgedom Y. All rights reserved.
//

import UIKit
import CoreData

class noteTableViewController: UITableViewController {
    
    var notes = [Note]()
    var mangedObjectContext: NSManagedObjectContext? {
        return(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        retrieveNotes()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //Styles
        self.tableView.backgroundColor = UIColor(red: 245.0/255.0, green: 79.0/255.0, blue: 80.0/255.0, alpha: 1.0)
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return notes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteTableViewCell", for: indexPath) as! noteTableViewCell

        // Configure the cell...
        let note : Note = notes[indexPath.row]
        cell.configureCell (note: note)
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        tableView.reloadData()
    }
    func retrieveNotes(){
        mangedObjectContext?.perform {
            self.fetchNotesFromCoreData {(notes) in
                if let notes = notes {
                    self.notes = notes
                    self.tableView.reloadData()
                }
            }
        }
    }
    func fetchNotesFromCoreData (completion: @escaping ([Note]?) -> Void){
        mangedObjectContext?.perform {
            var notes = [Note]()
            let request: NSFetchRequest<Note> = Note.fetchRequest()
            
            do {
                notes = try self.mangedObjectContext!.fetch(request)
                completion(notes)
            } catch {
                print("Could not fetching notes from CoreData,\(error.localizedDescription)")
            }
        }
    }
    
}
