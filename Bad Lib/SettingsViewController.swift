//
//  SettingsViewController.swift
//  Bad Lib
//
//  Created by Peter Frost on 20/08/2017.
//  Copyright © 2017 Peter Frost. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController, UIPopoverPresentationControllerDelegate, ChangeSelectionDelegate, ChangeSliderDelegate, ChangeOffensivenessDelegate {
    
    let defaults = UserDefaults.standard
    var currentSlider: Int = 0
    var screenSize = CGRect()
    var screenWidth: CGFloat = 0.0
    var screenHeight: CGFloat = 0.0
    
    @IBOutlet weak var pitchSliderLabel: UILabel!
    @IBOutlet weak var speedSliderLabel: UILabel!
    @IBOutlet weak var accentCell: UITableViewCell!
    @IBOutlet weak var offensivenessSliderLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = false
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        let voiceAccent = defaults.object(forKey: "voiceAccent") as? String ?? "en-GB"
        let voicePitch = defaults.object(forKey: "voicePitch") as? Float ?? 1.0
        let voiceSpeed = defaults.object(forKey: "voiceSpeed") as? Float ?? 0.5
        let wordOffensiveness = defaults.object(forKey: "wordOffensiveness") as? Int ?? 0
        
        switch voiceAccent {
        case "en-GB":
            accentCell.detailTextLabel?.text = "British"
        case "en-IE":
            accentCell.detailTextLabel?.text = "Irish"
        case "en-US":
            accentCell.detailTextLabel?.text = "American"
        case "en-AU":
            accentCell.detailTextLabel?.text = "Australian"
        case "en-ZA":
            accentCell.detailTextLabel?.text = "South African"
        default:
            accentCell.detailTextLabel?.text = "British"
            print("ERROR: fallen back to the default in viewDidLoad, SettingsViewController")
        }
        
        SetOffensivenessLabel(wordOffensiveness: wordOffensiveness)
        
        pitchSliderLabel.text = String(format: "%.0f", voicePitch * 100) + "%"
        speedSliderLabel.text = String(format: "%.0f", voiceSpeed * 100) + "%"
    }
    
    func renameAccentLabel(text: String?) {
        accentCell.detailTextLabel?.text = text
    }
    
    func ChangeSwitch(switched: Bool) {
        defaults.set(switched, forKey: "wordOffensivenessExclusiv")
        
        if (offensivenessSliderLabel.text!.contains("polite")) {
            SetOffensivenessLabel(wordOffensiveness: 0)
        } else if (offensivenessSliderLabel.text!.contains("mildly")) {
            SetOffensivenessLabel(wordOffensiveness: 1)
        }  else if (offensivenessSliderLabel.text!.contains("very")) {
            SetOffensivenessLabel(wordOffensiveness: 2)
        }  else if (offensivenessSliderLabel.text!.contains("extreme")) {
            SetOffensivenessLabel(wordOffensiveness: 3)
        }
    }
    
    func ChangeSlider(value: Float) {
        if (currentSlider == 1) {
            pitchSliderLabel.text = String(format: "%.0f", value * 100) + "%"
        } else if (currentSlider == 2) {
            speedSliderLabel.text = String(format: "%.0f", value * 100) + "%"
        } else if (currentSlider == 3) {
            SetOffensivenessLabel(wordOffensiveness: Int(value))
        }
    }
    
    func SetOffensivenessLabel(wordOffensiveness: Int) {
        var mutableText = NSMutableAttributedString()
        let exclusive = defaults.object(forKey: "wordOffensivenessExclusiv") as? Bool ?? false
        
        switch wordOffensiveness {
        case 0:
            mutableText = NSMutableAttributedString().normal("Use ").bold("polite").normal(" words")
        case 1:
            mutableText = NSMutableAttributedString().normal("Use ").bold("mildly offensive").normal(" words")
        case 2:
            mutableText = NSMutableAttributedString().normal("Use ").bold("very offensive").normal(" words")
        case 3:
            mutableText = NSMutableAttributedString().normal("Use ").bold("extreme").normal(" words")
        default:
            mutableText = NSMutableAttributedString().normal("Use ").bold("polite").normal(" words")
            print("ERROR: Fallen back to the default in SetOffensivenessLabel in SettingsViewController")
        }
        
        if (exclusive == true) {
            mutableText.append(NSAttributedString(string: " exclusively"))
        } else {
            mutableText.mutableString.replaceOccurrences(of: " exclusively", with: "", range: NSRange.init(location: 0, length: mutableText.length))
        }
        offensivenessSliderLabel.attributedText = mutableText
    }
    
    func FinishedSliding(finalValue: Float) {
        if (currentSlider == 1) {
            defaults.set(finalValue, forKey: "voicePitch")
        } else if (currentSlider == 2) {
            defaults.set(finalValue, forKey: "voiceSpeed")
        } else if (currentSlider == 3) {
            defaults.set(finalValue, forKey: "wordOffensiveness")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if (indexPath.section == 0) {
            switch indexPath.row {
            case 0:
                let popoverContent = self.storyboard!.instantiateViewController(withIdentifier: "AccentPopover") as! PopoverTableViewController
                popoverContent.delegate = self
                let nav = UINavigationController(rootViewController: popoverContent)
                nav.modalPresentationStyle = UIModalPresentationStyle.popover
                let popover = nav.popoverPresentationController!
                popoverContent.preferredContentSize = CGSize(width: 500, height: 200)
                popover.delegate = self
                popover.sourceView = tableView.cellForRow(at: indexPath)
                popover.sourceRect = (tableView.cellForRow(at: indexPath)?.bounds)!
                popover.permittedArrowDirections = .up
                self.present(nav, animated: true, completion: nil)
            case 1,2:
                currentSlider = indexPath.row
                let popoverContent = self.storyboard!.instantiateViewController(withIdentifier: "SliderPopover") as! PopoverSliderViewController
                if (currentSlider == 1) {
                    popoverContent.sliderMaximum = 2
                    popoverContent.sliderMinimum = 0.5
                    popoverContent.sliderDefault = defaults.object(forKey: "voicePitch") as? Float ?? 1.0
                } else if (currentSlider == 2) {
                    popoverContent.sliderMaximum = 0.8
                    popoverContent.sliderMinimum = 0
                    popoverContent.sliderDefault = defaults.object(forKey: "voiceSpeed") as? Float ?? 0.5
                }
                popoverContent.delegate = self
                let nav = UINavigationController(rootViewController: popoverContent)
                nav.modalPresentationStyle = UIModalPresentationStyle.popover
                let popover = nav.popoverPresentationController!
                popoverContent.preferredContentSize = CGSize(width: 500, height: 1)
                popover.delegate = self
                popover.sourceView = tableView.cellForRow(at: indexPath)
                popover.sourceRect = (tableView.cellForRow(at: indexPath)?.bounds)!
                popover.permittedArrowDirections = .up
                self.present(nav, animated: true, completion: nil)
            default:
                print("ERROR: fallen back to the default in didSelectRowAt section 0 in SettingsViewController")
            }
        } else if (indexPath.section == 1) {
            switch indexPath.row {
            case 0:
                currentSlider = tableView.numberOfRows(inSection: 0) + indexPath.row
                let popoverContent = self.storyboard!.instantiateViewController(withIdentifier: "OffensivenessPopover") as! PopoverOffensivenessViewController
                popoverContent.delegate = self
                popoverContent.sliderDefault = defaults.object(forKey: "wordOffensiveness") as? Float ?? 0.0
                popoverContent.excSwitchEnabled = defaults.object(forKey: "wordOffensivenessExclusiv") as? Bool ?? false
                let nav = UINavigationController(rootViewController: popoverContent)
                nav.modalPresentationStyle = UIModalPresentationStyle.popover
                let popover = nav.popoverPresentationController!
                popoverContent.preferredContentSize = CGSize(width: 500, height: 45)
                popover.delegate = self
                popover.sourceView = tableView.cellForRow(at: indexPath)
                popover.sourceRect = (tableView.cellForRow(at: indexPath)?.bounds)!
                popover.permittedArrowDirections = .up
                self.present(nav, animated: true, completion: nil)
            default:
                print("ERROR: fallen back to the default in didSelectRowAt section 1 in SettingsViewController")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return CGFloat(30)
        }
        return tableView.sectionHeaderHeight
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    } //Magically makes popovers work
    
    // MARK: - Table view data source
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension NSMutableAttributedString {
    @discardableResult func bold(_ text:String) -> NSMutableAttributedString {
        let attrs:[NSAttributedString.Key:AnyObject] = [NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue) : UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.bold)]
        let boldString = NSMutableAttributedString(string:"\(text)", attributes:attrs)
        self.append(boldString)
        return self
    }
    
    @discardableResult func normal(_ text:String)->NSMutableAttributedString {
        let normal =  NSAttributedString(string: text)
        self.append(normal)
        return self
    }
}

