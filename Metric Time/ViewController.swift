//
//  ViewController.swift
//  Metric Time
//
//  Created by ACE on 2/15/16.
//  Copyright © 2016 Adrian Edwards. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var timeDisplay:UILabel?
    @IBOutlet var decimalDay:UILabel?
    @IBOutlet var metricTimeDisplay:UILabel?

    
    var components = NSCalendar.currentCalendar().components( [.Hour, .Minute, .Second], fromDate: NSDate())
    var timer = NSTimer();
    
    
    let color = UIColor.greenColor();
    let font = UIFont(name: "Calculator", size: 52.0);
    
    
    
    
    
    var metricDecimalDay:Float = 0 //shows how far you are through the day as a decimal (noon is .500000)
    
//  \/ used to calculate metricDecimalDay
    var metricDecimalHours:Double = 0
    var metricDecimalMinutes:Double = 0
    var metricDecimalSeconds:Double = 0
    
//  \/ used for displaying the metric decimal day as a clock would (i.e. 6:83:29 )
    var metricHours = 0
    var metricMinutes = 0
    var metricSeconds = 0
    
//  the actual time that normal humans use
    var hours = 0
    var minutes = 0
    var seconds = 0
    

    
    
    func updateTime() {
        //get current hour, minute and second
        components = NSCalendar.currentCalendar().components([ .Hour, .Minute, .Second], fromDate: NSDate())
        hours = components.hour;
        minutes = components.minute;
        seconds = components.second;
      
        calculateMetricTime()
        
        //display updated values
        timeDisplay?.text = String(format: "%02d : %02d : %02d", hours, minutes, seconds)
        decimalDay?.text = String(format: "%.5f", metricDecimalDay)
        metricTimeDisplay?.text = String(format: "%01d : %02d : %02d", metricHours, metricMinutes, metricSeconds)
        
        
    }
    
    func calculateMetricTime() {
        
        //update metricDecDay
        metricDecimalHours = Double(hours)/24
        metricDecimalMinutes = Double(minutes)/1440
        metricDecimalSeconds = Double(seconds)/86400
        
        metricDecimalDay = Float(metricDecimalHours + metricDecimalMinutes + metricDecimalSeconds)
        
        //calculate metric "hours", "minutes", and "seconds"
        //deciday = (int)(day * 10); milliday = (int)(day * 1000) % 100; msec = (int)(day * 100000) % 100;
        metricHours = Int(metricDecimalDay * 10)
        metricMinutes = Int(metricDecimalDay * 1000) % 100
        metricSeconds = Int(metricDecimalDay * 100000) % 100
    
       
    }
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //load the font and color the text boxes
        timeDisplay?.font = font
        decimalDay?.font = font
        metricTimeDisplay?.font = font
        timeDisplay?.textColor = color
        decimalDay?.textColor = color
        metricTimeDisplay?.textColor = color
        
        updateTime()
        
        //set timer
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "updateTime", userInfo: nil, repeats: true)
        timer.tolerance = 0.4
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        timer.invalidate()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

