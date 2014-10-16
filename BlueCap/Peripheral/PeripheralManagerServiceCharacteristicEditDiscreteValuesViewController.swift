//
//  PeripheralManagerServiceCharacteristicEditDiscreteValuesViewController.swift
//  BlueCap
//
//  Created by Troy Stribling on 8/20/14.
//  Copyright (c) 2014 gnos.us. All rights reserved.
//

import UIKit
import BlueCapKit

class PeripheralManagerServiceCharacteristicEditDiscreteValuesViewController : UITableViewController {
    
    var characteristic                  : MutableCharacteristic?
    var peripheralManagerViewController : PeripheralManagerViewController?

    struct MainStoryboard {
        static let peripheralManagerServiceCharacteristicDiscreteValueCell  = "PeripheralManagerServiceCharacteristicEditDiscreteValueCell"
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let characteristic = self.characteristic {
            self.navigationItem.title = characteristic.name
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"didBecomeActive", name:BlueCapNotification.didBecomeActive, object:nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"didResignActive", name:BlueCapNotification.didResignActive, object:nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func didResignActive() {
        Logger.debug("PeripheralManagerServiceCharacteristicEditDiscreteValuesViewController#didResignActive")
    }
    
    func didBecomeActive() {
        Logger.debug("PeripheralManagerServiceCharacteristicEditDiscreteValuesViewController#didBecomeActive")
    }

    // UITableViewDataSource
    override func numberOfSectionsInTableView(tableView:UITableView) -> Int {
        return 1
    }
    
    override func tableView(_:UITableView, numberOfRowsInSection section:Int) -> Int {
        if let characteristic = self.characteristic {
            return characteristic.discreteStringValues.count
        } else {
            return 0
        }
    }
    
    override func tableView(tableView:UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(MainStoryboard.peripheralManagerServiceCharacteristicDiscreteValueCell, forIndexPath:indexPath) as UITableViewCell
        if let characteristic = self.characteristic {
            let stringValue = characteristic.discreteStringValues[indexPath.row]
            cell.textLabel!.text = stringValue
            if let value = characteristic.stringValues?[characteristic.name] {
                if value == stringValue {
                    cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                } else {
                    cell.accessoryType = UITableViewCellAccessoryType.None
                }
            }
        }
        return cell
    }
    
    // UITableViewDelegate
    override func tableView(tableView:UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
        if let characteristic = self.characteristic {
            let stringValue = [characteristic.name:characteristic.discreteStringValues[indexPath.row]]
            characteristic.updateValueWithString(stringValue)
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
}
