//
//  TimerLabel.swift
//  PicViewer
//
//  Created by Ильяяя on 21.05.2022.
//

import UIKit

class TimerLabel: UILabel {

    private var _isError = false
    var isError:Bool{
        set{
            _isError = newValue
            if _isError {
                self.text = "Next image in ∞ sec"
                print("Timer error setted")
            }
            timeCount = timeCountDefault - 1
        }
        get{
            _isError
        }
    }
    private var timeCount:Int
    private let timeCountDefault:Int
    private var timer = Timer()
    private let complition:() -> Void
    
    init(timeCount:Int, complition: @escaping () -> Void ) {
        self.complition = complition
        self.timeCountDefault = timeCount
        self.timeCount = timeCountDefault
        super.init(frame: UIScreen.main.bounds)
        
        self.style()
        self.complition()
        createTimer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func createTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _timer in
                
            if self.timeCount > 0{
                if !self._isError {
                    self.text = String("Next image in \(self.timeCount) sec")
                }
                self.timeCount -= 1
            }
            else{
                self.timeCount = self.timeCountDefault-1
                if !self._isError {
                    self.text = "Next image in \(self.timeCountDefault) sec"
                }
                
                self.complition()
            }
        }
    }
    
    func style()
    {
        layer.cornerRadius = 20
        clipsToBounds = true
        backgroundColor = UIColor.white.withAlphaComponent(0.4)
        font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.thin)
        textAlignment = .center
    }

}
