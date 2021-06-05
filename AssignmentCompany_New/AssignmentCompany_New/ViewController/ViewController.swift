//
//  ViewController.swift
//  AssignmentCompany_New
//
//  Created by Angelos Staboulis on 5/6/21.
//

import UIKit
import SearchTextField
import SwiftyJSON
import Stevia
class ViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet var txtDescription: UITextField!
    @IBOutlet var txtPrice: UITextField!
    @IBOutlet var txtLocation: SearchTextField!
    @IBOutlet var txtTitle: UITextField!
    @IBOutlet var tableView: UITableView!
    var viewModel:ViewModel!
    @IBOutlet var mainView: UIView!
    @IBOutlet var lblHeader: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    var object:[String:Any]=[:]
    var filter:[String]=[]
    func createJSON(){
        object["title"]=String(txtTitle.text!)
        object["location"]=String(txtLocation.text!)
        object["price"]=String(txtPrice.text!)
        object["description"]=String(txtDescription.text!)
        let json = JSON(arrayLiteral: object)
        debugPrint(json)
    }
    @IBAction func btnSubmit(_ sender: Any) {
        showAlert()
        createJSON()
    }
    func clearFields(){
        txtTitle.text = ""
        txtLocation.text = ""
        txtDescription.text = ""
        txtPrice.text = ""
    }
    @IBAction func btnClear(_ sender: Any) {
        clearFields()
        
    }
    @IBAction func txtLocationEdit(_ sender: Any) {
        let textfield:UITextField = sender as! UITextField
        if textfield.text!.count == 3 {
            viewModel.fetchLocation(input:textfield.text!) { (array) in
                for item in 0..<array.count {
                    self.filter.append(array[item].mainText)
                }
                self.txtLocation.filterStrings(self.filter)
            }
        }
        
    }
    func showAlert(){
        let alert = UIAlertController(title: "Eνημερωτικό Μήνυμα", message: "Το json δημιουργήθηκε και εκτυπώθηκε επιτυχώς στο Output Window", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert.modalPresentationStyle = .fullScreen
        present(alert, animated: true, completion: nil)
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
extension ViewController {
    func setupView(){
        viewModel = ViewModel()
        txtTitle.becomeFirstResponder()
        if UIDevice.current.userInterfaceIdiom == .pad {
            mainView.translatesAutoresizingMaskIntoConstraints = false
            mainView.top(100)
            mainView.centerHorizontally(offset: -200)
            lblHeader.translatesAutoresizingMaskIntoConstraints = false
            lblHeader.centerHorizontally(offset: 200)
            tableView.separatorStyle = .none
            txtLocation.delegate = self
            txtLocation.theme = SearchTextFieldTheme.darkTheme()
            txtLocation.theme.bgColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
            txtLocation.theme.fontColor = .black
            txtLocation.theme.font = UIFont(name: "Arial", size: CGFloat(20))!
        }
        else{
            tableView.separatorStyle = .none
            txtLocation.delegate = self
            txtLocation.theme = SearchTextFieldTheme.darkTheme()
            txtLocation.theme.bgColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
            txtLocation.theme.fontColor = .black
            txtLocation.theme.font = UIFont(name: "Arial", size: CGFloat(20))!
        }
    }
}
