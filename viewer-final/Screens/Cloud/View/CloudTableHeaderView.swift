//
//  CloudTableHeaderView.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 25.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import UIKit




//final class CloudTableHeaderView: UIView {
//
//
//    static let height: CGFloat = 100
//
//
//    fileprivate let searchView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.layer.shadowRadius = 4
//        view.layer.shadowOpacity = 1
//        view.layer.shadowOffset = CGSize(width: 0, height: 2)
//        view.layer.cornerRadius = 10
//        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
//        view.backgroundColor = .white
//        return view
//    }()
//
//
//    fileprivate let cloudLogo: UIImageView = {
//        let view = UIImageView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.image = UIImage(named: "gd-logo")
//        return view
//    }()
//
//
//
//
//
//
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//    }
//
//    fileprivate func setupUI() {
//        backgroundColor = .white
//        setupConstrints()
//    }
//
//
//    fileprivate func setupConstrints() {
//
//        addSubview(searchView)
//        searchView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
//        searchView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
//        searchView.topAnchor.constraint(equalTo: topAnchor, constant: 32).isActive = true
//        searchView.heightAnchor.constraint(equalToConstant: 48).isActive = true
//
//
//        searchView.addSubview(cloudLogo)
//        cloudLogo.centerYAnchor.constraint(equalTo: searchView.centerYAnchor).isActive = true
//        cloudLogo.trailingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: -20).isActive = true
//        cloudLogo.heightAnchor.constraint(equalToConstant: 22).isActive = true
//        cloudLogo.widthAnchor.constraint(equalToConstant: 22).isActive = true
//
//
//    }
//
//
//
//
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//}

//
//  ParallaxHeaderView.swift
//  ParalaxTableView
//
//  Created by Максим Спиридонов on 27.01.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import UIKit


final class CloudTableHeaderView: UIView {
    
    static let height: CGFloat = 100
    
    fileprivate var heightLayoutConstraint = NSLayoutConstraint()
    fileprivate var bottomLayoutConstraint = NSLayoutConstraint()
    
    fileprivate var containerLayoutConstraint = NSLayoutConstraint()
    
    
    fileprivate let searchView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        view.backgroundColor = .white
        return view
    }()
    
    
    fileprivate let cloudLogo: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "gd-logo")
        return view
    }()
    
    
    
    fileprivate var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    fileprivate let fixedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .random()
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        return view
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
    }
    
    
    fileprivate func setupConstraints() {
        self.backgroundColor = .clear
        self.addSubview(containerView)
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[containerView]|",
                                                           options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                           metrics: nil,
                                                           views: ["containerView" : containerView]))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[containerView]|",
                                                           options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                           metrics: nil,
                                                           views: ["containerView" : containerView]))
        
        containerLayoutConstraint = NSLayoutConstraint(item: containerView,
                                                       attribute: .height,
                                                       relatedBy: .equal,
                                                       toItem: self,
                                                       attribute: .height,
                                                       multiplier: 1.0,
                                                       constant: 0.0)
        self.addConstraint(containerLayoutConstraint)
        
        
        
        
        containerView.addSubview(fixedView)
        containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[imageView]|",
                                                                    options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                                    metrics: nil,
                                                                    views: ["imageView" : fixedView]))
        
        bottomLayoutConstraint = NSLayoutConstraint(item: fixedView,
                                                    attribute: .bottom,
                                                    relatedBy: .equal,
                                                    toItem: containerView,
                                                    attribute: .bottom,
                                                    multiplier: 1.0,
                                                    constant: 0.0)
        
        containerView.addConstraint(bottomLayoutConstraint)
        
        heightLayoutConstraint = NSLayoutConstraint(item: fixedView,
                                                    attribute: .height,
                                                    relatedBy: .equal,
                                                    toItem: containerView,
                                                    attribute: .height,
                                                    multiplier: 1.0,
                                                    constant: 0.0)
        
        containerView.addConstraint(heightLayoutConstraint)
        
        
        
        
        fixedView.addSubview(searchView)
        searchView.topAnchor.constraint(equalTo: fixedView.topAnchor, constant: 65).isActive = true
        searchView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        searchView.widthAnchor.constraint(equalToConstant: frame.width - 32).isActive = true
        searchView.centerXAnchor.constraint(equalTo: fixedView.centerXAnchor).isActive = true
        
        
        
        
        
        
        searchView.addSubview(cloudLogo)
        cloudLogo.centerYAnchor.constraint(equalTo: searchView.centerYAnchor).isActive = true
        cloudLogo.trailingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: -20).isActive = true
        cloudLogo.heightAnchor.constraint(equalToConstant: 22).isActive = true
        cloudLogo.widthAnchor.constraint(equalToConstant: 22).isActive = true
        
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        containerLayoutConstraint.constant = scrollView.contentInset.top;
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top);
        containerView.clipsToBounds = offsetY <= 0
        bottomLayoutConstraint.constant = offsetY >= 0 ? 0 : -offsetY / 2
        heightLayoutConstraint.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
    }
}
