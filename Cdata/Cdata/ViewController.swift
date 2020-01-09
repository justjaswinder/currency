//
//  ViewController.swift
//  Cdata
//
//  Created by MacStudent on 2020-01-08.
//  Copyright © 2020 MacStudent. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UISearchBarDelegate,DefaultChangeControllerDelegate {
    func detailController(_ controller: DetailController, didFinishAdding person: Person, name: String, age: Int, tution: Double, startDate: Date) {
          // print("rate changed== \(changedRate)")
        //
        self.appdelegate.updateRecord(person: person, name:  name, age: age, tution: tution, startDate: startDate)
                              self.fetchAndUpdateTable()
        //           //   defaultText.text = changedRate
        //            //  resultLabel.text = "see result here"
                     navigationController?.popViewController(animated:true)
    }
    
    
    
//    func detailController(_ controller: DetailController, didFinishAdding changedRate: String) {
//        print("rate changed== \(changedRate)")
//
//            self.appdelegate.updateRecord(person: person, name: name!, address: addres!)
//                      self.fetchAndUpdateTable()
//           //   defaultText.text = changedRate
//            //  resultLabel.text = "see result here"
//              navigationController?.popViewController(animated:true)
//    }
    

    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var serachBar: UISearchBar!
    
    var perArray = [Person]()
    
       var filterArray = [Person]()
    
    @IBAction func addNewData(_ sender: Any) {
        
        
    }
    @IBOutlet weak var tableView: UITableView!
    @IBAction func add(_ sender: Any) {
        
        var nameTxt: UITextField?
        var addressTxt: UITextField?
        
        let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: .alert)
        
        
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void  in
            
            let name = nameTxt?.text
            let addres = addressTxt?.text
            
            if (name != nil && addres != nil){
                
                let dateFormatter = DateFormatter()
                                                        dateFormatter.dateStyle = .long
                                                        dateFormatter.timeStyle = .none
                                                        
                self.appdelegate.insertRecord(name: name!, age:22, tution:2000.2, startDate:NSDate() as Date)
                self.fetchAndUpdateTable()
            }
        })
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { (action) -> Void  in
                  
             print("cancel")
              })
            alert.addAction(ok)
            alert.addAction(cancel)
            
        alert.addTextField { (textField) in
           nameTxt = textField
            nameTxt?.placeholder = "add name"
        }
        alert.addTextField { (textField) in
                addressTxt = textField
                 addressTxt?.placeholder = "add address"
             }
        self.present(alert, animated: true, completion: nil)
    }
    func fetchAndUpdateTable(){
        perArray = appdelegate.fetchRecords()
        filterArray = perArray
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        serachBar.delegate = self
        filterArray = perArray
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
fetchAndUpdateTable()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterArray = searchText.isEmpty ? perArray : perArray.filter({ (personString: Person) -> Bool in
            
            return personString.name?.range(of: searchText, options:  .caseInsensitive) != nil
        })
        tableView.reloadData()
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   
        
        if segue.identifier == "detailSegue" {
               
            
//                 let controller1 = segue.destination
//                     as! DetailController
//controller1.delegateDF = self//
            if let indexPath = self.tableView.indexPathForSelectedRow{
                let destination = segue.destination as! DetailController
                  destination.delegateDF = self
                destination.itemToEdit = filterArray[indexPath.row].name
                        destination.itemToEditAge = String(filterArray[indexPath.row].age)
                        destination.itemToEditTution = String(filterArray[indexPath.row].tution)
                     let dateFormatter = DateFormatter()
                        dateFormatter.dateStyle = .long
                        dateFormatter.timeStyle = .none
                        
                        
                destination.itemToEditDate = dateFormatter.string(from:filterArray[indexPath.row].startDate!)
                //dateFormatter.date(from: <#T##String#>)
                destination.person = filterArray[indexPath.row]
                
            }
         //   controller1.itemToEdit = defaultText.text!
        }
    }
}
extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CustomCell
        let person = filterArray[indexPath.row]
        cell?.nameTxt?.text = person.name!
        cell?.ageTxt?.text = String(person.age)
       
        cell?.tutionTxt?.text = String(person.tution)
        
        let dateFormatter = DateFormatter()
           dateFormatter.dateStyle = .long
           dateFormatter.timeStyle = .none
           
   cell?.startDateTxt?.text = dateFormatter.string(from:person.startDate!)
           
      

        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     
        if editingStyle == .delete{
            let person = perArray[indexPath.row]
            appdelegate.deleteRecord(person: person)
            fetchAndUpdateTable()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if let _ = tableView.cellForRow(at: indexPath as! IndexPath){
          //  self.performSegue(withIdentifier: "detailSegue", sender: self)
        }
//        let person = perArray[indexPath.row]
//
//        var nameTxt: UITextField?
//        var addressTxt: UITextField?
//
//        let alert = UIAlertController(title: "Alert", message: "update", preferredStyle: .alert)
//
//
//
//        let ok = UIAlertAction(title: "update", style: .default, handler: { (action) -> Void  in
//
//            let name = nameTxt?.text
//            let addres = addressTxt?.text
//
//            if (name != nil && addres != nil){
//                self.appdelegate.updateRecord(person: person, name: name!, address: addres!)
//                self.fetchAndUpdateTable()
//            }
//        })
//        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { (action) -> Void  in
//
//             print("cancel")
//              })
//            alert.addAction(ok)
//            alert.addAction(cancel)
//
//        alert.addTextField { (textField) in
//           nameTxt = textField
//            nameTxt?.placeholder = "add name"
//            nameTxt?.text = person.name
//        }
//        alert.addTextField { (textField) in
//                addressTxt = textField
//                 addressTxt?.placeholder = "add address"
//            addressTxt?.text = person.address
//             }
//        self.present(alert, animated: true, completion: nil)
        
        
        
    }
     
}
