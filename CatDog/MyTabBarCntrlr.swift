//
//  MyTabBarCntrlr.swift
//  CatDog
//
//  Created by Ксения Каштанкина on 27.10.2021.
//

import UIKit

class MyTabBarCntrlr: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let newNC = UINavigationController()
        newNC.viewControllers.append(FinVC(nameImg: "ImageCat", textBtn: "Вы великолепны"))
        
        let newNCdog = UINavigationController()
        let vcDog = MyViewController(imgName: questions[0].nameImage, questText: questions[0].question, reverseBtn: questions[0].reversed)
        vcDog.testIndex = 0
        newNCdog.viewControllers.append(vcDog)
        
        self.viewControllers![1] = newNC
        self.viewControllers![2] = newNCdog
        
        newNC.tabBarItem.image = UIImage(named: "Image")
        newNCdog.tabBarItem.image = UIImage(named: "ImageDog")

    }
    
    struct oneQuestion {
        let question : String
        let nameImage : String
        var reversed : Bool = false
        
        init(_ question: String, _ nameImage: String, _ rev : Bool = false) {
               self.question = question
               self.nameImage = nameImage
               self.reversed = rev
           }

    }
    
    public let questions : [oneQuestion] = [
        oneQuestion("Носите тапочки дома?", "dogShoe"),
        oneQuestion("Наводите свои порядки?", "dogInterier"),
        oneQuestion("Предпочитаете ходить в туалет дома?", "dogPee"),
        oneQuestion("Заглядываетесь на соседку?", "dogGirl"),
        oneQuestion("Поедете на дачу?", "dogDacha", true),
        oneQuestion("Облизываете лицо хозяину?","dogFace")
    ]
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
