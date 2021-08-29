//
//  ViewController.swift
//  FastBlurView
//
//  Created by cleexiang on 08/29/2021.
//  Copyright (c) 2021 cleexiang. All rights reserved.
//

import UIKit
import FastBlurView
import Metal

class ViewController: UIViewController {

    var timer: Timer?
    let bgImageView = UIImageView(frame: CGRect(x: 0, y: 100, width: 400, height: 300))
    var index = 1
    deinit {
        timer?.invalidate()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(bgImageView)
        let image = UIImage(named: "sample1.jpg")
        bgImageView.image = image

        let blurView = FastBlurView(frame: CGRect(x: 0, y: 100, width: 300, height: 200), device: MTLCreateSystemDefaultDevice())
        view.addSubview(blurView)
                
        timer = Timer(timeInterval: 1, repeats: true, block: { [weak self] _ in
            guard let `self` = self else { return }
            if self.index >= 3 {
                self.index = 1
            }
            self.bgImageView.image = UIImage(named: "sample\(self.index).jpg")
            self.index += 1
        })
        RunLoop.current.add(timer!, forMode: .commonModes)
    }
}

