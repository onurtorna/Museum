//
//  UIView+LayoutConstraints.swift
//  Museum
//
//  Created by Onur Torna on 09.08.2023.
//

import UIKit

extension UIView {

    func fit(childView: UIView, constant: CGFloat = 0.0) {
        addSubview(childView)
        addTrailingConstraint(to: childView, constant: constant)
        addLeadingConstraint(to: childView, constant: constant)
        addBottomConstraint(to: childView, constant: constant)
        addTopConstraint(to: childView, constant: constant)
    }

    func addTrailingConstraint(to childView: UIView?, constant: CGFloat) {
        guard let childView else { return }

        let trailingConstraint = NSLayoutConstraint(
            item: childView,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: self,
            attribute: .trailing,
            multiplier: 1.0,
            constant: constant
        )

        addConstraint(trailingConstraint)
    }

    func addLeadingConstraint(to childView: UIView?, constant: CGFloat) {
        guard let childView else { return }

        let leadingConstraint = NSLayoutConstraint(
            item: childView,
            attribute: .leading,
            relatedBy: .equal,
            toItem: self,
            attribute: .leading,
            multiplier: 1.0,
            constant: constant
        )

        addConstraint(leadingConstraint)
    }

    func addTopConstraint(to childView: UIView?, constant: CGFloat) {
        guard let childView = childView else { return }

        let topConstraint = NSLayoutConstraint(
            item: childView,
            attribute: .top,
            relatedBy: .equal,
            toItem: self,
            attribute: .top,
            multiplier: 1.0,
            constant: constant
        )

        addConstraint(topConstraint)
    }

    func addBottomConstraint(to childView: UIView?, constant: CGFloat) {
        guard let childView else { return }

        let bottomConstraint = NSLayoutConstraint(
            item: childView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: self,
            attribute: .bottom,
            multiplier: 1.0,
            constant: constant
        )

        addConstraint(bottomConstraint)
    }
}
