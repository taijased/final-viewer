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
            label.text = viewModel.object.name
        }
    }
    
    
    fileprivate let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        
        return view
    }()
    
    let myImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
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
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    lazy var moreButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
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
        
        
        
        
        
        
        
        addSubview(cardView)
        cardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        cardView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true


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
        label.trailingAnchor.constraint(equalTo: labelView.trailingAnchor, constant: -30).isActive = true
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true


        myImageView.addSubview(defaultImageView)
        defaultImageView.topAnchor.constraint(equalTo: myImageView.topAnchor).isActive = true
        defaultImageView.leadingAnchor.constraint(equalTo: myImageView.leadingAnchor).isActive = true
        defaultImageView.trailingAnchor.constraint(equalTo: myImageView.trailingAnchor).isActive = true
        defaultImageView.bottomAnchor.constraint(equalTo: label.topAnchor).isActive = true


        if UIDevice.current.model == "iPhone" {
            addSubview(moreButton)
            moreButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
            moreButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
            moreButton.heightAnchor.constraint(equalToConstant: 16).isActive = true
            moreButton.widthAnchor.constraint(equalToConstant: 16).isActive = true
        }
        
        
    }
    
    
    override func prepareForReuse() {
        myImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 10
        
        if traitCollection.userInterfaceStyle == .light {
            cardView.backgroundColor = .white
            cardView.layer.borderColor = UIColor(hexValue: "#F0F0F0", alpha: 0.9)?.cgColor
            labelView.backgroundColor = UIColor(hexValue: "#F0F0F0", alpha: 0.9)
            label.textColor = UIColor.Black.primary
            moreButton.setImage(UIImage(named: "more"), for: .normal)
            defaultImageView.image = UIImage(named: "viewer_36x36")
            
        } else {
            cardView.backgroundColor = UIColor.Black.gray
            cardView.layer.borderColor = UIColor.clear.cgColor
            labelView.backgroundColor = UIColor(hexValue: "#4F4F53", alpha: 0.8)
            label.textColor = .white
            moreButton.setImage(UIImage(named: "more-white"), for: .normal)
            defaultImageView.image = UIImage(named: "viewer-file-white")
        }
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.viewModel = nil
    }
}
