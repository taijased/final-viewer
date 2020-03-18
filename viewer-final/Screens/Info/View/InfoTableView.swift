//
//  InfoTableView.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 17.03.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//

import UIKit


class InfoTableView: UITableView {
    
    
    var viewModel: InfoTableViewVMType?
    
    init(frame: CGRect, style: UITableView.Style, tableType: InformationTableType) {
        super.init(frame: frame, style: .plain)
        setupUI()
        viewModel = InfoTableViewVM(tableType)
        
    }
    
    fileprivate func setupUI() {
    
        estimatedRowHeight = UITableView.automaticDimension
        delegate = self
        dataSource = self
        separatorStyle = .none
        allowsSelection = false
        translatesAutoresizingMaskIntoConstraints = false
        registerCells()
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }
    
    fileprivate func registerCells() {
        register(InfoTableViewCell.self, forCellReuseIdentifier: InfoTableViewCell.reuseId)
        tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 0))
        contentInset = UIEdgeInsets(top: 70, left: 0, bottom: 50, right: 0)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


//MARK: - UITableViewDelegate, UITableViewDataSource

extension InfoTableView: UITableViewDelegate, UITableViewDataSource {
    
    override func numberOfRows(inSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = dequeueReusableCell(withIdentifier: InfoTableViewCell.reuseId, for: indexPath) as? InfoTableViewCell
        guard let viewCell = cell, let viewModel = viewModel else { return UITableViewCell() }
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        viewCell.viewModel = cellViewModel
        viewCell.delegate = self
        
        return viewCell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}


//MARK: - InfoTableViewCellSizeDelegate
extension InfoTableView: InfoTableViewCellSizeDelegate {
    func updateHeight() {
        UIView.setAnimationsEnabled(false)
        self.beginUpdates()
        self.endUpdates()
        UIView.setAnimationsEnabled(true)
    }
}
