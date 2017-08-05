//
//  MealTableViewController.swift
//  2w6d1_foodTracker
//
//  Created by Seantastic31 on 31/07/2017.
//  Copyright © 2017 Seantastic31. All rights reserved.
//

import UIKit
import os.log

class MealTableViewController: UITableViewController {
    
    //MARK: Properties
    var meals = [Meal]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Use the edit button item provided by the table view controller
        navigationItem.leftBarButtonItem = editButtonItem
        
//        NetworkManager.requestGetArray(path: "/users/me/meals") {(data: [[String: Any]]) in
//            for dict in data {
//                if let title = dict["title"] as? String,
//                    let description = dict["description"] as? String,
//                    let calories = dict["calories"] as? Int {
//                    // Create a meal object, add it to an array
//                    let meal = Meal(name: name, photo: photo, rating: rating);
//                } else {
//                    print("This shouldn't happen")
//                }
//            }
//        }
        
        // PERSIST DATA: STEP 12: check to see if loadMeals returns any new meals and then add to savedMeals array or if not then just load the sample meals
//        if let savedMeals = loadMeals()
//        {
//            meals += savedMeals
//        }
//        else
//        {
//            // PERSIST DATA: STEP 13: Move in loadSampleMeals into the loadMeals check to load samples if no new meals
//            // Load the sample data
//            loadSampleMeals()
//        }
        
        loadSampleMeals()
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
        
        return meals.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier
        let cellIdentifier = "MealTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell else
        {
            fatalError("The dequeued cell is not an instance of MealTableViewCell")
        }
        
        // Fetches the appropriate meal for the data source layout
        let meal = meals[indexPath.row]
        
        // Configure the cell
        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.ratingControl.rating = meal.rating
        
        return cell
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            // Delete the row from the data source
            meals.remove(at: indexPath.row)
            // PERSIST DATA: STEP 11: Save meals after one is deleted
            //saveMeals()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
            
        else if editingStyle == .insert
        {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
        // MARK: - Navigation
    // http://www.thomashanning.com/passing-data-between-view-controllers/
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        super.prepare(for: segue, sender: sender)
        
        switch (segue.identifier ?? "")
        {
        case "AddItem":
            os_log("Adding a new meal", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            guard let mealDetailViewController = segue.destination as? MealViewController else
            {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedMealCell = sender as? MealTableViewCell else
            {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedMealCell) else
            {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedMeal = meals[indexPath.row]
            mealDetailViewController.meal = selectedMeal
            
        default:
            fatalError("Unexpected segue identifier; \(String(describing: segue.identifier))")
        }
    }
    
    // ***** DATA MODEL: STEP 12: Because UNWIND SEGUE need to place action in MealTableViewController so it executes at runtime (HENCE NAMED 'unwindToMealList') ***** 
    
    // *************************************************************************************************
    //
    //  DATA MODEL: STEP 13: TO MAKE THE UNWIND SEGUE WORK GO TO STORYBOARD and ctrl/drag the SAVE button to the EXIT icon in the NAVIGATION BAR and CHOOSE the unwind segue 'unwindToMealList'
    
    //
    //  NOTE: SAVE BUTTON IS ONLY CONNECTED TO THE EXIT ICON IN THE NAVIGATION BAR OF THE MEALVIEWCONTROLLER VS BEING CONNECTED BELOW (UNWIND SEGUE CAN BE SELECTED IN THE NAVIGATION WINDOW OF THE SCENE FOR MEALTABLEVIEWCONTROLLER (AT THE VERY BOTTOM)
    //
    //  ALSO, NO IDENTIFIER USED FOR THE UNWIND SEGUE BECAUSE SOURCEVIEWCONTROLLER IS SET AS THE SENDER (AND DOWNCAST USING THE OPTIONAL TYPE CAST OPERATOR 'as?')
    // *************************************************************************************************
    
    // DATA MODEL: STEP 14: action takes in UIStoryboardSegue as an argument
    //MARK: Actions
    @IBAction func unwindToMealList(sender: UIStoryboardSegue)
    {
        // DATA MODEL: STEP 15: The sourceViewController is set as the sender (ie, the unwind segue activated by pressing the SAVE button) and downcast to a MealViewController using 'as?'
        if let sourceViewController = sender.source as?
            MealViewController, let meal = sourceViewController.meal
        {
            if let selectedIndexPath = tableView.indexPathForSelectedRow
            {
                
                // Update an existing meal
                meals[selectedIndexPath.row] = meal
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else
            {
                // DATA MODEL: STEP 16: If the meal property is not Nil and the sourceViewController is successfully downcast from a UIViewController to a MealViewController allowing it to be set as the sourceViewController then any new meal is given a newIndexPath so the new meal can be inserted into the tableView
                // Add a new meal
                let newIndexPath = IndexPath(row: meals.count, section: 0)
                
                // DATA MODEL: STEP 17: Add new meal to existing list of meals in the data model
                meals.append(meal)
                // DATA MODEL: STEP 18: Animates insertion of new row for new meal into tableView (GOTO MealTableViewController to create a CANCEL button)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            // PERSIST DATA: STEP 10: Save meals after updating or adding new meal
            // Save the meals
            //saveMeals()
        }
    }
    
    //MARK: Private Methods
    private func loadSampleMeals()
    {
        let photo1 = UIImage(named: "meal1")
        let photo2 = UIImage(named: "meal2")
        let photo3 = UIImage(named: "meal3")
        
        guard let meal1 = Meal(name: "Caprese Salad", details: "Fresh and light", calories: 630, photo: photo1, rating: 4) else
        {
            fatalError("Unable to instantiate meal1")
        }
        
        guard let meal2 = Meal(name: "Steak", details: "Thick and juicy", calories: 870, photo: photo2, rating: 5) else
        {
            fatalError("Unable to instantiate meal2")
        }
        
        guard let meal3 = Meal(name: "Hamburger", details: "Big and fat", calories: 725, photo: photo3, rating: 3) else
        {
            fatalError("Unable to instantiate meal3")
        }
        meals += [meal1, meal2, meal3]
    }
    
    // PERSIST DATA: STEP 8: Saves meal and returns true if successful
//    private func saveMeals()
//    {
//        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL.path)
//        
//        if isSuccessfulSave
//        {
//            os_log("Meals successfully saved", log: OSLog.default, type: .debug)
//        }
//        else
//        {
//            os_log("Failed to save meals...", log: OSLog.default, type: .error)
//        }
//    }
    
    // PERSIST DATA: STEP 9: Load meal list to refresh
//    private func loadMeals() -> [Meal]?
//    {
//        return NSKeyedUnarchiver.unarchiveObject(withFile: Meal.ArchiveURL.path) as?
//        [Meal]
//    }
    
    // ************************* STORYBOARD TO CREATE SEPARATE VIEWS FOR 'ADD ITEM' AND 'DETAIL VIEW/EDIT' ***************************
    //
    // STEP 1: MEALTABLEVIEWCONTROLLER (ADD MEAL): Add a navigation bar into the MealTableViewController by embedding a Navigation Controller into MealTableViewController and changing the entry point to the Navigation Controller
    //
    // STEP 2: MEALTABLEVIEWCONTROLLER (ADD MEAL): Double click navigation bar and change title to 'Your Meals'
    //
    // STEP 3: MEALTABLEVIEWCONTROLLER (ADD MEAL): Drag a 'Bar Button Item' to the right side of the navigation bar & change name to '+' in the Attributes Inspector
    //
    // STEP 4: MEALTABLEVIEWCONTROLLER (ADD MEAL): Add action segue by ctrl/dragging from '+' to MealViewController and selecting segue to 'Present Modally' (but no back button)
    //
    // STEP 5: MEALTABLEVIEWCONTROLLER (ADD MEAL): Select the segue and give it an identifier name of 'AddItem' in the attributes inspector
    //
    // STEP 6: MEALVIEWCONTROLLER (ADD MEAL): Switch to the MealViewController and select the Yellow View Controller icon at the top of the scene and embed a Navigation Controller into the modal AddItem view (will add a Navigation Bar at the top of the modal view to maintain visual continuity)
    //
    // STEP 7: MEALVIEWCONTROLLER (ADD MEAL): Double click on the navigation bar of the AddItem View and add 'New Meal' title
    //
    // STEP 8: MEALVIEWCONTROLLER (ADD MEAL): Drag 'Bar Button Item' to the left of the navigation bar and rename to 'Cancel' under 'System Item' in the attributes inspector
    //
    // STEP 9: MEALVIEWCONTROLLER (ADD MEAL): Drag 'Bar Button Item' to the right of the navigation bar and rename to 'Save' under 'System Item' in the attributes inspector
    //
    // ************************* GOTO MEAL.SWIFT TO SET UP THE DATA MODEL ***************************
    
    
    
    
    
    
    
    
    
    
    

}
