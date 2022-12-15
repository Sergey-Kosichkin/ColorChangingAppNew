//
//  SettingsViewController.swift
//  ColorChangingAppNew
//
//  Created by Work on 02.12.2022.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redValueLabel: UILabel!
    @IBOutlet var greenValueLabel: UILabel!
    @IBOutlet var blueValueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTF: UITextField!
    @IBOutlet var greenTF: UITextField!
    @IBOutlet var blueTF: UITextField!
    
    var delegate: SettingsViewControllerDelegate!
    
    var viewColor: UIColor!
    
    private var color: (red: CGFloat,
                        green: CGFloat,
                        blue: CGFloat,
                        alpha: CGFloat)!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 15
        
        SetupUI()
        
        redTF.delegate = self
        greenTF.delegate = self
        blueTF.delegate = self
        
    }

    
    @IBAction func redSliderAction() {
        color.red = CGFloat(redSlider.value)
        setupColorValues(forLabel: true,
                         textField: true,
                         slider: false,
                         withColor: .red)
        
    }
    
    @IBAction func greenSliderAction() {
        color.green = CGFloat(greenSlider.value)
        setupColorValues(forLabel: true,
                         textField: true,
                         slider: false,
                         withColor: .green)
    }
    
    @IBAction func blueSliderAction() {
        color.blue = CGFloat(blueSlider.value)
        setupColorValues(forLabel: true,
                         textField: true,
                         slider: false,
                         withColor: .blue)
    }
    
    @IBAction func redTFAction() {
        color.red = color(fromString: redTF.text ?? "0")
        setupColorValues(forLabel: true,
                         textField: true,
                         slider: true,
                         withColor: .red)
        
    }
    
    @IBAction func greenTFAction() {
        color.green = color(fromString: greenTF.text ?? "0")
        setupColorValues(forLabel: true,
                         textField: true,
                         slider: true,
                         withColor: .green)
        
    }
    
    @IBAction func blueTFAction() {
        color.blue = color(fromString: blueTF.text ?? "0")
        setupColorValues(forLabel: true,
                         textField: true,
                         slider: true,
                         withColor: .blue)
    }
    
    
    @IBAction func doneButtonAction() {
//        viewColor = UIColor(red: color.red,
//                            green: color.green,
//                            blue: color.blue,
//                            alpha: color.alpha)
        delegate.setNewColor(for: colorView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
    
    
}



// MARK: -Work With keyboard
extension SettingsViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    private func addDoneButtonOnNumpad(textFields: UITextField...) {
        
        for textField in textFields {
            
            let toolBar = UIToolbar()
            toolBar.sizeToFit()
            
            toolBar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                             target: nil,
                                             action: nil),
                             UIBarButtonItem(title: "Done",
                                             style: .done,
                                             target: textField,
                                             action: #selector(UITextField.resignFirstResponder))]
            textField.inputAccessoryView = toolBar
            
        }
    }
    
}



// MARK: -Values conversion
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
            
            guard var slider = self.redSlider else { return }
            
            switch coloring {
            case .red: break
            case .green: slider = self.greenSlider
            case .blue: slider = self.blueSlider
            }
            
            slider.setValue(float, animated:true)
        })
    }
    
}



// MARK: -Work with color
extension SettingsViewController {
    
    private func setupColorValues(forLabel label: Bool,
                                  textField: Bool,
                                  slider: Bool,
                                  withColor colorings: Coloring...) {
        for coloring in colorings {
            
            switch coloring {
            case .red:
                if label { redValueLabel.text = string(fromColor: color.red) }
                if textField { redTF.text = string(fromColor: color.red) }
                if slider { animateSlider(with: color.red, andColoring: .red) }
            case .green:
                if label { greenValueLabel.text = string(fromColor: color.green) }
                if textField { greenTF.text = string(fromColor: color.green) }
                if slider { animateSlider(with: color.green, andColoring: .green) }
            case .blue:
                if label { blueValueLabel.text = string(fromColor: color.blue) }
                if textField { blueTF.text = string(fromColor: color.blue) }
                if slider { animateSlider(with: color.blue, andColoring: .blue) }
            }
            
        }
        changeColor()
    }
   
    
    private func changeColor() {
        colorView.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                           green: CGFloat(greenSlider.value),
                                           blue: CGFloat(blueSlider.value),
                                           alpha: 1)
    }
    
    
    private func SetupUI() {
        color = viewColor.rgba
        
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        
        addDoneButtonOnNumpad(textFields: redTF, greenTF, blueTF)
        
        setupColorValues(forLabel: true,
                         textField: true,
                         slider: true,
                         withColor: .red, .green, .blue)
        
        colorView.backgroundColor = viewColor
    }
    
}



// MARK: -Work with UIColor
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
