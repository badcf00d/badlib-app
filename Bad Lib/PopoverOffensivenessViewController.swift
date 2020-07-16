//
//  PopoverOffensivenessViewController.swift
//  Bad Lib
//
//  Created by Peter Frost on 13/09/2017.
//  Copyright © 2017 Peter Frost. All rights reserved.
//

import UIKit

protocol ChangeOffensivenessDelegate: class {
    func ChangeSlider(value: Float)
    func FinishedSliding(finalValue: Float)
    func ChangeSwitch(switched: Bool)
}

class PopoverOffensivenessViewController: UIViewController {
    weak var delegate: ChangeOffensivenessDelegate?
    var sliderDefault: Float = 0
    let sliderStep: Float = 1
    var excSwitchEnabled = false
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var excSwitch: UISwitch!
    
    @IBAction func OffensivenessSliderValueChanged(_ sender: UISlider) {
        let roundedValue = round(sender.value / sliderStep) * sliderStep
        sender.value = roundedValue
        delegate?.ChangeSlider(value: roundedValue)
    }
    
    @IBAction func ExclusivelySwitchChanged(_ sender: UISwitch) {
        delegate?.ChangeSwitch(switched: sender.isOn)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.FinishedSliding(finalValue: slider.value)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        slider.value = sliderDefault
        excSwitch.isOn = excSwitchEnabled
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
