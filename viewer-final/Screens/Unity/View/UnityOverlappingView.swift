//
//  UnityOverlappingView.swift
//  viewer-final
//
//  Created by Alexey Antipin on 01.03.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import Foundation

protocol  UnityOverlappingViewProtocol: class
{
    func close()
    func openAR()
    func open3D()
}

class UnityOverlappingView: UIView
{
    weak var delegate: UnityOverlappingViewProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configurate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var closeButton: UIButton =
    {
        let button = UIButton.getCustomButton(label: "Close")
        button.addTarget(self, action: #selector(close(_:)), for: .touchUpInside)
        return button
    }()
    
    var openARButton: UIButton =
    {
        let button = UIButton.getCustomButton(label: "Open AR")
        button.addTarget(self, action: #selector(openAR(_:)), for: .touchUpInside)
        return button
    }()
    
    var open3DButton: UIButton =
    {
        let button = UIButton.getCustomButton(label: "Open 3D")
        button.addTarget(self, action: #selector(openAR(_:)), for: .touchUpInside)
        return button
    }()
    
    fileprivate func configurate()
    {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        
        addSubview(closeButton)
        closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 54).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        addSubview(open3DButton)
        open3DButton.topAnchor.constraint(equalTo: topAnchor, constant: 50).isActive = true
        open3DButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 50).isActive = true
        open3DButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        open3DButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

        addSubview(openARButton)
        openARButton.topAnchor.constraint(equalTo: topAnchor, constant: 50).isActive = true
        openARButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -50).isActive = true
        openARButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        openARButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    @objc func close(_ sender: UIButton)
    {
        delegate?.close()
    }
    
    @objc func openAR(_ sender: UIButton)
    {
        delegate?.openAR()
    }
    
    @objc func open3D(_ sender: UIButton)
    {
        delegate?.openAR()
    }
    
}
