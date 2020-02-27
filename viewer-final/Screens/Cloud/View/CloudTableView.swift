//
//  CloudTableView.swift
//  viewer-final
//
//  Created by Максим Спиридонов on 25.02.2020.
//  Copyright © 2020 Максим Спиридонов. All rights reserved.
//


import UIKit







struct ExpandableNames {
    var isExpanded: Bool
    let cellVM: CloudTableViewCellVM
}



final class CloudTableView: UITableView {
    
    
    
    fileprivate var pageContainerInittalHeight = CGFloat()

    var viewModel: CloudTableViewVMType?
    
    
    
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: .grouped)
        viewModel = CloudTableViewVM()
        setupUI()
        
        pageContainerInittalHeight = frame.height
    }
    
    fileprivate func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
//        backgroundColor = .random()
        delegate = self
        dataSource = self
        register(CloudTableViewCell.self, forCellReuseIdentifier: CloudTableViewCell.reuseId)
        tableHeaderView = viewModel?.headerView
        
        tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 1))
        contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 200, right: 0)
        
        viewModel?.onReloadData = {
            self.reloadData()
        }
        
        viewModel?.onDeleteRows = { indexPaths in
            self.deleteRows(at: indexPaths, with: .none) {
                self.reloadData()
            }
        }
        
        
        viewModel?.onInsertRows = { indexPaths in
            self.insertRows(at: indexPaths, with: .none) {
                self.reloadData()
            }
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        separatorStyle = .none
        
        
        allowsSelection = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func handleExpandClose(button: UIButton) {
        let section = button.tag
        guard let viewModel = viewModel else { return }
        viewModel.expandSection(section)
        if viewModel.isExpanded(section) {
            UIView.animate(withDuration: 0.3) {
                button.setImage(UIImage(named: "arrow-down"), for: .normal)
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                button.setImage(UIImage(named: "arrow-top"), for: .normal)
            }
        }
    }
    
}


//MARK: - UITableViewDelegate, UITableViewDataSource

extension CloudTableView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let viewModel = viewModel else { return nil }
        let sectionView = viewModel.generateSectionView(section)
        sectionView.expandButton.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        return sectionView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel?.heightForHeaderInSection ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRowsInSection(section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = dequeueReusableCell(withIdentifier: CloudTableViewCell.reuseId, for: indexPath) as? CloudTableViewCell
        guard let viewCell = cell, let viewModel = viewModel else { return UITableViewCell() }
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        viewCell.viewModel = cellViewModel
        
        let cellHeight = viewCell.viewModel?.tableView.viewModel?.getHeightCell()
        viewModel.setHeightForRowAt(cellHeight!)
        return viewCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return viewModel?.heightForRowAt(indexPath) ?? 0
    }
    
}




//MARK: -

extension CloudTableView {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let headerView = self.tableHeaderView as! CloudTableHeaderView
        headerView.scrollViewDidScroll(scrollView: scrollView)
    }
}
