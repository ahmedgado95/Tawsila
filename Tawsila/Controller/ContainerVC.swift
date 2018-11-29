//
//  ContainerVC.swift
//  Tawsila
//
//  Created by ahmed gado on 11/29/18.
//  Copyright © 2018 ahmed gado. All rights reserved.
//
import UIKit
import QuartzCore

enum SlideOutState {
    case collapsed
    case leftPanelExpanded
}
enum ShowWhichVC {
    case homeVC
}
var ShowVC:ShowWhichVC = .homeVC
class ContainerVc : UIViewController{
    var homeVC: HomeVc!
    var leftVC :LeftSidePanelVc!
    var centerController: UIViewController!
    var currentState: SlideOutState = .collapsed
    var isHidden = false
    let centerPanelExpandOffset: CGFloat = 160
    var tap:UITapGestureRecognizer!

    override func viewDidLoad() {
        initCenter(screen: ShowVC)
    }

func initCenter(screen: ShowWhichVC){
    var presentingController:UIViewController
    ShowVC = screen
    if  homeVC == nil{
        homeVC = UIStoryboard.homeVC()
        homeVC.delegate = self
    }
    presentingController = homeVC
    if let con = centerController {
        con.view.removeFromSuperview()
        con.removeFromParent()
        
    }
    centerController = presentingController
    view.addSubview(centerController.view)
    addChild(centerController)
    centerController.didMove(toParent: self)
    
  }
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation{
        return UIStatusBarAnimation.slide
    }
    override var prefersStatusBarHidden: Bool{
        return isHidden
    }

}
extension ContainerVc:CenterVCDelegate{
    func toggleLeftPanel() {
        let notAlreadyExpanded = (currentState != .leftPanelExpanded)
        if notAlreadyExpanded{
            addLeftPanelViewController()
        }
        animateLeftPanel(shouldExpand: notAlreadyExpanded)
    }
    
    func addLeftPanelViewController() {
        if leftVC == nil {
            leftVC = UIStoryboard.leftViewController()
            addchildSidePanelViewController(_sidePanelController: leftVC)
        }
    }
    func addchildSidePanelViewController(_sidePanelController:LeftSidePanelVc){
        view.insertSubview(_sidePanelController.view, at: 0)
        addChild(_sidePanelController)
        _sidePanelController.didMove(toParent: self)
    }
    
    @objc func animateLeftPanel(shouldExpand: Bool) {
        if shouldExpand{
            isHidden = !isHidden
            animateStatusBar()
            setupWhiteCoverView()
            currentState = .leftPanelExpanded
            animateCenterPanelXosition(targetposition: centerController.view.frame.width - centerPanelExpandOffset)
         
        }else{
            isHidden = !isHidden
            animateStatusBar()
            hideWhileCoverView()
            animateCenterPanelXosition(targetposition: 0) { (finished) in
                if finished == true {
                    self.currentState = .collapsed
                    self.leftVC = nil
                }
            }
        }
    }
    func animateCenterPanelXosition(targetposition:CGFloat,completion:((Bool)-> Void)! = nil){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.centerController.view.frame.origin.x = targetposition
        }, completion: completion)
        
    }
    func setupWhiteCoverView(){
        let whiteCoverView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        whiteCoverView.alpha = 0.0
        whiteCoverView.backgroundColor = UIColor.white
        whiteCoverView.tag = 25
        
        self.centerController.view.addSubview(whiteCoverView)
        UIView.animate(withDuration: 0.2){
            whiteCoverView.alpha = 0.75
        }
        tap = UITapGestureRecognizer(target: self, action: #selector(animateLeftPanel(shouldExpand:)))
        tap.numberOfTapsRequired = 1
        self.centerController.view.addGestureRecognizer(tap)
    }
    func hideWhileCoverView(){
        centerController.view.removeGestureRecognizer(tap)
        for subview in self.centerController.view.subviews{
            if subview.tag == 25 {
                UIView.animate(withDuration: 0.2, animations: {
                    subview.alpha = 0.0
                },completion:{(finished) in
                    subview.removeFromSuperview()
                })
            }
        }
    }
    func animateStatusBar(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.setNeedsStatusBarAppearanceUpdate()
        })
    }
    
}

class ContainerVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
private extension UIStoryboard{
    class func mainStrorybord() -> UIStoryboard{
        return UIStoryboard(name: "Main", bundle:Bundle.main)
    }
    class func leftViewController() -> LeftSidePanelVc?{
        return mainStrorybord().instantiateViewController(withIdentifier: "LeftSidePanelVC") as? LeftSidePanelVc
    }
    class func homeVC() -> HomeVc?{
        return mainStrorybord().instantiateViewController(withIdentifier: "HomeVC") as! HomeVc
    }
    
}






