//
//  UIView+FastBlurView.swift
//  FastBlurView
//
//  Created by cleexiang on 2021/10/12.
//

import Foundation
import UIKit

extension UIView {
    public func addBlur(sigma: CGFloat) -> FastBlurView {
        let blurView = FastBlurView(frame: CGRect.zero, device: MTLCreateSystemDefaultDevice())
        guard let superView = self.superview else {
            fatalError("add self to a super view before add blur view.")
        }
        superView.addSubview(blurView)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        blurView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        blurView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        blurView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        return blurView
    }
}
