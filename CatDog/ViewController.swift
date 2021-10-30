//
//  ViewController.swift
//  CatDog
//
//  Created by Ксения Каштанкина on 27.10.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func catChoose(_ sender: Any) {
        if let btn = sender as? UIButton {
            switch btn.titleLabel?.text {
            case "Котик" : self.tabBarController?.selectedIndex = 1
            case "Песик" : replayDog()//self.tabBarController?.selectedIndex = 2
            default : self.tabBarController?.selectedIndex = 0
            }
        }
    }
    
    
    private func replayDog() {
        
        if let tabBar = self.tabBarController as? MyTabBarCntrlr {
            let newNCdog = UINavigationController()
            let vcDog = MyViewController(imgName: tabBar.questions[0].nameImage, questText: tabBar.questions[0].question, reverseBtn: tabBar.questions[0].reversed)
            vcDog.testIndex = 0
            newNCdog.viewControllers.append(vcDog)
            
            tabBar.viewControllers![2] = newNCdog
            
            newNCdog.tabBarItem.image = UIImage(named: "ImageDog")
            
            tabBar.selectedIndex = 2
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

