//
//  FormatListTableView.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 24.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//



import UIKit




class FormatListTableView: UITableView {
    
    
    var viewModel: FormatListTableViewVMType?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupUI()
        viewModel = FormatListTableViewVM()
        
    }
    
    fileprivate func setupUI() {
        delegate = self
        dataSource = self
        separatorStyle = .none
        allowsSelection = false
        translatesAutoresizingMaskIntoConstraints = false
        registerCells()
        
        
    }
    
    fileprivate func registerCells() {
        
        register(FormatListTableViewCell.self, forCellReuseIdentifier: FormatListTableViewCell.reuseId)
        tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 0))
        contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        
    
        let headerHeight: CGFloat = Bundle.main.preferredLocalizations.first == "en" ? 90 : 140
        tableHeaderView = FormatListTableHeaderView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: headerHeight))
        
    }
    


    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


//MARK: - UITableViewDelegate, UITableViewDataSource

extension FormatListTableView: UITableViewDelegate, UITableViewDataSource {
    
    override func numberOfRows(inSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = dequeueReusableCell(withIdentifier: FormatListTableViewCell.reuseId, for: indexPath) as? FormatListTableViewCell
        guard let viewCell = cell, let viewModel = viewModel else { return UITableViewCell() }
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        viewCell.viewModel = cellViewModel
        return viewCell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return viewModel?.heightForRowAt(indexPath: indexPath) ?? 0
    }
    
}
