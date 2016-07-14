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
        setViewControllers([getStepZero()], direction: .Forward, animated: false, completion: nil)
        self.dataSource = self

        // Do any additional setup after loading the view.
        
    }
    func getStepZero() -> StepZero{
        return storyboard!.instantiateViewControllerWithIdentifier("StepZero") as! StepZero
    }
    func getStepOne() -> StepOne {
        return storyboard!.instantiateViewControllerWithIdentifier("StepOne") as! StepOne
    }
    func getStepTwo() -> StepTwo {
        return storyboard!.instantiateViewControllerWithIdentifier("StepTwo") as! StepTwo
    }
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if viewController.isKindOfClass(StepTwo){
            return getStepOne()
        }else if viewController.isKindOfClass(StepOne){
            return getStepZero()
        }else{
            return nil
        }
    }
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if viewController.isKindOfClass(StepZero){
            return getStepOne()
        }
        else if viewController.isKindOfClass(StepOne){
            return getStepTwo()
        } else
        {
            return nil
        }
        
    }
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 3
    }
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
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
