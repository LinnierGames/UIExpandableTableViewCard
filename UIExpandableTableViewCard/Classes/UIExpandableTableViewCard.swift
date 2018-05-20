//
//  UIExpandableTableViewCard.swift
//  UIExpandableTableViewCard
//
//  Created by Erick Sanchez on 5/19/18.
//

import UIKit

open class UIExpandableTableViewCard: UIScrollView {
    
    @IBOutlet weak var tableViewDataSource: UITableViewDataSource? {
        didSet {
            tableView.dataSource = self.tableViewDataSource
        }
    }
    
    @IBOutlet weak var tableViewDelegate: UITableViewDelegate? {
        didSet {
            tableView.delegate = self.tableViewDelegate
        }
    }
    
    public private(set) var tableView: UITableView = {
        let tb = UITableView(frame: CGRect.zero, style: .plain)
        tb.isScrollEnabled = false
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.layer.cornerRadius = 8.0
        
        return tb
    }()
    
    private var tableViewHeightConstraint: NSLayoutConstraint!
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initLayout()
    }

    // MARK: - RETURN VALUES
    
    // MARK: - VOID METHODS
    
    private func initLayout() {
        
        //style
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.alwaysBounceHorizontal = false
        self.alwaysBounceVertical = true

        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 8.0
        
        //layout tableview
        self.addSubview(self.tableView)
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor).isActive = true
        
        let tableViewWidthOffset = self.layoutMargins.right + self.layoutMargins.left
        tableView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -tableViewWidthOffset).isActive = true
        
        let scrollViewHeightConstraint = tableView.heightAnchor.constraint(equalTo: self.heightAnchor)
        scrollViewHeightConstraint.priority = UILayoutPriority(999)
        scrollViewHeightConstraint.isActive = true
        
        self.tableViewHeightConstraint = tableView.heightAnchor.constraint(equalToConstant: 0.0)
        tableViewHeightConstraint.isActive = true
        
        //data source
        tableView.reloadData()
    }
    
    public func updateTableViewHeight(animated: Bool = true) {
        
        //update height
        guard
            let dataSource = self.tableViewDataSource,
            let delegate = self.tableViewDelegate else {
                return
        }
        
        var height: CGFloat = 0
        let nSections = dataSource.numberOfSections?(in: self.tableView) ?? 1
        for aSection in 0..<nSections {
            let nRows = dataSource.tableView(tableView, numberOfRowsInSection: aSection)
            
            //header view/text
            if
                dataSource.tableView?(tableView, titleForHeaderInSection: aSection) != nil ||
                    delegate.tableView?(tableView, viewForHeaderInSection: aSection) != nil
            {
                height += delegate.tableView?(tableView, heightForHeaderInSection: aSection) ?? 20.0
            }
            
            //rows
            for aRow in 0..<nRows {
                height += delegate.tableView?(tableView, heightForRowAt: IndexPath(row: aRow, section: aSection)) ?? 44.0
            }
            
            //footer view/text
            if
                dataSource.tableView?(tableView, titleForFooterInSection: aSection) != nil ||
                    delegate.tableView?(tableView, viewForFooterInSection: aSection) != nil
            {
                height += delegate.tableView?(tableView, heightForFooterInSection: aSection) ?? 20.0
            }
        }
        self.tableViewHeightConstraint.constant = height
        
        UIView.animate(withDuration: 0.3) { [unowned self] in
            self.layoutIfNeeded()
        }
    }
    
    // MARK: - IBACTIONS
    
    // MARK: - LIFE CYCLE

}
