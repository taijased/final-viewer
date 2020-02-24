//
//  SelectCloudTableView.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 24.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//



import UIKit




class SelectCloudTableView: UITableView {
    
    
    
    
    var viewModel: SelectCloudTableViewVMType?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupUI()
        viewModel = SelectCloudTableViewVM()
        
    }
    
    fileprivate func setupUI() {
        delegate = self
        dataSource = self
        separatorStyle = .none
        allowsSelection = false
//        contentInsetAdjustmentBehavior = .never
        translatesAutoresizingMaskIntoConstraints = false
        registerCells()
        
        
    }
    
    fileprivate func registerCells() {
        
        register(SelectCloudTableViewCell.self, forCellReuseIdentifier: SelectCloudTableViewCell.reuseId)
        
        tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 0))
        contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        
        tableHeaderView = SelectCloudHeaderView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: 179))
        
    }
    


    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


//MARK: - UITableViewDelegate, UITableViewDataSource

extension SelectCloudTableView: UITableViewDelegate, UITableViewDataSource {
    
    override func numberOfRows(inSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = dequeueReusableCell(withIdentifier: SelectCloudTableViewCell.reuseId, for: indexPath) as? SelectCloudTableViewCell
        guard let viewCell = cell, let viewModel = viewModel else { return UITableViewCell() }
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        viewCell.viewModel = cellViewModel
        return viewCell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return viewModel?.heightForRowAt(indexPath: indexPath) ?? 0
    }
    
}
