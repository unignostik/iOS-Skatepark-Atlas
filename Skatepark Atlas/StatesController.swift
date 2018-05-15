//
//  StatesController.swift
//  Skatepark Atlas
//
//  Created by Chase Tillar on 12/31/17.
//  Copyright © 2017 Chase Tillar. All rights reserved.
//

import UIKit

class StatesController: UITableViewController {
    
    var states = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        states = statesCSVtoArray()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return states.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "states", for: indexPath)
        cell.textLabel?.text = states[indexPath.row]
        return cell
    }
    
    // MARK: - User Instances
    
    //grab states.csv data and return String array
    func statesCSVtoArray() -> [String] {
        //assigning array
        let rows = [String]()
        //get the file
        guard let file = Bundle.main.path(forResource: "states", ofType: "csv") else {return rows}
        //if able, assign and return array
        do {
            let statesData = try String(contentsOfFile: file, encoding: String.Encoding.utf8)
            let statesArray = statesData.components(separatedBy: "\n")
            return statesArray
        } catch {
            print("Error Reading File")
        }
        return rows
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //get selected row
        if let indexPath = tableView.indexPathForSelectedRow{
            //pass relevant data
            if let destination = segue.destination as? CitiesController {
            destination.selectedState = states[indexPath.row]
            }
        }
    }
}
