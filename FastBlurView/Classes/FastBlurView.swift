//
//  FastBlurView.swift
//  FastBlurView
//
//  Created by cleexiang on 2021/8/26.
//  Copyright © 2021.cleexiang All rights reserved.
//

import Foundation
import Metal
import MetalKit
import MetalPerformanceShaders

public class FastBlurView: MTKView, MTKViewDelegate {
    public var continuous: Bool = false // if set, blur view will refresh content in a while
    var blurTarget: UIView?
    var bluredImage: UIImage?
    var sigma: Float = 10.0
    var commandQueue: MTLCommandQueue?
    var displayLink: CADisplayLink?

    init(frame: CGRect) {
        super.init(frame: frame, device: MTLCreateSystemDefaultDevice())
        commonInit()
    }
    
    public override init(frame: CGRect, device: MTLDevice?) {
        super.init(frame: frame, device: device)
        commonInit()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        self.isOpaque = false
        self.enableSetNeedsDisplay = true
        self.clearColor = MTLClearColorMake(0.0, 0.0, 0.0, 1.0)
        self.delegate = self
        self.colorPixelFormat = .bgra8Unorm
        self.framebufferOnly = false
        self.commandQueue = self.device?.makeCommandQueue()
    }

    public func draw(in view: MTKView) {
        guard let currentImage = bluredImage else { return }
        guard let cgImage = currentImage.cgImage else { return  }
        guard let commandBuffer = commandQueue?.makeCommandBuffer() else { return }
        guard let device = view.device else { return }
        let blur = MPSImageGaussianBlur(device: device, sigma: sigma)
        let textureloader = MTKTextureLoader(device: device)
        guard let currentTexture = view.currentDrawable?.texture else { return }
        do {
            let texture = try textureloader.newTexture(cgImage: cgImage, options: [:])
            blur.encode(commandBuffer: commandBuffer, sourceTexture: texture, destinationTexture: currentTexture)
        } catch {
            print(error.localizedDescription)
        }
        commandBuffer.present(view.currentDrawable!)
        commandBuffer.commit()
    }
    
    public func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        
    }
    
    open override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        self.blurTarget = newSuperview
        if continuous {
            registerDisplaylink()
        } else {
            drawBlurEffect()
        }
        print("view bounds: \(bounds)")
    }
    
    private func registerDisplaylink() {
        displayLink = CADisplayLink.init(target: self, selector: #selector(triggerDisplayLink))
        displayLink?.add(to: .main, forMode: RunLoop.Mode.common)
    }
    
    @objc private func triggerDisplayLink() {
        self.drawBlurEffect()
    }
    
    private func drawBlurEffect() {
        let rect = self.layer.convert(bounds, to: blurTarget?.layer)
        bluredImage = blurTarget?.snapshot(rect: rect, scale: layer.contentsScale)
        draw()
    }
}

extension UIView {
    func snapshot(rect: CGRect, scale: CGFloat) -> UIImage? {
        guard let context = CGContext.imageContext(in: rect, isOpaque: isOpaque, scale: scale) else { return nil }
        layer.render(in: context)
        defer {
            UIGraphicsEndImageContext()
        }
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

extension CGContext {
    static func imageContext(in rect: CGRect, isOpaque opaque: Bool, scale: CGFloat) -> CGContext? {
        UIGraphicsBeginImageContextWithOptions(rect.size, opaque, scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        context.translateBy(x: -rect.origin.x, y: -rect.origin.y)
        return context
    }
}

