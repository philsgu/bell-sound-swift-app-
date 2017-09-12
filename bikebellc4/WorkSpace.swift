//
//  WorkSpace.swift
//  bikebellc4
//
//  Created by PHILLIP KIM on 9/6/17.
//  Copyright © 2017 PHILLIP KIM. All rights reserved.
//

import UIKit


class WorkSpace: CanvasController {

    var player = AudioPlayer("ding.m4a")
    var label: TextShape?
    var soundlabel: TextShape?
    var s: Switch!
    
    func audio() {
        player?.stop()
        //insert this to start from beginning
        player?.currentTime = 0
        player?.play()
        player?.volume = 1.0
    }
    func toggle() {
        if self.s.isOn == true {
            print ("It's on")
            soundlabel?.text = "Horn"
            soundlabel?.center = canvas.center
            canvas.add(soundlabel)
            player = AudioPlayer("horn.wav")
            audio()
        }
        else {
            print ("It's off")
            soundlabel?.text = "Bell"
            soundlabel?.center = canvas.center
            canvas.add(soundlabel)
            player = AudioPlayer("ding.m4a")
            audio()
            
        }
    }

    
    override func setup() {
        //disable screen lock
        UIApplication.shared.isIdleTimerDisabled = true
        
        //add a switch to the bottom for sound 2 effect
        s = Switch(thumb: SwitchThumb(), background: SwitchBackground())
        s.center = CGPoint(x: canvas.center.x, y: canvas.height * 5/6)
        canvas.add(s)
        
        //creates method on the toggle switch and calls
        s.addTarget(self, action: #selector(WorkSpace.toggle), for: UIControlEvents.valueChanged)
        
        soundlabel = TextShape(text: "Bell", font: Font(name: "Menlo-Regular", size: 20)!)!
        soundlabel?.fillColor = white
        soundlabel?.center = canvas.center
        
        
        //add a text label from the top
        let text = TextShape(text: "tap2sound", font: Font(name: "Menlo-Regular", size: 24)!)!
        text.fillColor = white
        text.center = Point(canvas.center.x, canvas.height * 0.15)
        label = text
        
        //background canvas view color
        canvas.backgroundColor = Color(red: 52, green: 209, blue: 168, alpha: 1.0)
        
        let c = Circle(center: canvas.center, radius: canvas.height/5)
        c.lineWidth = 60.0
     
      
        //action gesture
        let press = c.addLongPressGestureRecognizer { locations, center, state in
            switch state {
            case .began, .changed:
                c.fillColor = Color(red: random01(), green: random01(), blue: random01(), alpha: 1.0)
                c.strokeColor = Color(red: random01(), green: random01(), blue: random01(), alpha: 1.0)
                self.audio()
            default:
                c.fillColor = C4Blue
                c.strokeColor = C4Purple
                }
            }
        press.minimumPressDuration = 0.0
        
        canvas.add(c)
        canvas.add(label)
        canvas.add(soundlabel)

    }
}

