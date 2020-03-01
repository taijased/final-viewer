//
//  ProjectsCollectionViewCell.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 19.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//



import UIKit


protocol ProjectsCollectionViewCellDelegate: class {
    func moreTapped(_ item: ProjectsCollectionViewCellVMType)
}

class ProjectsCollectionViewCell: UICollectionViewCell {
    
    
    
    weak var delegate: ProjectsCollectionViewCellDelegate?
    static let reuseId = "ProjectsCollectionViewCell"
    
    var viewModel: ProjectsCollectionViewCellVMType? {
        willSet(viewModel) {
           
            guard let viewModel = viewModel else { return }
           
            moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
//            myImageView.set(imageURL: viewModel.imageURL)
            label.text = viewModel.label
        }
    }
    
    
    let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowRadius = 7
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        view.layer.position = view.center
        return view
    }()
    
    let myImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .center
        imageView.backgroundColor = .white
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
//        imageView.image = UIImage(named: "viewer_36x36")
        return imageView
    }()
    
    let defaultImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .center
        imageView.image = UIImage(named: "viewer_36x36")
        return imageView
    }()
    
    
    
    let label: UILabel = {
        let label = UILabel.H3.medium
        return label
    }()
    
    let labelView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexValue: "#F0F0F0", alpha: 0.9)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    lazy var moreButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "more"), for: .normal)
        return button
    }()
    
    
    
    @objc func moreButtonTapped(_ sender: UIButton) {
        guard let viewModel = self.viewModel else { return }
        delegate?.moreTapped(viewModel)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    
    
    fileprivate func setupUI() {
        
        
           
        
        
        layer.cornerRadius = 10
        
        addSubview(cardView)
        cardView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        cardView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        cardView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        cardView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        

        cardView.addSubview(myImageView)
        myImageView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor).isActive = true
        myImageView.topAnchor.constraint(equalTo: cardView.topAnchor).isActive = true
        myImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor).isActive = true
        myImageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor).isActive = true



        myImageView.addSubview(labelView)
        labelView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor).isActive = true
        labelView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor).isActive = true
        labelView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor).isActive = true
        labelView.heightAnchor.constraint(equalToConstant: 50).isActive = true



        labelView.addSubview(label)
        label.centerYAnchor.constraint(equalTo: labelView.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: labelView.leadingAnchor, constant: 10).isActive = true
        label.trailingAnchor.constraint(equalTo: labelView.trailingAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        myImageView.addSubview(defaultImageView)
        defaultImageView.topAnchor.constraint(equalTo: myImageView.topAnchor).isActive = true
        defaultImageView.leadingAnchor.constraint(equalTo: myImageView.leadingAnchor, constant: 10).isActive = true
        defaultImageView.trailingAnchor.constraint(equalTo: myImageView.trailingAnchor).isActive = true
        defaultImageView.bottomAnchor.constraint(equalTo: label.topAnchor).isActive = true
        
        
        addSubview(moreButton)
        moreButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        moreButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        moreButton.heightAnchor.constraint(equalToConstant: 16).isActive = true
        moreButton.widthAnchor.constraint(equalToConstant: 16).isActive = true
        
        
    }
    
    
    override func prepareForReuse() {
        myImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.viewModel = nil
    }
}
