//
//  GameViewController.swift
//  rs.ios.stage-task10
//
//  Created by Albert Zhloba on 29.08.21.
//

import UIKit
import Foundation

class GameViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    static var gamersDataForScoreRestoring: [(Int, Int, String, String, String, String)] = []
    var oldValue = "0"
    var scoreAdded = "0"
    var scoreString = "0"
    var labelsArrayMiniBar: [UILabel] = []
    static var indexPathGlobal: IndexPath = []
    static var redoArray: [(IndexPath, String, String, String, String)] = []
    
    var timer: Timer = Timer()
    var count: Int = 0
    var timerCounting: Bool = false
    private let sectionInsets = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 60)

    fileprivate let titleHeader:UILabel = {
        let tl = UILabel()
        tl.text = "Game"
        tl.translatesAutoresizingMaskIntoConstraints = false
        tl.textAlignment = .left
        tl.textColor = .white
        tl.font = UIFont(name: "Nunito-ExtraBold", size: 36)
        tl.numberOfLines = 0
        tl.lineBreakMode = .byClipping
        
        return tl
    }()
    
    fileprivate let button: UIButton = {
        let bt = UIButton()
        
        bt.setImage(UIImage(named: "icon_Dice.png"), for: .normal)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.addTarget(self, action: #selector(rollAction), for: .touchUpInside)

        return bt
    }()
    
    fileprivate let timerLabel:UILabel = {
        let tl = UILabel()
        tl.text = "00:00"
        tl.translatesAutoresizingMaskIntoConstraints = false
        tl.textAlignment = .left
        tl.textColor = UIColor(red: 0.231, green: 0.231, blue: 0.231, alpha: 1)
        tl.font = UIFont(name: "Nunito-ExtraBold", size: 28)
        tl.numberOfLines = 0
        tl.lineBreakMode = .byClipping
        
        return tl
    }()
    
    fileprivate let timerButton: UIButton = {
        let bt = UIButton()
        
        bt.setImage(UIImage(named: "Play.png"), for: .normal)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.addTarget(self, action: #selector(timerButtonAction), for: .touchUpInside)

        return bt
    }()
    
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
       // layout.itemSize = .init(width: 255, height: 300)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(GameCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        return cv
    }()
    
    fileprivate let backCellButton: UIButton = {
        let bt = UIButton()
        
        bt.setImage(UIImage(named: "icon_Next-2.png"), for: .normal)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.addTarget(self, action: #selector(backCellAction), for: .touchUpInside)

        return bt
    }()
    
    fileprivate let nextCellButton: UIButton = {
        let bt = UIButton()
        
        bt.setImage(UIImage(named: "icon_Next.png"), for: .normal)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.addTarget(self, action: #selector(nextCellAction), for: .touchUpInside)

        return bt
    }()
    
    fileprivate let plus1Button: UIButton = {
        let bt = UIButton()
        
        bt.setTitle("+1", for: .normal)
        bt.setTitleColor(UIColor.white, for: .normal)
        bt.backgroundColor = UIColor(red: 0.518, green: 0.722, blue: 0.678, alpha: 1)
        bt.layer.cornerRadius = 39
        bt.tag = 1
        bt.titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 40)
        bt.titleLabel?.textAlignment = .center
        bt.titleLabel?.layer.shadowColor = UIColor(red: 0.329, green: 0.471, blue: 0.435, alpha: 1).cgColor
        bt.titleLabel?.layer.shadowOffset = CGSize(width: 0, height: 2)
        bt.titleLabel?.layer.shadowRadius = 0
        bt.titleLabel?.layer.shadowOpacity = 1
        
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.addTarget(self, action: #selector(plusMinusAction), for: .touchUpInside)

        return bt
    }()
    
    fileprivate let minus10Button: UIButton = {
        let bt = UIButton()
        
        bt.setTitle("-10", for: .normal)
        bt.setTitleColor(UIColor.white, for: .normal)
        bt.backgroundColor = UIColor(red: 0.518, green: 0.722, blue: 0.678, alpha: 1)
        bt.layer.cornerRadius = 23
        bt.tag = 2
        bt.titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 20)
        bt.titleLabel?.textAlignment = .center
        bt.titleLabel?.layer.shadowColor = UIColor(red: 0.329, green: 0.471, blue: 0.435, alpha: 1).cgColor
        bt.titleLabel?.layer.shadowOffset = CGSize(width: 0, height: 2)
        bt.titleLabel?.layer.shadowRadius = 0
        bt.titleLabel?.layer.shadowOpacity = 1
        
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.addTarget(self, action: #selector(plusMinusAction), for: .touchUpInside)

        return bt
    }()
    
    fileprivate let minus5Button: UIButton = {
        let bt = UIButton()
        
        bt.setTitle("-5", for: .normal)
        bt.setTitleColor(UIColor.white, for: .normal)
        bt.backgroundColor = UIColor(red: 0.518, green: 0.722, blue: 0.678, alpha: 1)
        bt.layer.cornerRadius = 23
        bt.tag = 3
        bt.titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 20)
        bt.titleLabel?.textAlignment = .center
        bt.titleLabel?.layer.shadowColor = UIColor(red: 0.329, green: 0.471, blue: 0.435, alpha: 1).cgColor
        bt.titleLabel?.layer.shadowOffset = CGSize(width: 0, height: 2)
        bt.titleLabel?.layer.shadowRadius = 0
        bt.titleLabel?.layer.shadowOpacity = 1
        
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.addTarget(self, action: #selector(plusMinusAction), for: .touchUpInside)

        return bt
    }()
    
    fileprivate let minus1Button: UIButton = {
        let bt = UIButton()
        
        bt.setTitle("-1", for: .normal)
        bt.setTitleColor(UIColor.white, for: .normal)
        bt.backgroundColor = UIColor(red: 0.518, green: 0.722, blue: 0.678, alpha: 1)
        bt.layer.cornerRadius = 23
        bt.tag = 4
        bt.titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 20)
        bt.titleLabel?.textAlignment = .center
        bt.titleLabel?.layer.shadowColor = UIColor(red: 0.329, green: 0.471, blue: 0.435, alpha: 1).cgColor
        bt.titleLabel?.layer.shadowOffset = CGSize(width: 0, height: 2)
        bt.titleLabel?.layer.shadowRadius = 0
        bt.titleLabel?.layer.shadowOpacity = 1
        
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.addTarget(self, action: #selector(plusMinusAction), for: .touchUpInside)

        return bt
    }()
    
    fileprivate let plus5Button: UIButton = {
        let bt = UIButton()
        
        bt.setTitle("+5", for: .normal)
        bt.setTitleColor(UIColor.white, for: .normal)
        bt.backgroundColor = UIColor(red: 0.518, green: 0.722, blue: 0.678, alpha: 1)
        bt.layer.cornerRadius = 23
        bt.tag = 5
        bt.titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 20)
        bt.titleLabel?.textAlignment = .center
        bt.titleLabel?.layer.shadowColor = UIColor(red: 0.329, green: 0.471, blue: 0.435, alpha: 1).cgColor
        bt.titleLabel?.layer.shadowOffset = CGSize(width: 0, height: 2)
        bt.titleLabel?.layer.shadowRadius = 0
        bt.titleLabel?.layer.shadowOpacity = 1
        
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.addTarget(self, action: #selector(plusMinusAction), for: .touchUpInside)

        return bt
    }()
    
    fileprivate let plus10Button: UIButton = {
        let bt = UIButton()
        
        bt.setTitle("+10", for: .normal)
        bt.setTitleColor(UIColor.white, for: .normal)
        bt.backgroundColor = UIColor(red: 0.518, green: 0.722, blue: 0.678, alpha: 1)
        bt.layer.cornerRadius = 23
        bt.tag = 6
        bt.titleLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 20)
        bt.titleLabel?.textAlignment = .center
        bt.titleLabel?.layer.shadowColor = UIColor(red: 0.329, green: 0.471, blue: 0.435, alpha: 1).cgColor
        bt.titleLabel?.layer.shadowOffset = CGSize(width: 0, height: 2)
        bt.titleLabel?.layer.shadowRadius = 0
        bt.titleLabel?.layer.shadowOpacity = 1
        
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.addTarget(self, action: #selector(plusMinusAction), for: .touchUpInside)

        return bt
    }()
    
    fileprivate let undoButton: UIButton = {
        let bt = UIButton()
        
        bt.setImage(UIImage(named: "Vector.png"), for: .normal)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.addTarget(self, action: #selector(undoAction), for: .touchUpInside)

        return bt
    }()
    
    let mStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaults.setValue(1, forKey: "viewActive")
        defaults.synchronize()
        
        if (defaults.array(forKey: "gamersArraySaved")) != nil {
            ViewController.gamersArray = (defaults.array(forKey: "gamersArraySaved") as? Array)!
        }
        if (defaults.array(forKey: "redoArraySaved")) != nil {
            let encodedArray = defaults.array(forKey: "redoArraySaved") as! [Dictionary<String, Any>]
            
            var arrofarr: [(Int,Int, String, String, String, String)] = []
            
            arrofarr = encodedArray.compactMap{ ($0["0"], $0["1"], $0["2"], $0["3"], $0["4"], $0["5"]) as? (Int, Int, String, String, String, String)  }
         
            GameViewController.redoArray = arrofarr.map { (IndexPath(row: $0.1, section: $0.0), $0.2, $0.3, $0.4, $0.5)  }
            arrofarr = arrofarr.sorted{
                $0.4.localizedStandardCompare($1.4) == .orderedDescending
            }

            var sortedUsersUnique: [(Int, Int, String, String, String, String)] = []
            
            for (indexx, item) in arrofarr.enumerated() {
                if !sortedUsersUnique.contains(where: {$0.1 == arrofarr[indexx].1 }){
                    sortedUsersUnique.append(item)
                }
            }

            if sortedUsersUnique.count < ViewController.gamersArray[0].count {
                for (index, item) in ViewController.gamersArray[0].enumerated(){
                    if !sortedUsersUnique.contains(where: {$0.1 == index }){
                        sortedUsersUnique.append((0,index, "0", "0", "0", item.uppercased()))
                    }
                }
            }
            GameViewController.gamersDataForScoreRestoring = sortedUsersUnique.sorted {
                $0.1 < $1.1
            }
        }
        
        setupView()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        print(GameViewController.redoArray)
        if (defaults.array(forKey: "redoArraySaved")) != nil {
            let nextItem = NSIndexPath(row: (GameViewController.redoArray.last?.0[1] ?? -1) + 1, section: 0)
            if (nextItem.row < ViewController.gamersArray[0].count && nextItem.row >= 0)
            {
                collectionView.scrollToItem(at: nextItem as IndexPath, at: .centeredHorizontally, animated: true)
                backCellButton.setImage(UIImage(named: "icon_Next-2.png"), for: .normal)
                GameViewController.indexPathGlobal = nextItem as IndexPath
                print(GameViewController.indexPathGlobal)
                
                if GameViewController.indexPathGlobal.row == (ViewController.gamersArray[0].count - 1) {
                    nextCellButton.setImage(UIImage(named: "icon_Previous-2.png"), for: .normal)
                }
            }
            if (nextItem.row == ViewController.gamersArray[0].count)
            {
                collectionView.scrollToItem(at: [0,0] as IndexPath, at: .centeredHorizontally, animated: true)
                GameViewController.indexPathGlobal = [0, 0]
                backCellButton.setImage(UIImage(named: "icon_Previous.png"), for: .normal)
                nextCellButton.setImage(UIImage(named: "icon_Next.png"), for: .normal)
            }
            
            var index = 0
            if !GameViewController.indexPathGlobal.isEmpty{
                index = GameViewController.indexPathGlobal[1]
            }
            
            for (idx, label) in labelsArrayMiniBar.enumerated() {
                if idx == index {
                    label.textColor = .white
                }
                else {
                    label.textColor = UIColor(red: 0.231, green: 0.231, blue: 0.231, alpha: 1)
                }
            }
            print(GameViewController.indexPathGlobal)
        }
    }
    
    func setupView(){
        
        view.addSubview(titleHeader)
        view.addSubview(button)
        view.addSubview(timerLabel)
        view.addSubview(timerButton)
        view.addSubview(collectionView)
        view.addSubview(plus1Button)
        view.addSubview(backCellButton)
        view.addSubview(nextCellButton)
        view.addSubview(minus10Button)
        view.addSubview(minus5Button)
        view.addSubview(minus1Button)
        view.addSubview(plus5Button)
        view.addSubview(plus10Button)
        view.addSubview(undoButton)
        
        if GameViewController.redoArray.isEmpty{
            undoButton.isEnabled = false
        }
        view.addSubview(mStackView)
        mStackView.axis  = .horizontal
        mStackView.distribution  = .equalCentering
        mStackView.alignment = .center
        mStackView.spacing = 5
        mStackView.translatesAutoresizingMaskIntoConstraints = false
        
        for (index, gamer) in ViewController.gamersArray[0].enumerated() {
            let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 14, height: 24))
            
            label.text = String(gamer.prefix(1))
            label.tag = index
            label.textColor = UIColor(red: 0.231, green: 0.231, blue: 0.231, alpha: 1)
            label.font = UIFont(name: "Nunito-ExtraBold", size: 20)
            label.translatesAutoresizingMaskIntoConstraints = false
            labelsArrayMiniBar.append(label)
            mStackView.addArrangedSubview(label)
        }
        
        
        let backButton = UIBarButtonItem(title: "New Game", style: .plain, target: self, action: #selector(newgameTapped))
        backButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Nunito-ExtraBold", size: 17)!], for: .normal)
        navigationItem.leftBarButtonItem = backButton
        
        let addButton = UIBarButtonItem(title: "Results", style: .plain, target: self, action: #selector(resultsTapped))
        addButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Nunito-ExtraBold", size: 17)!], for: .normal)
        navigationItem.rightBarButtonItem = addButton
    
        setupconstraint()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor(red: 0.136, green: 0.136, blue: 0.138, alpha: 1)
    }
    
    @objc func rollAction(){
        let rollVC = RollViewController()
        rollVC.modalPresentationStyle = .overCurrentContext
        self.present(rollVC, animated: true, completion: nil)
    }
    
    @objc func backCellAction(){
        
        if GameViewController.indexPathGlobal.isEmpty {
            GameViewController.indexPathGlobal = [0, 0]
        }
        let nextItem = NSIndexPath(row: GameViewController.indexPathGlobal.row - 1, section: 0)
        if (nextItem.row < ViewController.gamersArray[0].count && nextItem.row >= 0)
        {
            collectionView.scrollToItem(at: nextItem as IndexPath, at: .centeredHorizontally, animated: true)
            if GameViewController.indexPathGlobal.row > 0 {
                GameViewController.indexPathGlobal = [0, GameViewController.indexPathGlobal.row - 1]
            }
            nextCellButton.setImage(UIImage(named: "icon_Next.png"), for: .normal)
            if GameViewController.indexPathGlobal.row == 0 {
                backCellButton.setImage(UIImage(named: "icon_Previous.png"), for: .normal)
            }
        }
        let index = GameViewController.indexPathGlobal[1]
        for (idx, label) in labelsArrayMiniBar.enumerated() {
            if idx == index {
                label.textColor = .white
            }
            else {
                label.textColor = UIColor(red: 0.231, green: 0.231, blue: 0.231, alpha: 1)
            }
        }
    }
    
    @objc func nextCellAction(){
        
        if GameViewController.indexPathGlobal.isEmpty {
            GameViewController.indexPathGlobal = [0, 0]
        }
        let nextItem = NSIndexPath(row: GameViewController.indexPathGlobal.row + 1, section: 0)
        if (nextItem.row < ViewController.gamersArray[0].count && nextItem.row >= 0)
        {
            collectionView.scrollToItem(at: nextItem as IndexPath, at: .centeredHorizontally, animated: true)
            backCellButton.setImage(UIImage(named: "icon_Next-2.png"), for: .normal)
            if GameViewController.indexPathGlobal.row < (ViewController.gamersArray[0].count - 1) {
                GameViewController.indexPathGlobal = [0, GameViewController.indexPathGlobal.row + 1]
            }
            if GameViewController.indexPathGlobal.row == (ViewController.gamersArray[0].count - 1) {
                nextCellButton.setImage(UIImage(named: "icon_Previous-2.png"), for: .normal)
            }
        }
        let index = GameViewController.indexPathGlobal[1]
        for (idx, label) in labelsArrayMiniBar.enumerated() {
            if idx == index {
                label.textColor = .white
            }
            else {
                label.textColor = UIColor(red: 0.231, green: 0.231, blue: 0.231, alpha: 1)
            }
        }
    }
    
    @objc func plusMinusAction(sender: UIButton){
        if GameViewController.indexPathGlobal.isEmpty {
            GameViewController.indexPathGlobal = [0, 0]
        }
        
        guard let cell = collectionView.cellForItem(at: GameViewController.indexPathGlobal) as? GameCollectionViewCell else {return}
        
        scoreString = cell.score.text!
        oldValue = cell.score.text!
        
        var scoreInt = Int(scoreString)
        
        if(sender.tag == 1){
            scoreInt = scoreInt! + 1
            scoreAdded = (sender.titleLabel?.text)!
        }
        if(sender.tag == 2){
            scoreInt = scoreInt! - 10
            scoreAdded = (sender.titleLabel?.text)!
        }
        if(sender.tag == 3){
            scoreInt = scoreInt! - 5
            scoreAdded = (sender.titleLabel?.text)!
        }
        if(sender.tag == 4){
            scoreInt = scoreInt! - 1
            scoreAdded = (sender.titleLabel?.text)!
        }
        if(sender.tag == 5){
            scoreInt = scoreInt! + 5
            scoreAdded = (sender.titleLabel?.text)!
        }
        if(sender.tag == 6){
            scoreInt = scoreInt! + 10
            scoreAdded = (sender.titleLabel?.text)!
        }
        
        //print(scoreInt!)
        if let sss = scoreInt {
            scoreString = "\(sss)"
        }
        if let xxx = Int(scoreString) {
            cell.score.text = "\(xxx)"
        }
        
        GameViewController.redoArray.append((GameViewController.indexPathGlobal, oldValue, scoreAdded, scoreString, cell.label.text!))
        
        if GameViewController.gamersDataForScoreRestoring.count >= ViewController.gamersArray.count {
            GameViewController.gamersDataForScoreRestoring.remove(at: GameViewController.indexPathGlobal[1])
            GameViewController.gamersDataForScoreRestoring.insert((GameViewController.indexPathGlobal[0], GameViewController.indexPathGlobal[1], oldValue, scoreAdded, scoreString, cell.label.text!), at: GameViewController.indexPathGlobal[1])
        }
        
        if !GameViewController.redoArray.isEmpty{
            undoButton.isEnabled = true
        }
        
        let nextItem = NSIndexPath(row: GameViewController.indexPathGlobal.row + 1, section: 0)
        if (nextItem.row < ViewController.gamersArray[0].count && nextItem.row >= 0)
        {
            collectionView.scrollToItem(at: nextItem as IndexPath, at: .centeredHorizontally, animated: true)
            backCellButton.setImage(UIImage(named: "icon_Next-2.png"), for: .normal)
            if GameViewController.indexPathGlobal.row < (ViewController.gamersArray[0].count - 1) {
                GameViewController.indexPathGlobal = [0, GameViewController.indexPathGlobal.row + 1]
            }
            if GameViewController.indexPathGlobal.row == (ViewController.gamersArray[0].count - 1) {
                nextCellButton.setImage(UIImage(named: "icon_Previous-2.png"), for: .normal)
            }
        }
        if (nextItem.row == ViewController.gamersArray[0].count)
        {
            collectionView.scrollToItem(at: [0,0] as IndexPath, at: .centeredHorizontally, animated: true)
            GameViewController.indexPathGlobal = [0, 0]
            backCellButton.setImage(UIImage(named: "icon_Previous.png"), for: .normal)
            nextCellButton.setImage(UIImage(named: "icon_Next.png"), for: .normal)
        }
        
        let index = GameViewController.indexPathGlobal[1]
        for (idx, label) in labelsArrayMiniBar.enumerated() {
            if idx == index {
                label.textColor = .white
            }
            else {
                label.textColor = UIColor(red: 0.231, green: 0.231, blue: 0.231, alpha: 1)
            }
        }
        defaults.removeObject(forKey: "redoArraySaved")
        let encodedValues = GameViewController.redoArray.map{return ["0":$0.0[0], "1":$0.0[1], "2":$0.1, "3":$0.2, "4":$0.3, "5":$0.4]}
        defaults.set(encodedValues, forKey: "redoArraySaved")
        defaults.synchronize()
        print(GameViewController.redoArray)
     }
    
    @objc func undoAction(){
        GameViewController.indexPathGlobal = GameViewController.redoArray.last!.0
        self.collectionView.scrollToItem(at: GameViewController.indexPathGlobal, at: .centeredHorizontally, animated: true)
        
        let index = GameViewController.indexPathGlobal[1]
        for (idx, label) in labelsArrayMiniBar.enumerated() {
            if idx == index {
                label.textColor = .white
            }
            else {
                label.textColor = UIColor(red: 0.231, green: 0.231, blue: 0.231, alpha: 1)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let cell = self.collectionView.cellForItem(at: GameViewController.indexPathGlobal) as? GameCollectionViewCell
            
            cell?.score.text = GameViewController.redoArray.last?.1
            GameViewController.redoArray.removeLast()
            self.defaults.removeObject(forKey: "redoArraySaved")
            let encodedValues = GameViewController.redoArray.map{return ["0":$0.0[0], "1":$0.0[1], "2":$0.1, "3":$0.2, "4":$0.3, "5":$0.4]}
            self.defaults.set(encodedValues, forKey: "redoArraySaved")
            if GameViewController.redoArray.isEmpty{
                self.undoButton.isEnabled = false
            }
        }
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
    
    @objc func resultsTapped(){
        let resVC = ResultsViewController()
        navigationController?.pushViewController(resVC, animated: false)
    }
    
    @objc func cancelTapped(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func timerButtonAction(){
        if(timerCounting){
            timerCounting = false
            timer.invalidate()
            timerButton.setImage(UIImage(named: "Play.png"), for: .normal)
            timerLabel.textColor = UIColor(red: 0.231, green: 0.231, blue: 0.231, alpha: 1)
        }
        else {
            timerCounting = true
            timerButton.setImage(UIImage(named: "Pause.png"), for: .normal)
            timerLabel.textColor = UIColor.white
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        }
    }
    
    @objc func timerCounter(){
        count = count + 1
        let time = secondsToSecondsMinutes(seconds: count)
        let timeString = makeTimeString(minutes: time.0, seconds: time.1)
        timerLabel.text = timeString
    }
    
    func secondsToSecondsMinutes (seconds: Int) ->(Int, Int){
        return ((seconds / 60), (seconds % 60))
    }
    
    func makeTimeString(minutes: Int, seconds: Int)-> String{
        var timeString = ""
        timeString += String(format: "%02d", minutes)
        timeString += ":"
        timeString += String(format: "%02d", seconds)
        return timeString
    }

    func setupconstraint(){
        
        titleHeader.topAnchor.constraint(equalTo: view.topAnchor, constant: 12).isActive = true
        titleHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        titleHeader.widthAnchor.constraint(equalToConstant: 98).isActive = true
        titleHeader.heightAnchor.constraint(equalToConstant: 41).isActive = true
        
        button.topAnchor.constraint(equalTo: view.topAnchor, constant: 14).isActive = true
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        timerLabel.topAnchor.constraint(equalTo: titleHeader.bottomAnchor, constant: 8).isActive = true
        timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        timerLabel.widthAnchor.constraint(equalToConstant: 75).isActive = true
        timerLabel.heightAnchor.constraint(equalToConstant: 41).isActive = true
        
        timerButton.topAnchor.constraint(equalTo: titleHeader.bottomAnchor, constant: 18).isActive = true
        timerButton.leadingAnchor.constraint(equalTo: timerLabel.leadingAnchor, constant: 95).isActive = true
        timerButton.widthAnchor.constraint(equalToConstant: 16).isActive = true
        timerButton.heightAnchor.constraint(equalToConstant: 21).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 18).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: plus1Button.topAnchor, constant: -17).isActive = true
        
        plus1Button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -125).isActive = true
        plus1Button.widthAnchor.constraint(equalToConstant: 78).isActive = true
        plus1Button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        plus1Button.heightAnchor.constraint(equalToConstant: 78).isActive = true
        
        backCellButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -149).isActive = true
        backCellButton.widthAnchor.constraint(equalToConstant: 34).isActive = true
        backCellButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 46).isActive = true
        backCellButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        nextCellButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -149).isActive = true
        nextCellButton.widthAnchor.constraint(equalToConstant: 34).isActive = true
        nextCellButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -46).isActive = true
        nextCellButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        minus1Button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -65).isActive = true
        minus1Button.widthAnchor.constraint(equalToConstant: 46).isActive = true
        minus1Button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        minus1Button.heightAnchor.constraint(equalToConstant: 46).isActive = true
        
        minus5Button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -65).isActive = true
        minus5Button.widthAnchor.constraint(equalToConstant: 46).isActive = true
        minus5Button.trailingAnchor.constraint(equalTo: minus1Button.leadingAnchor, constant: -26).isActive = true
        minus5Button.heightAnchor.constraint(equalToConstant: 46).isActive = true
        
        plus5Button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -65).isActive = true
        plus5Button.widthAnchor.constraint(equalToConstant: 46).isActive = true
        plus5Button.leadingAnchor.constraint(equalTo: minus1Button.trailingAnchor, constant: 26).isActive = true
        plus5Button.heightAnchor.constraint(equalToConstant: 46).isActive = true
        
        minus10Button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -65).isActive = true
        minus10Button.widthAnchor.constraint(equalToConstant: 46).isActive = true
        minus10Button.trailingAnchor.constraint(equalTo: minus5Button.leadingAnchor, constant: -26).isActive = true
        minus10Button.heightAnchor.constraint(equalToConstant: 46).isActive = true
        
        plus10Button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -65).isActive = true
        plus10Button.widthAnchor.constraint(equalToConstant: 46).isActive = true
        plus10Button.leadingAnchor.constraint(equalTo: plus5Button.trailingAnchor, constant: 26).isActive = true
        plus10Button.heightAnchor.constraint(equalToConstant: 46).isActive = true
        
        undoButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25).isActive = true
        undoButton.widthAnchor.constraint(equalToConstant: 15).isActive = true
        undoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        undoButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        mStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -23).isActive = true
        mStackView.widthAnchor.constraint(equalToConstant: CGFloat(ViewController.gamersArray[0].count*14) + CGFloat((ViewController.gamersArray[0].count - 1)*5)).isActive = true
        mStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mStackView.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }

}

extension GameViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ViewController.gamersArray[0].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GameCollectionViewCell
        print("Cell is:\(String(describing: cell.score.text))")
        print("GamersDataForScoreRestoring is:\(GameViewController.gamersDataForScoreRestoring))")
        if (defaults.array(forKey: "redoArraySaved")) != nil && GameViewController.gamersDataForScoreRestoring.count >= ViewController.gamersArray.count {
            cell.data = GameViewController.gamersDataForScoreRestoring[indexPath.row].5.uppercased()
            cell.score.text = GameViewController.gamersDataForScoreRestoring[indexPath.row].4
        } else {
            cell.data = ViewController.gamersArray[0][indexPath.row].uppercased()}
        cell.backgroundColor = UIColor(red: 0.231, green: 0.231, blue: 0.231, alpha: 1)
        cell.layer.cornerRadius = 15
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding = CGFloat(340)
        let availableHeight = view.frame.height - padding
        
        return CGSize(width: 255, height: availableHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()
        visibleRect.origin = collectionView.contentOffset
        visibleRect.size = collectionView.bounds.size
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        guard let indexPath = collectionView.indexPathForItem(at: visiblePoint) else { return }
        GameViewController.indexPathGlobal = indexPath
        
        let index = GameViewController.indexPathGlobal[1]
        for (idx, label) in labelsArrayMiniBar.enumerated() {
            if idx == index {
                label.textColor = .white
            }
            else {
                label.textColor = UIColor(red: 0.231, green: 0.231, blue: 0.231, alpha: 1)
            }
        }
    }
}
