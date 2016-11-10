//
//  secondVC.swift
//  GPUImage的使用
//
//  Created by 丁瑞瑞 on 10/11/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

import UIKit
import GPUImage
class secondVC: UIViewController {
    // 磨皮滤镜
    fileprivate var bilaterFilter : GPUImageBilateralFilter?
    // 美白滤镜
    fileprivate var brightnessFilter : GPUImageBrightnessFilter?
    // 实时拍摄的对象
    fileprivate var videoCamera : GPUImageVideoCamera?
    override func viewDidLoad() {
        super.viewDidLoad()
        // 创建实时拍摄的对象
        let videoCamera = GPUImageVideoCamera(sessionPreset: AVCaptureSessionPresetHigh, cameraPosition: .front)
        videoCamera?.outputImageOrientation = .portrait
        self.videoCamera = videoCamera
        
        // 创建预览层
        let gpuImageview = GPUImageView(frame: view.bounds)
        
        // 添加到self.view上
        view.insertSubview(gpuImageview, at: 0)
        
        // 创建滤镜组.磨皮，美白，组合滤镜
        let groups = GPUImageFilterGroup()
        
        // 创建磨皮滤镜
        let bilaterFilter = GPUImageBilateralFilter()
        groups.addFilter(bilaterFilter)
        self.bilaterFilter = bilaterFilter
        
        // 创建美白滤镜
        let brightnessFilter = GPUImageBrightnessFilter()
        groups.addFilter(brightnessFilter)
        self.brightnessFilter = brightnessFilter
        
        // 设置滤镜组链
        bilaterFilter .addTarget(brightnessFilter)
        groups.initialFilters = [bilaterFilter]
        groups.terminalFilter = brightnessFilter
        
        // 添加处理链
        videoCamera?.addTarget(groups)
        groups.addTarget(gpuImageview)
        
        // 开始采集
        videoCamera?.startCapture()
        
    }
    // meibai
    @IBAction func brightness(_ sender: UISlider) {
        self.brightnessFilter?.brightness = CGFloat(sender.value)
    }
    // 磨皮
    @IBAction func bilaterFilter(_ sender: UISlider) {
        // 值越小越好
        self.bilaterFilter?.distanceNormalizationFactor = CGFloat(10 - sender.value)
    }
}
