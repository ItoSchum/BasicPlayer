//
//  PlayerViewSegue.swift
//  BasicPlayer
//
//  Created by ItoShen on 5/23/19.
//  Copyright © 2019 ItoSchum. All rights reserved.
//

import UIKit

class PlayerViewSegue: UIStoryboardSegue {
    
    override func perform() {
        if !PlaybackSettingsViewController.hwAccelerationIsOn {
            // self.source.present(self.destination as UIViewController, animated: false, completion: nil)
            scale()
        }
    }
    
    func scale() {
        let toViewController = self.destination
        let fromViewController = self.source
        
        let containView = fromViewController.view.superview
        let originalCenter = fromViewController.view.center
        
        toViewController.view.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
        toViewController.view.center = originalCenter
        
        containView?.addSubview(toViewController.view)
        
        UIView.animate(withDuration: 0.5, animations: {
            toViewController.view.transform = CGAffineTransform.identity
        }, completion: { success in fromViewController.present(toViewController, animated: false, completion: nil)
        })
    }
    
}


class UnwindSegue: UIStoryboardSegue {
    
    override func perform() {
        scale()
    }
    
    func scale() {
        let toViewController = self.destination
        let fromViewController = self.source
        
        fromViewController.view.superview?.insertSubview(toViewController.view, at: 0)
        
        UIView.animate(withDuration: 0.5, animations: {
            fromViewController.view.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
        }, completion: { success in
            fromViewController.dismiss(animated: false, completion: nil)
        })
    }
    
}
