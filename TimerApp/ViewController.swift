//
//  ViewController.swift
//  TimerApp
//
//  Created by mj on 2016. 11. 20..
//  Copyright © 2016년 demo. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var roundBtn: UIButton!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var stopwatchTime: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    var counter = 1
    var startTime = TimeInterval()
    var timer: Timer = Timer()
    var timeArray: NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func start(_ sender: Any) {
        hideStartBtn(hide: true)
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(ViewController.updateTime), userInfo: nil, repeats: true)
        startTime = Date.timeIntervalSinceReferenceDate
        timeArray.removeAllObjects()
        tableView.reloadData()
        counter = 1
    }
    
    func updateTime(){
        let currentTime = Date.timeIntervalSinceReferenceDate
        var elapsedTime : TimeInterval = currentTime - startTime
        
        let minutes = UInt8(elapsedTime / 60.0)
        elapsedTime -= (TimeInterval(minutes)*60)
        
        let seconds = UInt8(elapsedTime)
        elapsedTime -= TimeInterval(seconds)
        
        let fraction = UInt8(elapsedTime*100)
        
        let strMinutes = minutes > 9 ? String(minutes) : "0" + String(minutes)
        let strSeconds = seconds > 9 ? String(seconds) : "0" + String(seconds)
        let strFraction = fraction > 9 ? String(fraction) : "0" + String(fraction)
        
        stopwatchTime.text = "\(strMinutes):\(strSeconds):\(strFraction)"
        
    }
    
    @IBAction func stop(_ sender: Any) {
        hideStartBtn(hide: false)
        timer.invalidate()
    }
    
    @IBAction func round(_ sender: Any) {
        //hideStartBtn(hide: false)
        timeArray.add(" \(counter) -> " + stopwatchTime.text!)
        counter += 1
        tableView.reloadData()
    }
    
    func hideStartBtn(hide : Bool){
        if hide {
            startBtn.isHidden = true
            stackView.isHidden = false
            roundBtn.isHidden = false
            stopBtn.isHidden = false
        } else {
            startBtn.isHidden = false
            stackView.isHidden = true
            roundBtn.isHidden = true
            stopBtn.isHidden = true
        }
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return timeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell: UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        cell.textLabel!.text = timeArray.object(at: indexPath.row) as? String
        
        return cell
    }
}

