//
//  RollViewController.swift
//  rs.ios.stage-task10
//
//  Created by Albert Zhloba on 31.08.21.
//

import UIKit

class RollViewController: UIViewController {
    
    fileprivate let img: UIImageView = {
        let iv1 = UIImageView()
        iv1.translatesAutoresizingMaskIntoConstraints = false
        iv1.contentMode = .scaleAspectFill
        
        return iv1
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let effect: UIBlurEffect = UIBlurEffect(style: .dark)
        let effectView = UIVisualEffectView(effect: effect)
        effectView.frame = CGRect(x:0, y:0, width:UIScreen.main.bounds.size.width, height:UIScreen.main.bounds.size.height)
        view.addSubview(effectView)
        view.addSubview(img)
        
        let number = Int.random(in: 1...6)
        
        if number == 1{
            img.image = UIImage(named: "dice_1.png")
        }
        if number == 2{
            img.image = UIImage(named: "dice_2.png")
        }
        if number == 3{
            img.image = UIImage(named: "dice_3.png")
        }
        if number == 4{
            img.image = UIImage(named: "dice_4.png")
        }
        if number == 5{
            img.image = UIImage(named: "dice_5.png")
        }
        if number == 6{
            img.image = UIImage(named: "dice_6.png")
        }
        img.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        img.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        img.widthAnchor.constraint(equalToConstant: 120).isActive = true
        img.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        hideWhenTappedAround()
    }
    
    func hideWhenTappedAround() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hide))
        view.addGestureRecognizer(gesture)
    }
    @objc func hide() {
        dismiss(animated: true, completion: nil)
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
