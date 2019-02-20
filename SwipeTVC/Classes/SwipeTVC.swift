// Main File For SwipeTableViewCell

//class SwipeTVC
import Foundation
import UIKit
public class SwipeTVC: UITableViewCell {
    
    var rightSwipe:UIPanGestureRecognizer!
    var swipeView: UIView!
    var behindView: UIView!
    var mainView: UIView!
    
    public func setUp(userBehindView: UIView, slideAreaFrame: CGRect, userMainView: UIView){
//        let width = (slideAreaWidth ? slideAreaWidth : CGFloat(self.frame.width))
//        let height = (slideAreaHeight ? slideAreaHeight : CGFloat(self.frame.height))
        behindView = userBehindView
        mainView = userMainView
        self.addSubview(mainView)
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
            break
            
            
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
