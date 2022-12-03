//
//  ViewController.swift
//  ColorChangingAppNew
//
//  Created by Work on 02.12.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var mainView: UIView!
    @IBOutlet var redValueLabel: UILabel!
    @IBOutlet var greenValueLabel: UILabel!
    @IBOutlet var blueValueLabel: UILabel!
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.layer.cornerRadius = 15
        
        redSliderAction()
        greenSliderAction()
        blueSliderAction()
        
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
    }


    @IBAction func redSliderAction() {
        redValueLabel.text = toString(redSlider)
        changeColor()
    }
    
    @IBAction func greenSliderAction() {
        greenValueLabel.text = toString(greenSlider)
        changeColor()
    }
    
    @IBAction func blueSliderAction() {
        blueValueLabel.text = toString(blueSlider)
        changeColor()
    }
    
    
    private func toString(_ slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func changeColor() {
        mainView.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                           green: CGFloat(greenSlider.value),
                                           blue: CGFloat(blueSlider.value),
                                           alpha: 1)
    }
    
    
}

