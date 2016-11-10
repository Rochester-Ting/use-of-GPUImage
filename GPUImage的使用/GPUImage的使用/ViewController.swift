//
//  ViewController.swift
//  GPUImage的使用
//
//  Created by 丁瑞瑞 on 10/11/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

import UIKit
import GPUImage

class ViewController: UIViewController {
    
    // 设置显示的view
    var captureVideoPreview : GPUImageView?
    // 设置实时录制的摄像头
    var videoCamera : GPUImageVideoCamera?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        
    }

    }
extension ViewController{
    fileprivate func setUp(){
        // 创建摄像头
        // AVCaptureSessionPresetHigh 自动适配的分辨率
        let videoCamera = GPUImageVideoCamera(sessionPreset: AVCaptureSessionPresetHigh, cameraPosition: .front)
        videoCamera?.outputImageOrientation = .portrait
        self.videoCamera = videoCamera
        // 创建最终预览的view
        let videoView = GPUImageView(frame: view.bounds)
        view.insertSubview(videoView, at: 0)
        self.captureVideoPreview = videoView
        
    }
    @IBAction func startCamera(_ sender: Any) {
//        / 设置处理链
        self.videoCamera?.addTarget(self.captureVideoPreview)
        // 开始采集视频
        self.videoCamera?.startCapture()
    }
    @IBAction func `switch`(_ sender: UISwitch) {
        // 创建美颜滤镜
        let filter = GPUImageBeautifyFilter()

        if sender.isOn {
            // 移除所有的处理链条
            self.videoCamera?.removeAllTargets()
            // 设置处理链条
            self.videoCamera?.addTarget(filter)
            filter.addTarget(self.captureVideoPreview)
        }else{
            self.videoCamera?.removeAllTargets()
            self.videoCamera?.addTarget(self.captureVideoPreview)
        }
//        GPUImageMovieWriter
    }

}
