//
//  CPopUpTableView.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 27.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//


import UIKit




class CPopUpTableView: UITableView {
    
    var viewModel: CPopUpTableViewVMType?
    
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupUI()
        viewModel = CPopUpTableViewVM()
        
    }
    
    fileprivate func setupUI() {
        delegate = self
        dataSource = self
        separatorStyle = .none
        allowsSelection = true
        translatesAutoresizingMaskIntoConstraints = false
        isScrollEnabled = false
        registerCells()
    }
    
    fileprivate func registerCells() {
        register(CPopUpTableViewCell.self, forCellReuseIdentifier: CPopUpTableViewCell.reuseId)
        tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 0))
        
        let headerView = CPopUpTableHeaderView(frame: CGRect(x: 0,y: 0,width: frame.size.width, height: CPopUpTableHeaderView.height))
        headerView.delegate = self
        tableHeaderView = headerView
        contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
    }
    
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


//MARK: - UITableViewDelegate, UITableViewDataSource

extension CPopUpTableView: UITableViewDelegate, UITableViewDataSource {
    
    override func numberOfRows(inSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = dequeueReusableCell(withIdentifier: CPopUpTableViewCell.reuseId, for: indexPath) as? CPopUpTableViewCell
        guard let viewCell = cell, let viewModel = viewModel else { return UITableViewCell() }
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        viewCell.viewModel = cellViewModel
        return viewCell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return viewModel?.heightForRowAt(indexPath: indexPath) ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        viewModel.selectItem(atIndexPath: indexPath)
    }
}





//MARK: - CPopUpTableHeaderViewDelegate

extension CPopUpTableView: CPopUpTableHeaderViewDelegate {
    func close() {
        self.viewModel?.onDismiss?()
    }
}
