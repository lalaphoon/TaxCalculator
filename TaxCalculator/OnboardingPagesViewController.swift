//
//  OnboardingPagesViewController.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-07-13.
//  Copyright © 2016 WTC Tax. All rights reserved.
//

import UIKit

class OnboardingPagesViewController: UIPageViewController , UIPageViewControllerDataSource{

    override func viewDidLoad() {
        super.viewDidLoad()
        //Initial settings
        setViewControllers([getStepZero()], direction: .forward, animated: false, completion: nil)
        self.dataSource = self

        // Do any additional setup after loading the view.
        
    }
    func getStepZero() -> StepZero{
        return storyboard!.instantiateViewController(withIdentifier: "StepZero") as! StepZero
    }
    func getStepOne() -> StepOne {
        return storyboard!.instantiateViewController(withIdentifier: "StepOne") as! StepOne
    }
    func getStepTwo() -> StepTwo {
        return storyboard!.instantiateViewController(withIdentifier: "StepTwo") as! StepTwo
    }
    func getStepThree() -> StepThree {
        return storyboard!.instantiateViewController(withIdentifier: "StepThree") as! StepThree
    }
    func getStepFour() -> StepFour {
        return storyboard!.instantiateViewController(withIdentifier: "StepFour") as! StepFour

    }
    func getStart() -> StartViewController {
        return storyboard!.instantiateViewController(withIdentifier: "StartView") as! StartViewController
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if viewController.isKind(of: StepFour.self){
            return getStepThree()
        }
        else if viewController.isKind(of: StepThree.self){
            return getStepTwo()
        }
        else if viewController.isKind(of: StepTwo.self){
            return getStepOne()
        }else if viewController.isKind(of: StepOne.self){
            return getStepZero()
        }else{
            return nil
        }
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if viewController.isKind(of: StepZero.self){
            return getStepOne()
        }
        else if viewController.isKind(of: StepOne.self){
            return getStepTwo()
        }
        else if viewController.isKind(of: StepTwo.self){
            return getStepThree()
        }
        else if viewController.isKind(of: StepThree.self){
            return getStepFour()
        }
        
        else
        {
            return nil
        }
        
    }
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return 5
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
