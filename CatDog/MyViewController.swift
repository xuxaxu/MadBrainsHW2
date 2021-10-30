//
//  MyViewController.swift
//  CatDog
//
//  Created by Ксения Каштанкина on 27.10.2021.
//

import UIKit


class MyViewController: UIViewController {
    
    public var testIndex : Int = 0

    private var img = UIImageView()
    
    private var lblQuestion = UILabel()
    
    private var btnToBadBoy = UIButton()
    
    private var btnNext = UIButton()
    
    
    
    @objc private func btnYes(_ sender: Any) {
        let finVC = FinVC(nameImg: "badBoy", textBtn: "Плохой мальчик")
        self.navigationController?.pushViewController(finVC, animated: true)
    }
    
    @objc private func btnNo(_ sender: Any) {
        
        //в таб баре хранятся вопросы теста
        if let tabBar = self.tabBarController as? MyTabBarCntrlr {
        
            if testIndex == tabBar.questions.count - 1 {
                //если это последний вопрос - перейдем на финальный экран
                let finVC = FinVC(nameImg: "fin", textBtn: "Неблагодарное животное")
                self.navigationController?.pushViewController(finVC, animated: true)
                
            } else {
                // создадим контроллер для следующего вопроса
                    
                        let structTest = tabBar.questions[self.testIndex + 1]
                        let vc = MyViewController(imgName: structTest.nameImage, questText: structTest.question, reverseBtn: structTest.reversed)
                        vc.testIndex    =   testIndex + 1
                        self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    
    init(imgName : String, questText: String, reverseBtn : Bool = false) {
        
        self.img.image = UIImage(named: imgName)
        self.img.contentMode = .scaleAspectFit
        
        self.lblQuestion.text = questText
        self.lblQuestion.font = UIFont.systemFont(ofSize: 30)
        self.lblQuestion.adjustsFontSizeToFitWidth = true
        self.lblQuestion.textColor = .tintColor
        self.lblQuestion.textAlignment = .center
        self.lblQuestion.numberOfLines = 0
        
        super.init(nibName: nil, bundle: nil)
        
        let actionYes = #selector(btnYes)
        let actionNo = #selector(btnNo)
        if reverseBtn {
            setupBtn(btn: self.btnToBadBoy, text: "Нет", act: actionYes)
            setupBtn(btn: self.btnNext, text: "Да", act: actionNo)
        } else {
            setupBtn(btn: self.btnToBadBoy, text: "Да", act: actionYes)
            setupBtn(btn: self.btnNext, text: "Нет", act: actionNo)
        }
    }
    
    convenience init() {
        self.init(imgName: "", questText: "")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    private func setupBtn(btn: UIButton, text: String, act : Selector) {
        btn.setTitle(text, for: .normal)
        btn.setTitleColor(.tintColor, for: .normal)
        btn.addTarget(self, action: act, for: .touchUpInside)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        btn.tag = 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        super.view.backgroundColor = .systemYellow
        
        self.view.addSubview(img)
        img.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(lblQuestion)
        lblQuestion.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(btnToBadBoy)
        btnToBadBoy.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(btnNext)
        btnNext.translatesAutoresizingMaskIntoConstraints = false
        

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLayout()
    }
    
    private func setupLayout() {
        self.img.deactivateAllConstraints()
        self.lblQuestion.deactivateAllConstraints()
        self.btnToBadBoy.deactivateAllConstraints()
        self.btnNext.deactivateAllConstraints()
        
        if self.view.bounds.width < self.view.bounds.height {
            NSLayoutConstraint.activate([
                img.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.bounds.height/8) ,
                img.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5),
                img.heightAnchor.constraint(equalTo: img.widthAnchor),
                img.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: self.view.bounds.width*0.25) ,
                btnToBadBoy.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -self.view.bounds.height/4),
                btnToBadBoy.heightAnchor.constraint(equalToConstant: 50),
                btnToBadBoy.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: self.view.bounds.width/8),
                btnToBadBoy.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.25) ,
                btnNext.bottomAnchor.constraint(equalTo: btnToBadBoy.bottomAnchor),
                btnNext.heightAnchor.constraint(equalTo: btnToBadBoy.heightAnchor),
                btnNext.widthAnchor.constraint(equalTo: btnToBadBoy.widthAnchor),
                btnNext.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -self.view.bounds.width/8),
                lblQuestion.topAnchor.constraint(equalTo: img.bottomAnchor),
                lblQuestion.bottomAnchor.constraint(equalTo: btnToBadBoy.topAnchor),
                lblQuestion.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                lblQuestion.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
                
            ])
        } else {
            NSLayoutConstraint.activate([
                img.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.bounds.height/8) ,
                img.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.75),
                img.heightAnchor.constraint(equalTo: img.widthAnchor),
                img.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: self.view.bounds.width/12) ,
                btnNext.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -self.view.bounds.height/4),
                btnNext.heightAnchor.constraint(equalToConstant: 50),
                btnNext.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.1),
                btnNext.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -self.view.bounds.width/8),
                btnToBadBoy.bottomAnchor.constraint(equalTo: btnNext.bottomAnchor),
                btnToBadBoy.heightAnchor.constraint(equalToConstant: 50),
                btnToBadBoy.leadingAnchor.constraint(equalTo: img.trailingAnchor, constant: self.view.bounds.width/12),
                btnToBadBoy.widthAnchor.constraint(equalTo: btnNext.widthAnchor) ,
                lblQuestion.topAnchor.constraint(equalTo: img.topAnchor),
                lblQuestion.bottomAnchor.constraint(equalTo: btnToBadBoy.topAnchor),
                lblQuestion.leadingAnchor.constraint(equalTo: img.trailingAnchor),
                lblQuestion.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
                
            ])
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
}
