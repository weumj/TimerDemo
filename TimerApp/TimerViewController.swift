//
//  TimerViewController.swift
//  TimerApp
//
//  Created by mj on 2016. 11. 20..
//  Copyright © 2016년 demo. All rights reserved.
//

import UIKit
import Foundation

class TimerViewController: UIViewController {

    @IBOutlet weak var btnStackView: UIStackView!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var minuteSlider: UISlider!{
        didSet{
            minuteSlider.transform = CGAffineTransform.init(rotationAngle: CGFloat(-M_PI_2))
        }
    }
    @IBOutlet weak var secondSlider: UISlider!{
        didSet{
            secondSlider.transform = CGAffineTransform.init(rotationAngle: CGFloat(-M_PI_2))
        }
    }
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    var counter = 0
    var timer = Timer()
    var timerIsRunning = false
    var stopWasPressed = false
    var lastValue = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func start(_ sender: Any) {
        if !timerIsRunning {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            
            if stopWasPressed {
                counter = lastValue
            } else {
                counter += Int(secondSlider.value) + Int(minuteSlider.value) * 60
            }
            timerLabel.text = "\(counter)"
        }
        stopWasPressed = false
        hideStartBtn(hide: true)
        timerIsRunning = true
        timerLabel.backgroundColor = UIColor.white
    }
    
    func updateTimer(){
        counter -= 1;
        timerLabel.text = "\(counter)"
        
        if counter < 0 {
            counter = 0;
            timerLabel.text = "Time's UP!!!"
            timerLabel.backgroundColor = UIColor.red
            timer.invalidate()
            stopWasPressed = false
            hideStartBtn(hide: false)
            timerIsRunning = false
        }
    }
    
    @IBAction func stop(_ sender: Any) {
        timerIsRunning = false
        timer.invalidate()
        stopWasPressed = true
        lastValue = counter
    }

    @IBAction func reset(_ sender: Any) {
        hideStartBtn(hide: false)
        timerIsRunning = false
        counter = 0
        timer.invalidate()
        timerLabel.text = String(counter)
    }
    
    @IBAction func minuteSliderChanged(_ sender: Any) {
        minuteLabel.text = "\(Int(minuteSlider.value)) min"
    }
    
    @IBAction func secondSliderChanged(_ sender: Any) {
        secondLabel.text = "\(Int(secondSlider.value)) sec"
    }
    
    
    
    func hideStartBtn(hide : Bool){
        if hide {
            startBtn.isHidden = true
            btnStackView.isHidden = false
            resetBtn.isHidden = false
            stopBtn.isHidden = false
        } else {
            startBtn.isHidden = false
            btnStackView.isHidden = true
            resetBtn.isHidden = true
            stopBtn.isHidden = true
        }
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
