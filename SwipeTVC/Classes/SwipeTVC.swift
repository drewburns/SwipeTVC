// Main File For SwipeTableViewCell

//class SwipeTVC
import Foundation
import UIKit
public class SwipeTVC: UITableViewCell {
    
    var rightSwipe:UIPanGestureRecognizer!
    var swipeView: UIView!
    var behindView: UIView!
    
    public func setUp(userBehindView: UIView, slideAreaFrame: CGRect){
//        let width = (slideAreaWidth ? slideAreaWidth : CGFloat(self.frame.width))
//        let height = (slideAreaHeight ? slideAreaHeight : CGFloat(self.frame.height))
        behindView = userBehindView
        self.drawBehindView(behindView)
    
        self.drawSwipeView(frame: slideAreaFrame)
    }
    
    fileprivate func drawSwipeView(frame: CGRect){
        swipeView = UIView(frame: frame)
        swipeView.backgroundColor = UIColor.clear
        self.mainView.addSubview(swipeView)
        rightSwipe = UIPanGestureRecognizer(target: self, action:#selector(HomeTableViewCell.draggedView(_:)))
        swipeView.addGestureRecognizer(rightSwipe)
    }
    fileprivate func drawBehindView(behindView: UIView) {
        self.contentView.addSubview(behindView)
    }
    
    
    @objc func draggedView(_ sender:UIPanGestureRecognizer){
        switch sender.state {
        case .began:
            break
            
        case .changed:

            self.contentView.bringSubview(toFront: mainView)
            let translation = sender.translation(in: self.contentView)
            print("X Position : ", mainView.frame.minX)
            if mainView.frame.minX >= 200.0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                    UIView.animate(withDuration: 3, delay: 0.0, options: .curveEaseOut, animations: {
                        self.firstRewardSideLabel.alpha = 0.0
                        self.secondRewardSideLabel.alpha = 0.0
                        self.thirdRewardSideLabel.alpha = 0.0
                    }, completion: nil)
                })
            }
            mainView.center = CGPoint(x: mainView.center.x + translation.x, y: mainView.center.y )
            sender.setTranslation(CGPoint.zero, in: self.contentView)
            
            
        case .ended:
            let originalTransform = self.mainView.transform
            let xpos = CGFloat(0)
            let changeX =  xpos - self.mainView.frame.minX
            let scaledAndTranslatedTransform = originalTransform.translatedBy(x: changeX, y: 0)
            UIView.animate(withDuration: 0.7, animations: {
                self.mainView.transform = scaledAndTranslatedTransform
            })
            
        default: ()
        }
        
    }
}

extension UIPanGestureRecognizer {
    func isDown(view: UIView) -> Bool {
        let velocity2 : CGPoint = velocity(in: view)
        print("VELOCITRY: ", velocity2)
        if abs(velocity2.y) > 30 {
            print("Gesture is going up and down")
            return true
        } else {
            print("Gesture is going side to side")
            return false
        }
    }
}
