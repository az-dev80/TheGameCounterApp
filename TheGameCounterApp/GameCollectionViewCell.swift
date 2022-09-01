//
//  GameCollectionViewCell.swift
//  rs.ios.stage-task10
//
//  Created by Albert Zhloba on 29.08.21.
//

import UIKit

class GameCollectionViewCell: UICollectionViewCell {
     var label: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        
        lbl.textColor = UIColor(red: 0.922, green: 0.682, blue: 0.408, alpha: 1)
        lbl.font = UIFont(name: "Nunito-ExtraBold", size: 28)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byClipping
        
        return lbl
    }()
    
    var score: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        if (lbl.text == nil) {
            lbl.text = "0"}
        lbl.textColor = UIColor(red: 1, green: 0.992, blue: 0.992, alpha: 1)
        lbl.font = UIFont(name: "Nunito-Bold", size: 100)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byClipping
        
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //img1.frame = contentView.bounds
        self.addSubview(label)
        self.addSubview(score)
        
        contentView.layer.cornerRadius = 8
        //contentView.layer.borderWidth = 1
        //contentView.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        
        label.heightAnchor.constraint(equalToConstant: 38).isActive = true
        label.widthAnchor.constraint(equalToConstant: 255).isActive = true
        label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24).isActive = true
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        //img1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        //img1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        //img1.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        score.heightAnchor.constraint(equalToConstant: 80).isActive = true
        score.widthAnchor.constraint(equalToConstant: 250).isActive = true
        score.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -70).isActive = true
        score.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var data: String? {
        didSet{
            guard let data = data else { return }
            label.text = data
        }
    }
    
    var data1: String? {
        didSet{
            guard let data1 = data1 else { return }
            score.text = data1
        }
    }
    
//    override func prepareForReuse() {
//         score.text = MyVariables.yourVariable
//    }
}
