//
//  ViewController.swift
//  GearWheel
//
//  Created by Евгений on 25.11.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var matingRadiusTextField: UITextField! // радиус сопряжения сторон зубца
    @IBOutlet weak var upperRadiusTextField: UITextField! // Радиус верхних вершин зубцов
    @IBOutlet weak var lowerRadiusTextField: UITextField! // Радиус нижних вершин зубцов
    @IBOutlet weak var teethCountTextField: UITextField! // Количество зубцов
    
    @IBOutlet weak var gearView: GearView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func drawGear(_ sender: UIButton) {
        if let matingRadius = Float(matingRadiusTextField.text ?? ""),
            let upperRadius = Float(upperRadiusTextField.text ?? ""),
            let lowerRadius = Float(lowerRadiusTextField.text ?? ""),
            let teethCount = Int(teethCountTextField.text ?? "") {
    
            gearView.setModel(model: .init(upperRadius: CGFloat(upperRadius), lowerRadius: CGFloat(lowerRadius), matingRadius: CGFloat(matingRadius), teethCount: teethCount))
        } else {
            print("Invalid input")
        }
    }
}

