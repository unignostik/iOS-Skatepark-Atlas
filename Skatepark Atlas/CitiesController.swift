//
//  CitiesController.swift
//  Skatepark Atlas
//
//  Created by Chase Tillar on 12/31/17.
//  Copyright © 2017 Chase Tillar. All rights reserved.
//

import UIKit

class CitiesController: UITableViewController {
    
    var cityRows = [String]()
    var selectedState = String() //assigned w StatesController
    
    //set TableView header as selected state
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return selectedState
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityRows = getCitiesforState(state: selectedState)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityRows.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cities", for: indexPath)
        cell.textLabel?.text = cityRows[indexPath.row]
        return cell
    }

    // MARK - User Instances
    
    //get respective cities from cities.csv
    func getCitiesforState(state: String) -> [String] {
        
        var cities = [String]()
        //get the file
        guard let file = Bundle.main.path(forResource: state+"Cities", ofType: "csv") else {return cities}
        do {
            let citiesData = try String(contentsOfFile: file, encoding: String.Encoding.utf8)
            cities = citiesData.components(separatedBy: ",")
            return cities
        } catch {
            print("Error Reading File")
        }
        return cities
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //get selected row
        if let indexPath = tableView.indexPathForSelectedRow{
            //pass relevant data
            if let destination = segue.destination as? ParksPageController {
              destination.selectedCity = cityRows[indexPath.row]
            }
        }
    }
}
