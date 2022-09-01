//
//  ViewController.swift
//  rs.ios.stage-task10
//
//  Created by Albert Zhloba on 27.08.21.
//

import UIKit

class ViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    static var gamersArray = [
        ["Kate", "John", "Betty"],
        ["Add player"]
    ]
    
    var heightTable = NSLayoutConstraint()
    
    lazy var scrollView: UIScrollView = {
           let scroll = UIScrollView()
           scroll.translatesAutoresizingMaskIntoConstraints = false
           //scroll.delegate = self
           
           return scroll
       }()
        
    fileprivate let titleHeader:UILabel = {
        let tl = UILabel()
        tl.text = "Game Counter"
        tl.translatesAutoresizingMaskIntoConstraints = false
        tl.textAlignment = .left
        tl.textColor = .white
        tl.font = UIFont(name: "Nunito-ExtraBold", size: 36)
        tl.numberOfLines = 0
        tl.lineBreakMode = .byClipping
        
        return tl
    }()
    
    fileprivate let tableViewGamers:UITableView = {
        let tvg = UITableView(frame: CGRect.zero, style: .plain)
        tvg.layer.cornerRadius = 15
        tvg.backgroundColor = UIColor(red: 0.231, green: 0.231, blue: 0.231, alpha: 1)
        tvg.translatesAutoresizingMaskIntoConstraints = false
        
        return tvg
    }()
    
    fileprivate let button: UIButton = {
        let bt = UIButton()
        
        bt.setTitle("Start game", for: .normal)
        bt.setTitleColor(UIColor.white, for: .normal)
        bt.titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 24)
        bt.titleLabel?.textAlignment = .center
        bt.titleLabel?.layer.shadowColor = UIColor(red: 0.329, green: 0.471, blue: 0.435, alpha: 1).cgColor
        bt.titleLabel?.layer.shadowOffset = CGSize(width: 0, height: 2)
        bt.titleLabel?.layer.shadowRadius = 0
        bt.titleLabel?.layer.shadowOpacity = 1
            
        bt.backgroundColor = UIColor(red: 0.518, green: 0.722, blue: 0.678, alpha: 1)
        //bt.titleEdgeInsets = UIEdgeInsets(top: 0, left: 2, bottom: 6, right: 0)
        bt.translatesAutoresizingMaskIntoConstraints = false
        //bt.layer.borderWidth = 1
        bt.layer.cornerRadius = 33
        //bt.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        
        bt.layer.shadowColor = UIColor(red: 0.33, green: 0.47, blue: 0.44, alpha: 1.00).cgColor
        bt.layer.shadowRadius = 0.0
        bt.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        bt.layer.shadowOpacity = 1.0
        
        bt.clipsToBounds = false
        bt.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

        return bt
    }()
    
    @objc func buttonAction(){
        let gameVC = GameViewController()
        navigationController?.pushViewController(gameVC, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaults.setValue(0, forKey: "viewActive")
        if (defaults.array(forKey: "gamersArraySaved")) != nil {
            ViewController.gamersArray = (defaults.array(forKey: "gamersArraySaved") as? Array)!
        }
        setupView()
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 895)
        
    }
    
    func setupView(){
        view.backgroundColor = UIColor(red: 0.136, green: 0.136, blue: 0.138, alpha: 1)
        view.addSubview(scrollView)
        scrollView.addSubview(titleHeader)
        scrollView.addSubview(tableViewGamers)
        scrollView.addSubview(button)
        
        tableViewGamers.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableViewGamers.dataSource = self
        tableViewGamers.delegate = self
        tableViewGamers.isEditing = true
        tableViewGamers.allowsSelectionDuringEditing = true
        
        setupconstraint()
    }
    
    func setupconstraint(){
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        titleHeader.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 12).isActive = true
        titleHeader.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20).isActive = true
        titleHeader.widthAnchor.constraint(equalToConstant: 243).isActive = true
        titleHeader.heightAnchor.constraint(equalToConstant: 41).isActive = true
        
        tableViewGamers.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 78).isActive = true
        tableViewGamers.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20).isActive = true
        tableViewGamers.widthAnchor.constraint(equalToConstant: 335).isActive = true
        heightTable.isActive = false
        heightTable = tableViewGamers.heightAnchor.constraint(equalToConstant: CGFloat(39 + (54*(ViewController.gamersArray[0].count + 1))))
        heightTable.isActive = true
        
        button.topAnchor.constraint(equalTo: tableViewGamers.bottomAnchor, constant: 128).isActive = true
        button.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20).isActive = true
        button.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 65).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !MyData.gamerName.isEmpty {
            ViewController.gamersArray[0].append(MyData.gamerName)
            defaults.set(ViewController.gamersArray, forKey: "gamersArraySaved")
            defaults.synchronize()
            
            tableViewGamers.reloadData()
            heightTable.isActive = false
            heightTable = tableViewGamers.heightAnchor.constraint(equalToConstant: CGFloat(39 + (54*(ViewController.gamersArray[0].count + 1))))
            heightTable.isActive = true
            
        }
    }
}
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ViewController.gamersArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewController.gamersArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath)
        cell.textLabel?.text = ViewController.gamersArray[indexPath.section][indexPath.row]
        cell.backgroundColor = UIColor(red: 0.231, green: 0.231, blue: 0.231, alpha: 1)
        if indexPath.section == 0 {
            cell.textLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 20)
            cell.textLabel?.textColor = .white
        }
        if indexPath.section == 1 {
            cell.textLabel?.font = UIFont(name: "Nunito-SemiBold", size: 16)
            cell.textLabel?.textColor = UIColor(red: 0.518, green: 0.722, blue: 0.678, alpha: 1)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        if (indexPath.section == 0) {
            return .delete
        }
        else {
            return .insert
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            ViewController.gamersArray[indexPath.section].remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            heightTable.isActive = false
            heightTable = tableViewGamers.heightAnchor.constraint(equalToConstant: CGFloat(39 + (54*(ViewController.gamersArray[0].count + 1))))
            heightTable.isActive = true
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        if (indexPath.section == 0) {
            return true
        }
        else {
            return false
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        let sourceSection = sourceIndexPath.section
        let destSection = proposedDestinationIndexPath.section
        
        if destSection < sourceSection {
            return IndexPath(row: 0, section: sourceSection)
        } else if destSection > sourceSection {
            return IndexPath(row: self.tableView(tableView, numberOfRowsInSection:sourceSection)-1, section: sourceSection)
        }
        
        return proposedDestinationIndexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 1) {
            let addVC = AddPlayerViewController()
            navigationController?.pushViewController(addVC, animated: false)
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if (section == 0) {
            let sectionHeaderView = UIView(frame: CGRect(x: 16, y: 16, width: tableView.frame.size.width, height: 24))
            
            let headerLabel = UILabel(frame: CGRect(x: sectionHeaderView.frame.origin.x, y: sectionHeaderView.frame.origin.y, width: sectionHeaderView.frame.size.width, height: sectionHeaderView.frame.size.height))
            headerLabel.font = UIFont(name: "Nunito-SemiBold", size: 16)
            headerLabel.textColor = UIColor(red: 0.922, green: 0.922, blue: 0.961, alpha: 0.6)
            
            sectionHeaderView.addSubview(headerLabel)
            headerLabel.text = "Players"
            
            return sectionHeaderView
        }
        else { return nil }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {return 40}
        else { return 0 }
    }
    
}
