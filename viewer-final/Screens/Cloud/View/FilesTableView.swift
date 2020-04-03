//
//  FilesTableView.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 25.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//



import UIKit




class FilesTableView: UITableView {
    
    
    
    
    var viewModel: FilesTableViewVMType?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupUI()
        viewModel = FilesTableViewVM()
        viewModel?.onReloadData = {
            self.reloadData()
        }
    }
    
    
    
    
    fileprivate func setupUI() {
        delegate = self
        dataSource = self
        separatorStyle = .none
        allowsSelection = true
        isScrollEnabled = false
//        allowsSelection = false
//        allowsSelectionDuringEditing = false
        
        
        
        translatesAutoresizingMaskIntoConstraints = false
        registerCells()
        
        
    }
    
    fileprivate func registerCells() {
        
        register(FilesTableViewCell.self, forCellReuseIdentifier: FilesTableViewCell.reuseId)
        tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 0))
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

extension FilesTableView: UITableViewDelegate, UITableViewDataSource {
    
    override func numberOfRows(inSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = dequeueReusableCell(withIdentifier: FilesTableViewCell.reuseId, for: indexPath) as? FilesTableViewCell
        guard let viewCell = cell, let viewModel = viewModel else { return UITableViewCell() }
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        viewCell.viewModel = cellViewModel
        return viewCell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  
        guard let viewModel = viewModel else { return }
        viewModel.selectItem(atIndexPath: indexPath)
        
        guard let selectItem = viewModel.viewModelForSelectedRow() else { return }
        print(selectItem)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return viewModel?.heightForRowAt(indexPath: indexPath) ?? 0
    }
    
}
