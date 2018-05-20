//
//  NSAutoLayout.swift
//  UIExpandableTableViewCard
//
//  Created by Erick Sanchez on 5/19/18.
//

import Foundation

extension UIView {
    func deepCopy(constraints: [NSLayoutConstraint], to newView: UIView) -> [NSLayoutConstraint] {
        var newConstraints = [NSLayoutConstraint]()
        
        for aConstraint in constraints {
            guard
                let firstItem = aConstraint.firstItem,
                let secondItem = aConstraint.secondItem else {
                    continue
            }
            
            if self === firstItem {
                newConstraints.append(
                    NSLayoutConstraint(item: newView, toItem: secondItem, from: aConstraint)
                )
            } else if self === secondItem {
                newConstraints.append(
                    NSLayoutConstraint(item: secondItem, toItem: newView, from: aConstraint)
                )
            }
        }
        
        return newConstraints
    }
}

extension NSLayoutConstraint {
    convenience init(item: Any, toItem: Any?, from existingConstraint: NSLayoutConstraint) {
        self.init(item: item, attribute: existingConstraint.firstAttribute, relatedBy: existingConstraint.relation, toItem: toItem, attribute: existingConstraint.secondAttribute, multiplier: existingConstraint.multiplier, constant: existingConstraint.constant)
    }
}
