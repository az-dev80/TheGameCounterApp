//
//  AddPlayerViewController.swift
//  rs.ios.stage-task10
//
//  Created by Albert Zhloba on 28.08.21.
//

import UIKit

struct MyData{
    static var gamerName: String = ""
}

class AddPlayerViewController: UIViewController, UITextFieldDelegate {
    
    fileprivate let titleHeader:UILabel = {
        let tl = UILabel()
        tl.text = "Add Player"
        tl.translatesAutoresizingMaskIntoConstraints = false
        tl.textAlignment = .left
        tl.textColor = .white
        tl.font = UIFont(name: "Nunito-ExtraBold", size: 36)
        tl.numberOfLines = 0
        tl.lineBreakMode = .byClipping
        
        return tl
    }()
    
    fileprivate let gamerNameInput:UITextField = {
        let gni = UITextField()
        gni.attributedPlaceholder = NSAttributedString(string: "Player Name",
                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.608, green: 0.608, blue: 0.631, alpha: 1), .kern: 0.15])
        gni.translatesAutoresizingMaskIntoConstraints = false
        gni.textAlignment = .left
        gni.font = UIFont(name: "Nunito-ExtraBold", size: 20)
        gni.backgroundColor = UIColor(red: 0.231, green: 0.231, blue: 0.231, alpha: 1)
        gni.textColor = .white
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: 60))
        gni.leftView = paddingView
        gni.leftViewMode = .always
        
        gni.becomeFirstResponder()
        let desiredPosition = gni.beginningOfDocument
        gni.selectedTextRange = gni.textRange(from: desiredPosition, to: desiredPosition)
        
        return gni
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    func setupView(){
        //view.backgroundColor = .black
        view.addSubview(titleHeader)
        view.addSubview(gamerNameInput)
        gamerNameInput.delegate = self
        hideWhenTappedAround()
        
       // navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
        backButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Nunito-ExtraBold", size: 17)!], for: .normal)
        navigationItem.leftBarButtonItem = backButton
        
        let addButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
        addButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Nunito-ExtraBold", size: 17)!], for: .normal)
        navigationItem.rightBarButtonItem = addButton
    
        setupconstraint()
    }
    
    func setupconstraint(){
        
        titleHeader.topAnchor.constraint(equalTo: view.topAnchor, constant: 12).isActive = true
        titleHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        titleHeader.widthAnchor.constraint(equalToConstant: 198).isActive = true
        titleHeader.heightAnchor.constraint(equalToConstant: 41).isActive = true
        
        gamerNameInput.topAnchor.constraint(equalTo: view.topAnchor, constant: 78).isActive = true
        gamerNameInput.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        gamerNameInput.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        gamerNameInput.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    @objc func addTapped() {
        MyData.gamerName = gamerNameInput.text ?? ""
        gamerNameInput.text = nil
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func hideWhenTappedAround() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hide))
        view.addGestureRecognizer(gesture)
    }
    @objc func hide() {
        view.endEditing(true)
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
