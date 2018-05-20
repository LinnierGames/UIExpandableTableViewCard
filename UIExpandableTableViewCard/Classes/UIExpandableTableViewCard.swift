//
//  UIExpandableTableViewCard.swift
//  UIExpandableTableViewCard
//
//  Created by Erick Sanchez on 5/19/18.
//

import UIKit

open class UIExpandableTableViewCard: UITableView {
    
    private var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsVerticalScrollIndicator = false
        sv.showsHorizontalScrollIndicator = false
        sv.alwaysBounceHorizontal = false
        sv.alwaysBounceVertical = true
        
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        return sv
    }()
    
    private var initialConstraints: [NSLayoutConstraint]!
    
    private override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initLayout()
    }

    // MARK: - RETURN VALUES
    
    // MARK: - VOID METHODS
    
    private func initLayout() {
        guard let selfSuperview = self.superview else {
            return print("no superview was set")
        }
        
        //style
        self.layer.cornerRadius = 8.0
        self.isScrollEnabled = false
        
        //store current constarints
        self.initialConstraints = self.constraints
        
        //insert scrollview
        scrollView.frame = self.frame
        selfSuperview.insertSubview(scrollView, belowSubview: self)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addSubview(self)
        self.frame = scrollView.bounds
        
        //copy inital constraints to scroll view
        let scrollViewConstraints = self.deepCopy(constraints: self.constraints, to: self.scrollView)
        NSLayoutConstraint.activate(scrollViewConstraints)
        
        //remove self constarints
        
        //apply new constaints to table view to scrollview
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        //update height
    }
    
    // MARK: - IBACTIONS
    
    // MARK: - LIFE CYCLE

}
