//
//  ThemeChooser.swift
//  Concentration
//
//  Created by Samuel Germain on 2019-10-30.
//  Copyright © 2019 Sam G. All rights reserved.
//

import UIKit

class ThemeVC: UIViewController, UISplitViewControllerDelegate{
    
    @IBAction func changeTheme(_ sender: UIButton) {
        if let cvc = splitViewDetailConcentrationVC{
            if let themeName = sender.currentTitle{
                cvc.theme = Theme(theme: themeName)
            }
        }else if let cvc = lastSeguedVC{
            if let themeName = sender.currentTitle{
                cvc.theme = Theme(theme: themeName)
            }
            navigationController?.pushViewController(cvc, animated: true)
        }else{
            performSegue(withIdentifier: "ThemeChooser", sender: sender)
        }
    }
    
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if let cvc = secondaryViewController as? ConcentrationViewController {
            if cvc.theme == nil{
                return true
            }
        }
        return false
    }
        
    
    
    private var splitViewDetailConcentrationVC: ConcentrationViewController?{
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    private var lastSeguedVC: ConcentrationViewController?
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "ThemeChooser"{
            if let themeName = (sender as? UIButton)?.currentTitle{
                if let cvc = segue.destination as? ConcentrationViewController{
                    let theme = Theme(theme: themeName)
                    cvc.theme = theme
                    lastSeguedVC = cvc
                }
            }
        }
    }
    
}
