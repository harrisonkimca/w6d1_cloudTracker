//
//  MealViewController.swift
//  2w6d1_foodTracker
//
//  Created by Seantastic31 on 30/07/2017.
//  Copyright © 2017 Seantastic31. All rights reserved.
//

import UIKit
import os.log

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var caloriesTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var meal: Meal?
    
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Handle the text field's user input  through delegate callbacks
        nameTextField.delegate = self
        
        // Set up views if editing existing Meal
        if let meal = meal
        {
            navigationItem.title = meal.name
            nameTextField.text = meal.name
            descriptionTextField.text = meal.details
            caloriesTextField.text = String(meal.calories)
            photoImageView.image = meal.photo
            ratingControl.rating = meal.rating
        }
        
        // Enable the Save button only if the text field has a valid Meal name
        updateSaveButtonState()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        // Disable the Save button while editing
        saveButton.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason)
    {
        updateSaveButtonState()
        navigationItem.title = textField.text
        
    }
    
    //MARK: UIImagePickerControllerdelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as?
        UIImage else
        {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info) ")
        }
        photoImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem)
    {
        // Depending on the style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways
        let isPresentingInAddMealMode = presentingViewController is
            UINavigationController
        
        if isPresentingInAddMealMode
        {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController
        {
            owningNavigationController.popViewController(animated: true)
        }
        else
        {
            fatalError("The MealViewController is not inside a navigation controller")
        }
        
    }
    
    
    // This method lets you configure a view controller before it is presented
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button  is pressed
        guard let button = sender as? UIBarButtonItem, button === saveButton else
        {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = nameTextField.text ?? ""
        let details = descriptionTextField.text ?? ""
        let calories = Int(caloriesTextField.text!)
        let photo = photoImageView.image
        let rating = ratingControl.rating
        
        // Set the meal to be passed to MealTableViewController after the unwind segue
        meal = Meal(name: name, details: details, calories: calories!, photo: photo, rating: rating)
    }
    
    
    //MARK: Actions
    @IBAction func selectImageFromPhotoGallery(_ sender: UITapGestureRecognizer)
    {
        nameTextField.resignFirstResponder()
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    //MARK: Private Methods
    private func updateSaveButtonState()
    {
        // Disable the Save button if any of the texts fields are empty
        let nameText = nameTextField.text ?? ""
        let detailsText = descriptionTextField.text ?? ""
        let hasCalories = (caloriesTextField.text != nil) && (Int(caloriesTextField.text!) != nil) && (Int(caloriesTextField.text!)! >= 0)
        saveButton.isEnabled = !nameText.isEmpty && !detailsText.isEmpty && hasCalories
    }
}

