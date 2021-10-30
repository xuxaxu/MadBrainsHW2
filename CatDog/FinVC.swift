//
//  FinVC.swift
//  CatDog
//
//  Created by Ксения Каштанкина on 28.10.2021.
//

import UIKit

class FinVC: UIViewController {
    
    private var imageV : UIImageView
    private var btn = UIButton()
    
    convenience init() {
        self.init(nameImg:nil, textBtn: nil)
    }
    
    init(nameImg: String?, textBtn: String?) {
        
        //настроим картинку
        if let imgName = nameImg {
            self.imageV = UIImageView(image: UIImage(named: imgName))
        } else {
            self.imageV = UIImageView()
        }
        
        //настроим надпись с кнопкой
        if let textForBtn = textBtn {
            btn.setTitle(textForBtn, for: .normal)
        }
        btn.setTitleColor(.tintColor, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .systemYellow
        
        view.addSubview(imageV)
        imageV.contentMode = .scaleAspectFit
        imageV.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(btn)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.titleLabel?.numberOfLines = 0
        btn.addTarget(self, action: #selector(btnPush), for: .touchUpInside)
        btn.tag = 1
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    @IBAction @objc func btnPush() {
        self.tabBarController?.selectedIndex = 0
    }

    private func setupLayout() {
        
    //удалим все существующие констрейнты при повороте и сделаем новые
    imageV.deactivateAllConstraints()
    btn.deactivateAllConstraints()
        
    //сделаем разные констрейнты для портрейта и ландшафта
        if self.view.frame.width < self.view.frame.height {
        
            NSLayoutConstraint.activate([
                imageV.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: self.view.bounds.width/8),
                imageV.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.bounds.height/8),
                imageV.heightAnchor.constraint(equalTo: imageV.widthAnchor),
                imageV.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.75),
                btn.widthAnchor.constraint(equalTo: imageV.widthAnchor),
                btn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: self.view.bounds.width/8),
                btn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                btn.topAnchor.constraint(equalTo: imageV.bottomAnchor)
            ])
    
        } else {
            NSLayoutConstraint.activate([
                imageV.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: self.view.bounds.width/12),
                imageV.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.bounds.height/8),
                imageV.heightAnchor.constraint(equalTo: imageV.widthAnchor),
                imageV.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.75),
                btn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
                btn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20),
                btn.leadingAnchor.constraint(equalTo: imageV.trailingAnchor, constant: -10),
                btn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
            ])
        }

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

extension UIView {

    func removeConstraints() { removeConstraints(constraints) }
    func deactivateAllConstraints() { NSLayoutConstraint.deactivate(getAllConstraints()) }
    func getAllSubviews() -> [UIView] { return UIView.getAllSubviews(view: self) }

    func getAllConstraints() -> [NSLayoutConstraint] {
        var subviewsConstraints = getAllSubviews().flatMap { $0.constraints }
        if let superview = self.superview {
            subviewsConstraints += superview.constraints.compactMap { (constraint) -> NSLayoutConstraint? in
                if let view = constraint.firstItem as? UIView, view == self { return constraint }
                return nil
            }
        }
        return subviewsConstraints + constraints
    }

    class func getAllSubviews(view: UIView) -> [UIView] {
        return view.subviews.flatMap { [$0] + getAllSubviews(view: $0) }
    }
}
