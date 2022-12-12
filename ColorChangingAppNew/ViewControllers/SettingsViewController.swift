//
//  SettingsViewController.swift
//  ColorChangingAppNew
//
//  Created by Work on 02.12.2022.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet var mainView: UIView!
    
    @IBOutlet var redValueLabel: UILabel!
    @IBOutlet var greenValueLabel: UILabel!
    @IBOutlet var blueValueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTF: UITextField!
    @IBOutlet var greenTF: UITextField!
    @IBOutlet var blueTF: UITextField!
    
    
    var viewColor = UIColor(red: 0,
                            green: 0,
                            blue: 0,
                            alpha: 0)
    
    private var color: (red: CGFloat,
                        green: CGFloat,
                        blue: CGFloat,
                        alpha: CGFloat)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        mainView.layer.cornerRadius = 15
        
        SetupUI()
        
        redTF.delegate = self
        greenTF.delegate = self
        blueTF.delegate = self
        
    }

    
    @IBAction func redSliderAction() {
        color.red = CGFloat(redSlider.value)
        setupColorValues(withColor: .red,
                         forLabel: true,
                         slider: false,
                         textField: true)
        
    }
    
    @IBAction func greenSliderAction() {
        color.green = CGFloat(greenSlider.value)
        setupColorValues(withColor: .green,
                         forLabel: true,
                         slider: false,
                         textField: true)
    }
    
    @IBAction func blueSliderAction() {
        color.blue = CGFloat(blueSlider.value)
        setupColorValues(withColor: .blue,
                         forLabel: true,
                         slider: false,
                         textField: true)
    }
    
    @IBAction func redTFAction() {
        color.red = color(fromString: redTF.text ?? "0")
        setupColorValues(withColor: .red,
                         forLabel: true,
                         slider: true,
                         textField: true)
        
    }
    
    @IBAction func greenTFAction() {
        color.green = color(fromString: greenTF.text ?? "0")
        setupColorValues(withColor: .green,
                         forLabel: true,
                         slider: true,
                         textField: true)
        
    }
    
    @IBAction func blueTFAction() {
        color.blue = color(fromString: blueTF.text ?? "0")
        setupColorValues(withColor: .blue,
                         forLabel: true,
                         slider: true,
                         textField: true)
    }
    
    
    @IBAction func doneButtonAction() {
        
    }
    
    
}



// MARK: Work With keyboard
extension SettingsViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    private func addDoneButtonOnNumpad(textField: UITextField) {
        
        let toolBar: UIToolbar = UIToolbar()
        toolBar.sizeToFit()
        
        toolBar.items = [UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
                                         target: nil,
                                         action: nil),
                         UIBarButtonItem(title: "Done",
                                         style: UIBarButtonItem.Style.done,
                                         target: textField,
                                         action: #selector(UITextField.resignFirstResponder))]
        textField.inputAccessoryView = toolBar
    }
    
}



// MARK: Values conversion
extension SettingsViewController {
    
    enum Coloring {
        case red
        case green
        case blue
    }
    
    
    private func string(fromColor color: CGFloat) -> String {
        String(format: "%.2f", color)
    }
    
    
    private func color(fromString string: String) -> CGFloat {
        guard var float = Float(string) else { return 0 }
        float = round(float * 100) / 100.0
        
        if float > 1 {
            float = 1
        } else if float < 0 {
            float = 0
        }
        
        return CGFloat(float)
    }
    
    
    private func animateSlider(with value: CGFloat, andColoring coloring: Coloring) {
        let float = Float(value)
        
        UIView.animate(withDuration: 0.2, animations: {
            switch coloring {
            case .red:
                self.redSlider.setValue(float, animated:true)
            case .green:
                self.greenSlider.setValue(float, animated:true)
            case .blue:
                self.blueSlider.setValue(float, animated:true)
            }
        })
    }
    
}



// MARK: Work with color
extension SettingsViewController {
    
    private func setupColorValues(withColor coloring: Coloring,
                                  forLabel label: Bool,
                                  slider: Bool,
                                  textField: Bool) {
        switch coloring {
        case .red:
            if label { redValueLabel.text = string(fromColor: color.red) }
            if slider { animateSlider(with: color.red, andColoring: .red) }
            if textField { redTF.text = string(fromColor: color.red) }
        case .green:
            if label { greenValueLabel.text = string(fromColor: color.green) }
            if slider { animateSlider(with: color.green, andColoring: .green) }
            if textField { greenTF.text = string(fromColor: color.green) }
        case .blue:
            if label { blueValueLabel.text = string(fromColor: color.blue) }
            if slider { animateSlider(with: color.blue, andColoring: .blue) }
            if textField { blueTF.text = string(fromColor: color.blue) }
        }
        changeColor()
    }
   
    
    private func changeColor() {
        mainView.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                           green: CGFloat(greenSlider.value),
                                           blue: CGFloat(blueSlider.value),
                                           alpha: 1)
    }
    
    
    private func SetupUI() {
        color = viewColor.rgba
        
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        
        addDoneButtonOnNumpad(textField: redTF)
        addDoneButtonOnNumpad(textField: greenTF)
        addDoneButtonOnNumpad(textField: blueTF)
        
        setupColorValues(withColor: .red, forLabel: true, slider: true, textField: true)
        setupColorValues(withColor: .green, forLabel: true, slider: true, textField: true)
        setupColorValues(withColor: .blue, forLabel: true, slider: true, textField: true)
        
        mainView.backgroundColor = viewColor
    }
    
}



// MARK: Work with UIColor
extension UIColor {
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (red, green, blue, alpha)
    }
}
