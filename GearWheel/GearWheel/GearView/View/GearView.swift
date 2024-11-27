//
//  GearView.swift
//  GearWheel
//
//  Created by Евгений on 25.11.2024.
//

import UIKit

class GearView: UIView {
    private var upperRadius: CGFloat = 0 // Радиус верхних вершин зубцов
    private var lowerRadius: CGFloat = 0 // Радиус нижних вершин зубцов
    private var matingRadius: CGFloat = 0 // Радиус сопряжения
    private var teethCount: Int = 0 // Количество зубцов
    
    func setModel(model: GearModel) {
        self.upperRadius = model.upperRadius
        self.lowerRadius = model.lowerRadius
        self.matingRadius = model.matingRadius
        self.teethCount = model.teethCount
        self.setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        guard teethCount > 0,
              upperRadius > lowerRadius,
              matingRadius > 0,
              matingRadius <= (upperRadius - lowerRadius) / 2
        else {
            print("Неверные параметры")
            return
        }
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let path = CGMutablePath()
        let angleStep = 2 * CGFloat.pi / CGFloat(teethCount)
        
        var startPoint: CGPoint?
        var endPoint: CGPoint?
        
        for i in 0..<teethCount {
            let angle1 = CGFloat(i) * angleStep
            let angle2 = angle1 + angleStep / 2
            let angle3 = angle1 + angleStep
            
            let point1 = CGPoint(x: center.x + cos(angle1) * lowerRadius,
                                 y: center.y + sin(angle1) * lowerRadius)
            let point2 = CGPoint(x: center.x + cos(angle2) * upperRadius,
                                 y: center.y + sin(angle2) * upperRadius)
            let point3 = CGPoint(x: center.x + cos(angle3) * lowerRadius,
                                 y: center.y + sin(angle3) * lowerRadius)
            
            if i == 0 {
                path.move(to: point1)
                startPoint = point1
            }
            
            path.addArc(tangent1End: point1, tangent2End: point2, radius: matingRadius)
            path.addArc(tangent1End: point2, tangent2End: point3, radius: matingRadius)
            endPoint = point3
        }
        
        if let startPoint = startPoint, let endPoint = endPoint {
            path.addLine(to: startPoint)
        }
        
        path.closeSubpath()
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.addPath(path)
        context.setStrokeColor(UIColor.red.cgColor)
        context.setLineWidth(2.0)
        context.strokePath()
    }
}
