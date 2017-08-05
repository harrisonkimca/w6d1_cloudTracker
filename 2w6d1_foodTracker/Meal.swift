//
//  Meal.swift
//  2w6d1_foodTracker
//
//  Created by Seantastic31 on 31/07/2017.
//  Copyright © 2017 Seantastic31. All rights reserved.
//

// DATA MODEL: STEP 1: Replace Foundation with UIKit (includes Foundation)
import UIKit
// PERSIST DATA: STEP 5: Import unified logging system
//import os.log

// PERSIST DATA: STEP 2: subclass NSObject to conform to NSCoding
//class Meal: NSObject, NSCoding {
    
class Meal: NSObject {
    
    // DATA MODEL: STEP 2: Add object properties (set photo & rating as optionals because will come later)
    //MARK: Properties
    var name: String
    var details: String
    var calories: Int
    var photo: UIImage?
    var rating: Int
    
    //MARK: Archiving Paths (PERSIST DATA: STEP 7: Set archive paths) (GOTO MealTableViewController.swift)
//    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
//    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
    //MARK: Types (PERSIST DATA: STEP 1: Add coding key structure)
//    struct PropertyKey
//    {
//        static let name = "name"
//        static let photo = "photo"
//        static let rating = "rating"
//    }
    
    // DATA MODEL: STEP 3: Declare initializer
    //MARK: Initialization
    init?(name: String, details: String, calories: Int, photo: UIImage?, rating: Int)
    {
        // Initialization should fail if there is no name or if the rating is negative
//        if name.isEmpty || rating < 0
//        {
//            return nil
//        }
        
        // The name must not be empty
//        guard !name.isEmpty else
//        {
//            return nil
//        }
//        
        // The rating must be between 0 and 5 inclusively
//        guard (rating >= 0) && (rating <= 5) else
//        {
//            return nil
//        }
        
        // DATA MODEL: STEP 4: set initial values for properties (GOTO MealViewController)(
        // Initialize stored properties
        self.name = name
        self.details = details
        self.calories = calories
        self.photo = photo
        self.rating = rating
    }
    
    //MARK: NSCoding (PERSIST DATA: STEP 3: Must implement to prepare Class's info to be be archived)
//    func encode(with aCoder: NSCoder)
//    {
//        //PERSIST DATA: STEP 4: Encode data by given type and encode value of each property to store with corresponding key
//        aCoder.encode(name, forKey: PropertyKey.name)
//        aCoder.encode(photo, forKey: PropertyKey.photo)
//        aCoder.encode(rating, forKey: PropertyKey.rating)
//    }
    
    // PERSIST DATA: STEP 6: Must implement as initializer unarchives data when class is created
//    required convenience init?(coder aDecoder: NSCoder)
//    {
//        // The name is required. If we cannot decode a name string, the intializer should fail
//        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else
//        {
//            os_log("Unable to decode the name for Meal object", log: OSLog.default, type: .debug)
//            return nil
//        }
//        
//        // Because photo is an optional property of Meal, just use conditional cast
//        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
//        
//        // Already an Int so no need to cast/unwrap
//        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
//        
//        // Must call designated initializer
//        self.init(name: name, photo: photo, rating: rating)
//    }
    
    
}
