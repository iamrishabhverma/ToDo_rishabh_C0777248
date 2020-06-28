//
//  EditNotesViewController.swift
//  todo_rishabh_777248
//
//  Created by Rishabh Verma on 2020-06-26.
//  Copyright © 2020 Rishabh Verma. All rights reserved.
//

import UIKit
import CoreData
import MapKit
import AVFoundation

class EditNotesViewController: UIViewController,  UINavigationControllerDelegate, UIImagePickerControllerDelegate, CLLocationManagerDelegate{
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var txttitle: UITextField!
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var deadlineDate: UIDatePicker!
    
    
    var latitudeString:String = ""
          var longitudeString:String = ""
    // MARK: -- variables
          var note:Note!
          var notebook : Notebook?
          var userIsEditing = true
         var old = true
    // MARK: -- database
        var context:NSManagedObjectContext!
        
  

    
    
    
    override func viewDidLoad() {
    super.viewDidLoad()
    
    
    // playlbl.isEnabled = old
          guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
          context = appDelegate.persistentContainer.viewContext
          
          if (userIsEditing == true) {
              print("Editing an existing note")
              txttitle.text = note.title!
              textView.text = note.text!
    
          }
          else {
              print("Going to add a new note to: \(notebook!.name!)")
              textView.text = ""
           //   btnloc.isHidden = true
          }
         // determineMyCurrentLocation()
          

          // Do any additional setup after loading the view.
    }
    
    
      
         
      
    @IBAction func datechanged(_ sender: Any) {
        let dateFormatter = DateFormatter()

        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short

        let strDate = dateFormatter.string(from: deadlineDate.date)
       dateLabel.text = strDate
    }
    
    
    
    @IBAction func savenotes(_ sender: UIBarButtonItem) {
        
        
//                    // determineMyCurrentLocation()
//                     if (textView.text!.isEmpty) {
//                         print("Please enter some text")
//                         return
//                     }
                     
                     
                     if (userIsEditing == true) {
                         note.text = textView.text!
                     }
                     else {
                         
                         // create a new note in the notebook
                         self.note = Note(context:context)
                         note.setValue(Date(), forKey:"dateAdded")
                         if (txttitle.text!.isEmpty) {
                             note.title = "No Title"
                         }
                         else{
                             note.title = txttitle.text!
                         }
                         
                        
                        // Store value using User Defaults
                        let Date = deadlineDate.date
                        UserDefaults.standard.set(Date, forKey: "currentdate")

                        // Retrieve Value using User Defaults
                        if let date = UserDefaults.standard.object(forKey: "currentdate") as? NSDate {
                           deadlineDate.setDate(date as Date, animated: true)
                            
                                }
                        note.text = textView.text!
                         note.notebook = self.notebook
                     }
                     
                     do {
                         try context.save()
                         print("Note Saved!")
                         
                         
                         // show an alert box
                         let alertBox = UIAlertController(title: "Saved!", message: "Save Successful.", preferredStyle: .alert)
                         alertBox.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                         self.present(alertBox, animated: true, completion: nil)
                     }
                     catch {
                         print("Error saving note in Edit Note screen")
                         
                         // show an alert box with an error message
                         let alertBox = UIAlertController(title: "Error", message: "Error while saving.", preferredStyle: .alert)
                         alertBox.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                         self.present(alertBox, animated: true, completion: nil)
                     }
                     
                     if (userIsEditing == false) {
                         self.navigationController?.popViewController(animated: true)
                         //self.dismiss(animated: true, completion: nil)
                     }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

