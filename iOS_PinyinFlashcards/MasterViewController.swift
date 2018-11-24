//
//  MasterViewController.swift
//  iOS_PinyinFlashcards
//
//  Created by Michael Norris on 8/5/18.
//  Copyright © 2018 Michael Norris. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [Any]()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = nil
        navigationItem.rightBarButtonItem = nil

        insertAllVocab();
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertAllVocab() {
        objects.insert("Vocab7", at: 0)
        var indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        objects.insert("Vocab6", at: 0)
        indexPath = IndexPath(row: 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        objects.insert("Vocab5", at: 0)
        indexPath = IndexPath(row: 2, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        objects.insert("Vocab4", at: 0)
        indexPath = IndexPath(row: 3, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        objects.insert("Vocab3", at: 0)
        indexPath = IndexPath(row: 4, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        objects.insert("Vocab2", at: 0)
        indexPath = IndexPath(row: 5, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        objects.insert("Vocab1", at: 0)
        indexPath = IndexPath(row: 6, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row] as! String
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.myTitle = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let object = objects[indexPath.row] as! String
        cell.textLabel!.text = object.description
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

