//
//  CustomPickerViewController.swift
//  PickersEricW
//
//  Created by Eric J Witowski on 2/19/18.
//  Copyright © 2018 Eric J Witowski. All rights reserved.
//

import UIKit
import AudioToolbox



class CustomPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    private var images:[UIImage]!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    private var winSoundID: SystemSoundID = 0
    private var crunchSoundID: SystemSoundID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        images = [
            UIImage(named: "seven")!,
            UIImage(named: "bar")!,
            UIImage(named: "crown")!,
            UIImage(named: "cherry")!,
            UIImage(named: "lemon")!,
            UIImage(named: "apple")!]
        winLabel.text = " "
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func spin(sender: UIButton) {
        var win = false
        var numInRow = -1
        var lastVal = -1
        
        for i in 0..<5 {
            let newValue = Int(arc4random_uniform(UInt32(images.count)))
            if newValue == lastVal {
                numInRow+=1
            } else { numInRow = 1 }
            lastVal = newValue
            picker.selectRow(newValue, inComponent: i, animated: true)
            picker.reloadComponent(i)
            if numInRow >= 3 {
                win = true
            }
        }
        if crunchSoundID == 0 {
            let soundURL = Bundle.main.urlForResource("crunch", withExtension: "wav")! as CFURL
            AudioServicesCreateSystemSoundID(soundURL, &crunchSoundID)
        }
        AudioServicesPlaySystemSound(crunchSoundID)
        if win {
            DispatchQueue.main.after(when: .now() + 0.5) {
                self.playWinSound()
            }
        } else {
            DispatchQueue.main.after(when: .now() + 0.5) {
                self.showButton()
            }
        }
        button.isHidden = true
        winLabel.text = " "
        //winLabel.text = win ? "WINNER!" : " "
    }
    
    // MARK:-
    // MARK: Picker data source methods
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 5
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return images.count
    }
    
    // MARK:-
    // MARK: picker delegatge methods
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
        let image = images[row]
        let imageView = UIImageView(image: image)
        return imageView
    }
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 64
    }
    
    func showButton(){
        button.isHidden = false
    }
    func playWinSound(){
        if winSoundID == 0 {
            let soundURL = Bundle.main.url( forResource: "win", withExtension: "wav")! as CFURL
            AudioServicesCreateSystemSoundID(soundURL, &winSoundID)
        }
        AudioServicesPlaySystemSound(winSoundID)
        winLabel.text = "WINNER!"
        DispatchQueue.main.after(when: .now() + 1.5){
            self.showButton()
        }
    }
}
