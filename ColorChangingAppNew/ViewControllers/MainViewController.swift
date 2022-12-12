//
//  MainViewController.swift
//  ColorChangingAppNew
//
//  Created by Sergey Kosichkin on 11.12.2022.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setNewColor(for viewColor: UIColor)
}


class MainViewController: UIViewController {

    
    private var viewColor = UIColor(red: CGFloat(0.55),
                                    green: CGFloat(0.65),
                                    blue: CGFloat(0.75),
                                    alpha: CGFloat(1))
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = viewColor
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else {
            return
        }
        settingsVC.viewColor = viewColor
        settingsVC.delegate = self
    }
}



extension MainViewController: SettingsViewControllerDelegate {
    func setNewColor(for viewColor: UIColor) {
        self.viewColor = viewColor
    }
}
