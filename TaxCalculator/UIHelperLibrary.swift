//
//  Library.swift
//  TaxCalculator
//
//  Created by Mengyi LUO on 2016-07-13.
//  Copyright © 2016 WTC Tax. All rights reserved.
//
//Hopefully, it can help us to add componnets
import UIKit

extension UIViewController {
    //a test for adding a label
    func addLabel(what: String){
        var label = UILabel(frame: CGRectMake(0, 0, 200, 21))
        label.center = CGPointMake(160, 284)
        label.textAlignment = NSTextAlignment.Center
        label.text = what
        self.view.addSubview(label)
    
    }
    func addButton(title: String, _ buttonaction:Selector){
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        button.backgroundColor = UIColor.customGreenColor()
        button.setTitle(title, forState: .Normal)
        button.addTarget(self, action: buttonaction, forControlEvents: .TouchUpInside)
        self.view.addSubview(button)
        //buttonaction is a type of selector.
        //on your viewcontroller page, you should have
        //func buttonaction(sender:UIButton!)
        //{}
    }
    func addWhiteButton(title: String, _ buttonaction:Selector, _ location_x: CGFloat, _ location_y: CGFloat, _ size_width: CGFloat, _ size_height: CGFloat){
        let button = UIButton(frame: CGRect(x: location_x, y: location_y, width: size_width, height: size_height))
        button.backgroundColor = .clearColor()
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.whiteColor().CGColor
        button.setTitle(title, forState: .Normal)
        button.addTarget(self, action: buttonaction, forControlEvents: .TouchUpInside)
        self.view.addSubview(button)
        //buttonaction is a type of selector.
        //on your viewcontroller page, you should have
        //func buttonaction(sender:UIButton!)
        //{}
    }
    
    func addBlackLayer(myview: UIViewController){
        /*let gradientLayer: CAGradientLayer = CAGradientLayer()
        let color = UIColor.customBackgroundColor(60)
        gradientLayer.frame = myview.view.frame
        gradientLayer.colors = [color]
        //gradientLayer.locations = [0.0]
        myview.view.layer.insertSublayer(gradientLayer, atIndex:  0 )*/
        var blackCover: UIView = UIView()
        blackCover.frame = myview.view.frame
        blackCover.backgroundColor = UIColor.customBackgroundColor(60)
        blackCover.layer.opacity = 1.0
        myview.view.addSubview(blackCover)
        
    }
    func addBackgroundImage(imagename: String, _ myview: UIViewController){
        myview.view.backgroundColor = UIColor(patternImage: UIImage (named: imagename)!)
    }
    func addTextField( placeholder: String = "Enter your value", _ tag: Int){
        let sampleTextField = UITextField(frame: CGRectMake(20, 100, 300, 40))
        sampleTextField.tintColor = UIColor.customOrangeColor()
        sampleTextField.backgroundColor = UIColor.clearColor()
        sampleTextField.placeholder = placeholder
        sampleTextField.font = UIFont.systemFontOfSize(15)
        sampleTextField.autocorrectionType = UITextAutocorrectionType.No
        sampleTextField.keyboardType = UIKeyboardType.Default
        sampleTextField.returnKeyType = UIReturnKeyType.Done
        sampleTextField.clearButtonMode = UITextFieldViewMode.WhileEditing;
        sampleTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        sampleTextField.tag = tag
        

        //sampleTextField.delegate = myview
       
        sampleTextField.setBottomBorder(UIColor.customOrangeColor())
        
        
        self.view.addSubview(sampleTextField)
    }
}


extension UIView {
    func addBackground(imagename: String) {
        // screen width and height:
        let width = UIScreen.mainScreen().bounds.size.width
        let height = UIScreen.mainScreen().bounds.size.height
        
        let imageViewBackground = UIImageView(frame: CGRectMake(0, 0, width, height))
        imageViewBackground.image = UIImage(named: imagename )
        
        // you can change the content mode:
        imageViewBackground.contentMode = UIViewContentMode.ScaleAspectFill
        
        self.addSubview(imageViewBackground)
        self.sendSubviewToBack(imageViewBackground)
    }
    func darken(opacity: CGFloat){
        var blackCover: UIView = UIView()
        blackCover.frame = self.frame
        blackCover.backgroundColor = UIColor.customBackgroundColor(opacity)
        blackCover.layer.opacity = 1.0
        self.addSubview(blackCover)
    }
    func addWhiteButton(title: String, _ buttonaction:Selector, _ location_x: CGFloat, _ location_y: CGFloat, _ size_width: CGFloat, _ size_height: CGFloat){
        let button = UIButton(frame: CGRect(x: location_x, y: location_y, width: size_width, height: size_height))
        button.backgroundColor = .clearColor()
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.whiteColor().CGColor
        button.setTitle(title, forState: .Normal)
        button.addTarget(self, action: buttonaction, forControlEvents: .TouchUpInside)
        self.addSubview(button)
        //buttonaction is a type of selector.
        //on your viewcontroller page, you should have
        //func buttonaction(sender:UIButton!)
        //{}
    }
    func addTextField( placeholder: String = "Enter your value", _ tag : Int){
        let sampleTextField = UITextField(frame: CGRectMake(20, 100, 300, 40))
        sampleTextField.tintColor = UIColor.customOrangeColor()
        sampleTextField.backgroundColor = UIColor.clearColor()
        sampleTextField.placeholder = placeholder
        sampleTextField.font = UIFont.systemFontOfSize(15)
        sampleTextField.autocorrectionType = UITextAutocorrectionType.No
        sampleTextField.keyboardType = UIKeyboardType.Default
        sampleTextField.returnKeyType = UIReturnKeyType.Done
        sampleTextField.clearButtonMode = UITextFieldViewMode.WhileEditing;
        sampleTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        sampleTextField.tag = tag
        
        //sampleTextField.delegate = myview
        
        sampleTextField.setBottomBorder(UIColor.customOrangeColor())
        
        
        self.addSubview(sampleTextField)
        
        /* =========================get a text of uitextfild by tag ==========================
        
        http://stackoverflow.com/questions/31281352/how-to-get-text-from-programmatically-added-uitextview-swift
        
        for var index = 0; index < 3; ++index {
        var textField = UITextField(frame: CGRectMake(0, 0, 300, 40))
        var pom:CGFloat = 130 + CGFloat(index*50)
        textField.center = CGPointMake(185, pom)
        textField.layer.borderWidth = 1.0;
        textField.layer.cornerRadius = 5.0;
        textField.textAlignment = NSTextAlignment.Center
        textField.tag = index
        self.textFields.append( textField )
        self.view.addSubview(textField)
        }
        
        
        
        for var index = 0; index < 3; ++index {
            if let textField = self.textFieldForTag( index ) {
                print( textField.text )
            }
        }
        
        
        func textFieldForTag(tag: Int) -> UITextField? {
            return self.textFields.filter({ $0.tag == tag }).first
        }
        
        */

    }
   
 
    
  

}

extension UITextField{
    func setBottomBorder(color: UIColor)
    {
        self.borderStyle = UITextBorderStyle.None;
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = color.CGColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width,   width:  self.frame.size.width, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}

