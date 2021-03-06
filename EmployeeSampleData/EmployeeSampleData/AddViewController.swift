//
//  AddViewController.swift
//  EmployeeSampleData
//
//  Created by rakshitha on 05/09/18.
//  Copyright © 2018 rakshitha. All rights reserved.
//

import UIKit
import CoreData

class AddViewController: UIViewController{
     @IBOutlet weak var empsalary: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var empaddress: UITextField!
    @IBOutlet weak var empname: UITextField!
    @IBOutlet weak var empid: UITextField!
     let item = ["ios","android"]
    var selectedDep:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.empid.becomeFirstResponder()
       
        
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func displayAlert(myTitle:String,myMessage:String)
    {
        
        let alert = UIAlertController(title:myTitle, message: myMessage, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        print(myTitle)
       
    }


    @IBAction func insertButtonClicked(_ sender: Any) {
        let context = managedObjectContext()
        let entity = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context) as! Employee
        entity.name = empname.text
        entity.empId = Int16((self.empid.text! as NSString).integerValue)
        entity.salary = Int16((empsalary.text! as NSString).integerValue)
        entity.address = empaddress.text
        entity.worksFor = DepartmentDataBase.dep.getid(depname: selectedDep!)
        do {
            if (empname.text?.isEmpty)! || empid.text?.count==0 || empsalary.text?.count==0 || (empaddress.text?.isEmpty)!{
                displayAlert(myTitle: "Error", myMessage: "Fields Missing")
                
            }
            
            else
            {
              try context.save()
               print("added")
            displayAlert(myTitle: "Success", myMessage: "User Registered")
                print(entity)
        }
   }
        catch  {
          displayAlert(myTitle: "Error", myMessage: "Failed to insert")
        }
        empaddress.text=""
        empsalary.text=""
        empid.text=""
        empname.text=""
    }

    func managedObjectContext() -> NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
   
    }



extension AddViewController: UIPickerViewDelegate,UIPickerViewDataSource{
   
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return item[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return item.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedDep = item[row]
    }
}

