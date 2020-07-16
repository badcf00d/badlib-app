//
//  PopoverSliderViewController.swift
//  Bad Lib
//
//  Created by Peter Frost on 29/08/2017.
//  Copyright © 2017 Peter Frost. All rights reserved.
//

import UIKit

protocol ChangeSliderDelegate: class {
    func ChangeSlider(value: Float)
    func FinishedSliding(finalValue: Float)
}

class PopoverSliderViewController: UIViewController {
    weak var delegate: ChangeSliderDelegate?
    var sliderMaximum: Float = 1.0
    var sliderMinimum: Float = 0.0
    var sliderDefault: Float = 0.5
    
    @IBOutlet weak var slider: UISlider!
    @IBAction func SliderChanged(_ sender: UISlider) {
        delegate?.ChangeSlider(value: sender.value)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        slider.maximumValue = sliderMaximum
        slider.minimumValue = sliderMinimum
        slider.value = sliderDefault
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.FinishedSliding(finalValue: slider.value)
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
