//
//  SettingsViewController.swift
//  BasicPlayer
//
//  Created by ItoShen on 5/13/19.
//  Copyright © 2019 ItoSchum. All rights reserved.
//

import UIKit

class PlaybackSettingsViewController: UITableViewController {
    
    static var hwAccelerationIsOn = true
    
    @IBOutlet weak var switchName: UILabel!
    @IBOutlet weak var hwAccelerationSwitch: UISwitch!
    @IBAction func hwAcceleration(_ sender: UISwitch) {
        if (sender.isOn == true) {
            PlaybackSettingsViewController.hwAccelerationIsOn = true
            print("HW Acceleration is ON now")
        } else {
            PlaybackSettingsViewController.hwAccelerationIsOn = false
            print("HW Acceleration is OFF now")
        }
    }
    
    func setupSwitch() {
        if PlaybackSettingsViewController.hwAccelerationIsOn == true {
            hwAccelerationSwitch.setOn(true, animated: false)
        } else {
            hwAccelerationSwitch.setOn(false, animated: false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switchName.text = "Hardware Acceleration"
        setupSwitch()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
