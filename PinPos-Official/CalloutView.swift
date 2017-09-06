//
//  CalloutView.swift
//  PinPos-Official
//
//  Created by Zhilei Zheng on 2017/9/4.
//  Copyright © 2017年 Zhilei Zheng. All rights reserved.
//

import UIKit
import Hue
import SnapKit

class CalloutView: UIView {

    var nameLabel = UILabel(frame: CGRect(x: 30, y: 5, width: 50, height: 20))
    var addrLabel = UILabel(frame: CGRect(x: 30, y: 5, width: 50, height: 20))
    var navigationBtn = UIButton(type: .custom)
    
    func setUpView(place:Place, active:Category){
        let color = active.color
        nameLabel.text = place.name
        addrLabel.text = place.address
        nameLabel.textColor = UIColor(hex: color)
        addrLabel.textColor = UIColor(hex: color)
        nameLabel.font = UIFont(name: "Avenir", size: 20)
        addrLabel.font = UIFont(name: "Avenir", size: 14)
        let naviImg = UIImage(icon: .ionicons(.androidWalk), size: CGSize(width:45,height:45), textColor: UIColor(hex:color))
        navigationBtn.setImage(naviImg, for: .normal)
        navigationBtn.titleLabel?.text = ""
        self.addSubview(nameLabel)
        self.addSubview(addrLabel)
        self.addSubview(navigationBtn)
        navigationBtn.snp.makeConstraints{(make)->Void in
            make.centerY.equalTo(self)
            make.left.equalTo(self).offset(10)
            make.width.height.equalTo(45)
        }
        nameLabel.snp.makeConstraints{(make)->Void in
            make.top.equalTo(self).offset(10)
            make.height.equalTo(25)
            make.width.equalTo(self.frame.width-60)
            make.left.equalTo(navigationBtn).offset(45)
        }
        addrLabel.snp.makeConstraints{(make)->Void in
            make.top.equalTo(nameLabel).offset(25)
            make.height.equalTo(30)
            make.width.equalTo(self.frame.width-60)
            make.left.equalTo(navigationBtn).offset(45)
        }
        navigationBtn.addTarget(self, action: #selector(self.btnAction), for: .touchUpInside)
        print(navigationBtn.allTargets.count)
    }
    
    func btnAction(_ sender: UIButton){
        print("Hey")
    }
    
    
//    func dialogBezierPathWithFrame(frame: CGRect, arrowOrientation orientation: UIImageOrientation, arrowLength: CGFloat = 20.0) -> UIBezierPath {
//        // 1. Translate frame to neutral coordinate system & transpose it to fit the orientation.
//        var transposedFrame = CGRect.zero
//        switch orientation {
//        case .up, .down, .upMirrored, .downMirrored:
//            transposedFrame = CGRect(x:0, y:0, width:frame.size.width - frame.origin.x, height:frame.size.height - frame.origin.y)
//        case .left, .right, .leftMirrored, .rightMirrored:
//            transposedFrame = CGRect(x:0, y:0,  width:frame.size.height - frame.origin.y, height:frame.size.width - frame.origin.x)
//        }
//        
//        // 2. We need 7 points for our Bezier path
//        let midX = transposedFrame.midX
//        let point1 = CGPoint(x: transposedFrame.minX, y: transposedFrame.minY + arrowLength)
//        let point2 = CGPoint(x: midX - (arrowLength / 2), y: transposedFrame.minY + arrowLength)
//        let point3 = CGPoint(x: midX, y: transposedFrame.minY)
//        let point4 = CGPoint(x: midX + (arrowLength / 2), y: transposedFrame.minY + arrowLength)
//        let point5 = CGPoint(x: transposedFrame.maxX, y: transposedFrame.minY + arrowLength)
//        let point6 = CGPoint(x: transposedFrame.maxX, y: transposedFrame.maxY)
//        let point7 = CGPoint(x: transposedFrame.minX, y: transposedFrame.maxY)
//        
//        // 3. Build our Bezier path
//        let path = UIBezierPath()
//        path.move(to: point1)
//        path.addLine(to: point2)
//        path.addLine(to: point3)
//        path.addLine(to: point4)
//        path.addLine(to: point5)
//        path.addLine(to: point6)
//        path.addLine(to: point7)
//        path.close()
//        
//        let degree180 = Measurement(value: 180, unit: UnitAngle.degrees)
//        let radian180 = degree180.converted(to: UnitAngle.gradians)
//        
//        
//        // 4. Rotate our path to fit orientation
//        switch orientation {
//        case .up, .upMirrored:
//        break // do nothing
//        case .down, .downMirrored:
//            path.apply(CGAffineTransform(rotationAngle: CGFloat(Measurement(value: 180.0, unit: UnitAngle.degrees).value)))
//            path.apply(CGAffineTransform(translationX: transposedFrame.size.width, y: transposedFrame.size.height))
//        case .left, .leftMirrored:
//            path.apply(CGAffineTransform(rotationAngle: CGFloat(Measurement(value: -90.0, unit: UnitAngle.degrees).value)))
//            path.apply(CGAffineTransform(translationX: 0, y: transposedFrame.size.width))
//        case .right, .rightMirrored:
//            path.apply(CGAffineTransform(rotationAngle: CGFloat(Measurement(value: 90.0, unit: UnitAngle.degrees).value)))
//            path.apply(CGAffineTransform(translationX: transposedFrame.size.height, y: 0))
//        }
//        
//        return path
//    }
    
}
