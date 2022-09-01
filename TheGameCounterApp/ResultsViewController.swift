//
//  ResultsViewController.swift
//  rs.ios.stage-task10
//
//  Created by Albert Zhloba on 31.08.21.
//

import UIKit

class ResultsViewController: UIViewController {
    
    var sortedUsers = GameViewController.redoArray.sorted {
        $0.3.localizedStandardCompare($1.3) == .orderedDescending
    }
    var sortedUsersUnique: [(IndexPath, String, String, String, String)] = []
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        //scroll.delegate = self
        
        return scroll
    }()
    
    fileprivate let titleHeaderResults:UILabel = {
        let tl = UILabel()
        tl.text = "Results"
        tl.translatesAutoresizingMaskIntoConstraints = false
        tl.textAlignment = .left
        tl.textColor = .white
        tl.font = UIFont(name: "Nunito-ExtraBold", size: 36)
        tl.numberOfLines = 0
        tl.lineBreakMode = .byClipping
        
        return tl
    }()
    
    lazy var tableViewGamersResults:UITableView = {
        let tvg = UITableView(frame: CGRect.zero, style: .plain)
        tvg.backgroundColor = UIColor(red: 0.136, green: 0.136, blue: 0.138, alpha: 1)
        tvg.isScrollEnabled = false
        tvg.translatesAutoresizingMaskIntoConstraints = false
        tvg.dataSource = self
        tvg.delegate = self
        tvg.separatorStyle = .none
        
        return tvg
    }()
    
    lazy var tableViewGamersResults2:UITableView = {
        let tvg = UITableView(frame: CGRect.zero, style: .plain)
        tvg.layer.cornerRadius = 15
        tvg.backgroundColor = UIColor(red: 0.231, green: 0.231, blue: 0.231, alpha: 1)
        tvg.isScrollEnabled = false
        tvg.translatesAutoresizingMaskIntoConstraints = false
        tvg.dataSource = self
        tvg.delegate = self
        
        return tvg
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for (indexx, item) in sortedUsers.enumerated() {
            if !sortedUsersUnique.contains(where: {$0.0 == sortedUsers[indexx].0 }){
                sortedUsersUnique.append(item)
            }
        }
        
        if sortedUsersUnique.count < ViewController.gamersArray[0].count {
            for (index, item) in ViewController.gamersArray[0].enumerated(){
                if !sortedUsersUnique.contains(where: {$0.0[1] == index }){
                    sortedUsersUnique.append(([0,index], "0", "0", "0", item.uppercased()))
                }
            }
        }
        
        setupView()
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 895)
    }
    
    func setupView(){
        view.backgroundColor = UIColor(red: 0.136, green: 0.136, blue: 0.138, alpha: 1)
        view.addSubview(scrollView)
        scrollView.addSubview(titleHeaderResults)
        scrollView.addSubview(tableViewGamersResults)
        scrollView.addSubview(tableViewGamersResults2)
        
        let backButton = UIBarButtonItem(title: "New Game", style: .plain, target: self, action: #selector(newgameTapped))
        backButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Nunito-ExtraBold", size: 17)!], for: .normal)
        navigationItem.leftBarButtonItem = backButton
        
        let addButton = UIBarButtonItem(title: "Resume", style: .plain, target: self, action: #selector(resumeTapped))
        addButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Nunito-ExtraBold", size: 17)!], for: .normal)
        navigationItem.rightBarButtonItem = addButton
        
       setupconstraint()
    }
    
    func setupconstraint(){
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        titleHeaderResults.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 12).isActive = true
        titleHeaderResults.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20).isActive = true
        titleHeaderResults.widthAnchor.constraint(equalToConstant: 126).isActive = true
        titleHeaderResults.heightAnchor.constraint(equalToConstant: 41).isActive = true
        
        tableViewGamersResults.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 71).isActive = true
        tableViewGamersResults.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20).isActive = true
        tableViewGamersResults.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        tableViewGamersResults.heightAnchor.constraint(equalToConstant: CGFloat((15*(ViewController.gamersArray[0].count - 1)) + (41*ViewController.gamersArray[0].count))).isActive = true
        
        tableViewGamersResults2.topAnchor.constraint(equalTo: tableViewGamersResults.bottomAnchor, constant: 25).isActive = true
        tableViewGamersResults2.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20).isActive = true
        tableViewGamersResults2.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        tableViewGamersResults2.heightAnchor.constraint(equalToConstant: CGFloat(39 + (54*GameViewController.redoArray.count))).isActive = true
        
    }
    
    @objc func newgameTapped(){
        let newGameVC = ViewController()
        newGameVC.modalPresentationStyle = .overCurrentContext
        newGameVC.modalTransitionStyle = .flipHorizontal
        let backButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTapped))
        backButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Nunito-ExtraBold", size: 17)!], for: .normal)
        newGameVC.navigationItem.leftBarButtonItem = backButton
        let nav = UINavigationController(rootViewController: newGameVC)
        nav.navigationBar.barTintColor = UIColor(red: 0.137, green: 0.137, blue: 0.137, alpha: 1)
        self.present(nav, animated: true, completion: nil)
    }
    
    @objc func resumeTapped(){
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func cancelTapped(){
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension ResultsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewGamersResults {
            return sortedUsersUnique.count
        }
        else {return GameViewController.redoArray.count}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableViewGamersResults {
            var cell = tableView.dequeueReusableCell(withIdentifier:"cell2")
            if (!(cell != nil)) {
                cell = UITableViewCell(style: .value1, reuseIdentifier: "cell2")
            }
            let string = "#\(indexPath.row + 1)  " + sortedUsersUnique[indexPath.row].4.capitalized
            let myMutableString = NSMutableAttributedString(string: string, attributes: [.font:UIFont(name: "Nunito-ExtraBold", size: 28)!, .foregroundColor: UIColor(red: 0.922, green: 0.682, blue: 0.408, alpha: 1)])
            myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0,length:2))
            cell?.textLabel?.attributedText = myMutableString
            cell?.detailTextLabel?.text = sortedUsersUnique[indexPath.row].3
            cell?.backgroundColor = UIColor(red: 0.136, green: 0.136, blue: 0.138, alpha: 1)
            cell?.detailTextLabel?.font =  UIFont(name: "Nunito-ExtraBold", size: 28)
            cell?.detailTextLabel?.textColor = .white
            return cell!
        } else {
            var cell = tableView.dequeueReusableCell(withIdentifier:"cell3")
            if (!(cell != nil)) {
                cell = UITableViewCell(style: .value1, reuseIdentifier: "cell3")
            }
            
            cell?.textLabel?.text = GameViewController.redoArray[indexPath.row].4.capitalized
            cell?.detailTextLabel?.text = GameViewController.redoArray[indexPath.row].2
            
            cell?.backgroundColor = UIColor(red: 0.231, green: 0.231, blue: 0.231, alpha: 1)
            cell?.textLabel?.font =  UIFont(name: "Nunito-ExtraBold", size: 20)
            cell?.textLabel?.textColor = .white
            cell?.detailTextLabel?.font =  UIFont(name: "Nunito-ExtraBold", size: 28)
            cell?.detailTextLabel?.textColor = .white
            
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tableViewGamersResults {return 56}
        return 54
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if (section == 0) && (tableView == tableViewGamersResults2) {
            let sectionHeaderView = UIView(frame: CGRect(x: 16, y: 16, width: tableView.frame.size.width, height: 24))
            
            let headerLabel = UILabel(frame: CGRect(x: sectionHeaderView.frame.origin.x, y: sectionHeaderView.frame.origin.y, width: sectionHeaderView.frame.size.width, height: sectionHeaderView.frame.size.height))
            headerLabel.font = UIFont(name: "Nunito-SemiBold", size: 16)
            headerLabel.textColor = UIColor(red: 0.922, green: 0.922, blue: 0.961, alpha: 0.6)
            
            sectionHeaderView.addSubview(headerLabel)
            headerLabel.text = "Turns"
            
            return sectionHeaderView
        }
        else { return nil }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) && (tableView == tableViewGamersResults2) {return 40}
        else { return 0 }
    }
    
}

