//
//  PopoverTableViewController.swift
//  Bad Lib
//
//  Created by Peter Frost on 23/08/2017.
//  Copyright © 2017 Peter Frost. All rights reserved.
//

import UIKit

protocol ChangeSelectionDelegate: class {
    func renameAccentLabel(text: String?)
}

class PopoverTableViewController: UITableViewController {
    let defaults = UserDefaults.standard
    weak var delegate: ChangeSelectionDelegate?

    @IBOutlet var britishAccentCell: UITableViewCell!
    @IBOutlet var irishAccentCell: UITableViewCell!
    @IBOutlet var americanAccentCell: UITableViewCell!
    @IBOutlet var australianAccentCell: UITableViewCell!
    @IBOutlet var southAfricanAccentCell: UITableViewCell!
    
    var defaultCell: UITableViewCell? //All the defaultCell stuff is because .setSelected doesn't make the program aware a cell has been selected
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        let voiceAccent = defaults.object(forKey: "voiceAccent") as? String ?? "en-GB"
        
        switch voiceAccent {
        case "en-GB":
            britishAccentCell.accessoryType = .checkmark
            defaultCell = britishAccentCell
        case "en-IE":
            irishAccentCell.accessoryType = .checkmark
            defaultCell = irishAccentCell
        case "en-US":
            americanAccentCell.accessoryType = .checkmark
            defaultCell = americanAccentCell
        case "en-AU":
            australianAccentCell.accessoryType = .checkmark
            defaultCell = australianAccentCell
        case "en-ZA":
            southAfricanAccentCell.accessoryType = .checkmark
            defaultCell = southAfricanAccentCell
        default:
            britishAccentCell.accessoryType = .checkmark
            defaultCell = britishAccentCell
            print("ERROR: fallen back to the default in viewDidLoad, PopoverTableViewController")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        if (defaultCell != nil) {
            defaultCell?.accessoryType = .none
            defaultCell = nil
        }
        delegate?.renameAccentLabel(text: tableView.cellForRow(at: indexPath)?.textLabel?.text)
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        switch indexPath.row {
        case 0:
            defaults.set("en-GB", forKey: "voiceAccent")
        case 1:
            defaults.set("en-IE", forKey: "voiceAccent")
        case 2:
            defaults.set("en-US", forKey: "voiceAccent")
        case 3:
            defaults.set("en-AU", forKey: "voiceAccent")
        case 4:
            defaults.set("en-ZA", forKey: "voiceAccent")
        default:
            defaults.set("en-GB", forKey: "voiceAccent")
            print("ERROR: fallen back to the default in didSelectRowAt, PopoverTableViewController")
        }
    }
    
    // MARK: - Table view data source

    
    
     /*override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "AccentCell", for: indexPath)
     
     cell.detailTextLabel?.text = "blahblah"
     
     return cell
     }*/
    
    
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
