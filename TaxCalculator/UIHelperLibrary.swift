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
    
    //MARK: Close keyboard by touching anywhere:
    //just say: self.hideKeyboardWhenTappedAround() in viewDidLoad()
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    
    //a test for adding a label
    func addLabel(what: String){
        var label = UILabel(frame: CGRectMake(0, 0, 200, 200))
        label.center = CGPointMake(100, 284)
        label.textAlignment = NSTextAlignment.Center
        label.text = what
        label.backgroundColor = UIColor.orangeColor()
        self.view.addSubview(label)
    
    }
    func addGreenButton(title: String, _ buttonaction:Selector, _ location_x: CGFloat = 100, _ location_y: CGFloat = 100, _ size_width: CGFloat = 100, _ size_height: CGFloat = 50){
        let button = UIButton(frame: CGRect(x: location_x, y: location_y, width: size_width, height: size_height))
        button.backgroundColor = UIColor.customGreenColor()
        button.setTitle(title, forState: .Normal)
        button.addTarget(self, action: buttonaction, forControlEvents: .TouchUpInside)
        self.view.addSubview(button)
        //buttonaction is a type of selector.
        //on your viewcontroller page, you should have
        //func buttonaction(sender:UIButton!)
        //{}
    }
    func addYellowButton(title: String, _ buttonaction:Selector, _ location_x: CGFloat = 100, _ location_y: CGFloat = 100, _ size_width: CGFloat = 100, _ size_height: CGFloat = 50){
        let button = UIButton(frame: CGRect(x: location_x, y: location_y, width: size_width, height: size_height))
        //button.backgroundColor = UIColor.customOrangeColor()
        button.backgroundColor =  UIColor(red: 245/255, green: 166/255, blue: 35/255, alpha: 0.62)
        button.setTitle(title, forState: .Normal)
        button.setTitleColor(UIColor.blackColor(), forState: .Normal)
        button.titleLabel!.font = UIFont(name: THINFONT, size: 14)
        button.addTarget(self, action: buttonaction, forControlEvents: .TouchUpInside)
        self.view.addSubview(button)
    
    }
    func addWhiteBorderButton(title: String, _ buttonaction:Selector, _ location_x: CGFloat, _ location_y: CGFloat, _ size_width: CGFloat, _ size_height: CGFloat){
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
    func addOrangeBorderButton(title: String, _ buttonaction:Selector, _ location_x: CGFloat, _ location_y: CGFloat, _ size_width: CGFloat, _ size_height: CGFloat, _ tag: Int){
        let button = UIButton(frame: CGRect(x: location_x, y: location_y, width: size_width, height: size_height))
        button.tag = tag
        button.backgroundColor = .clearColor()
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.customOrangeColor().CGColor
        button.setTitle(title, forState: .Normal)
        button.setTitleColor(UIColor.customOrangeColor(), forState: .Normal)
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
    
    func addTextField( placeholder: String = "Enter your value", _ tag: Int , _ location_x: CGFloat = 20, _ location_y: CGFloat = 100){
        let sampleTextField = UITextField(frame: CGRectMake(location_x, location_y, self.view.bounds.width - (43 * 2), 40))
        sampleTextField.placeholder = placeholder
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
    func addImage(name: String , _ location_x : CGFloat = 0, _ location_y: CGFloat =  0, _ imageWidth: CGFloat = 121, _ imageHeight : CGFloat = 121  ){
        let imageName = name
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: location_x, y: location_y, width: imageWidth, height: imageHeight)
        self.view.addSubview(imageView)
        
    }
    func addTextView(placeholder: String, _ textTag : Int, _ location_x : CGFloat, _ location_y: CGFloat){
        let textView = UITextView(frame: CGRectMake(location_x, location_y, self.view.bounds.width - (43 * 2),145) )
        //textView.frame = CGRect(x: location_x, y: location_y, width: self.view.bounds.width - (43 * 2), height: 145)
        textView.text = placeholder
        textView.tag = textTag
        textView.textColor = UIColor.lightGrayColor()
        
        textView.setBottomBorder(UIColor.customOrangeColor())
        
        self.view.addSubview(textView)
    }
}


extension UIView {
    // Add a single label
    func addGreenLabel(what: String, _ location_x : CGFloat = 0, _ location_y: CGFloat = 0, _ width : CGFloat = 0 , _ height : CGFloat = 49){
        //290, 49
        var h = location_y
        var w = location_x
        var wd = width
        if h == 0 {
            h = self.bounds.height/2
        }
        if w == 0 {
            w = self.bounds.width/2
        }
        if width == 0 {
            wd = self.bounds.width-86
        }
        var label = UILabel(frame: CGRectMake(0, 0,wd  , height))
        label.center = CGPointMake(w, h)
        label.textAlignment = NSTextAlignment.Center
        label.text = what
        label.backgroundColor = UIColor.customLabelGreen()
        //label.font = UIFont(name: THINFONT, size: 18)
        self.addSubview(label)
        
    }
    //This is used to add a paragraph
    func addText(what: String, _ location_x : CGFloat = 0, _ location_y: CGFloat = 0, _ width : CGFloat = 0 , _ height : CGFloat = 49){
        //290, 49
        var h = location_y
        var w = location_x
        var wd = width
        if h == 0 {
            h = self.bounds.height/2
        }
        if w == 0 {
            w = self.bounds.width/2
        }
        if width == 0 {
            wd = self.bounds.width-86
        }
        var label = UILabel(frame: CGRectMake(0, 0,wd  , height))
        label.center = CGPointMake(w, h)
        //label.textAlignment = NSTextAlignment.Center
        label.textAlignment = NSTextAlignment.Left
        label.text = what
        label.font = UIFont(name: THINFONT, size: 18)
        //label.backgroundColor = UIColor.customLabelGreen()
        label.lineBreakMode = .ByWordWrapping
        label.numberOfLines = 0
        self.addSubview(label)
        
    }
    
    func addImage(name: String , _ location_x : CGFloat = 0, _ location_y: CGFloat =  0, _ imageWidth: CGFloat = 121, _ imageHeight : CGFloat = 121  ){
        let imageName = name
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: location_x, y: location_y, width: imageWidth, height: imageHeight)
        self.addSubview(imageView)
        
    }
    func addTextView(placeholder: String, _ textTag : Int, _ location_x : CGFloat, _ location_y: CGFloat, _ width_w : CGFloat = 300){
        let textView = UITextView()
        textView.frame = CGRect(x: location_x, y: location_y, width: width_w, height: 145)
        textView.text = placeholder
        textView.tag = textTag
        textView.textColor = UIColor.lightGrayColor()
        
        textView.setBottomBorder(UIColor.customOrangeColor())
        
        self.addSubview(textView)
    }
    func addYellowButton(title: String, _ buttonaction:Selector, _ location_x: CGFloat = 100, _ location_y: CGFloat = 100, _ size_width: CGFloat = 100, _ size_height: CGFloat = 50, _ target: UIViewController){
        let button = UIButton(frame: CGRect(x: location_x, y: location_y, width: size_width, height: size_height))
        //button.backgroundColor = UIColor.customOrangeColor()
        button.backgroundColor =  UIColor(red: 245/255, green: 166/255, blue: 35/255, alpha: 0.62)
        button.setTitle(title, forState: .Normal)
        button.setTitleColor(UIColor.blackColor(), forState: .Normal)
        button.titleLabel!.font = UIFont(name: THINFONT, size: 14)
        button.addTarget(target, action: buttonaction, forControlEvents: .TouchUpInside)
        self.addSubview(button)
        
    }
   
    func addLabelGreenButton(title: String, _ buttonaction:Selector, _ location_x: CGFloat = 100, _ location_y: CGFloat = 100, _ size_width: CGFloat = 100, _ size_height: CGFloat = 50, _ target: UIViewController){
        let button = UIButton(frame: CGRect(x: location_x, y: location_y, width: size_width, height: size_height))
        //button.backgroundColor = UIColor.customOrangeColor()
        //button.backgroundColor =  UIColor(red: 245/255, green: 166/255, blue: 35/255, alpha: 0.62)
        button.backgroundColor = UIColor.customLabelGreen()
        button.setTitle(title, forState: .Normal)
        button.setTitleColor(UIColor.blackColor(), forState: .Normal)
       // button.titleLabel!.font = UIFont(name: THINFONT, size: 14)
        button.addTarget(target, action: buttonaction, forControlEvents: .TouchUpInside)
        self.addSubview(button)

    }
    func addOrangeBorderButton(title: String, _ buttonaction:Selector, _ location_x: CGFloat, _ location_y: CGFloat, _ size_width: CGFloat, _ size_height: CGFloat, _ tag: Int, _ target : UIViewController!){
        let button = UIButton(frame: CGRect(x: location_x, y: location_y, width: size_width, height: size_height))
        button.tag = tag
        button.backgroundColor = .clearColor()
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.customOrangeColor().CGColor
        button.setTitle(title, forState: .Normal)
        button.setTitleColor(UIColor.customOrangeColor(), forState: .Normal)
        button.addTarget(target, action: buttonaction, forControlEvents: .TouchUpInside)
       // button.userInteractionEnabled = true
        self.addSubview(button)
        //buttonaction is a type of selector.
        //on your viewcontroller page, you should have
        //func buttonaction(sender:UIButton!)
        //{}
    }
    
    
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
    
    
    //This is just used to return a value
    
    func returnTextField(placeholder: String = "Enter your value",  _ location_x: CGFloat = 20, _ location_y: CGFloat = 100, _ width : CGFloat = 300)->UITextField{
        let sampleTextField = UITextField(frame: CGRectMake(location_x, location_y, width , 40))
        // sampleTextField.tintColor = UIColor.customOrangeColor()
        // sampleTextField.backgroundColor = UIColor.clearColor()
        sampleTextField.placeholder = placeholder
        //sampleTextField.font = UIFont.systemFontOfSize(18)
        sampleTextField.autocorrectionType = UITextAutocorrectionType.No
        sampleTextField.keyboardType = UIKeyboardType.Default
        sampleTextField.returnKeyType = UIReturnKeyType.Done
        sampleTextField.clearButtonMode = UITextFieldViewMode.WhileEditing;
        sampleTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
       // sampleTextField.tag = tag
        
        //sampleTextField.delegate = myview
        
        sampleTextField.setBottomBorder(UIColor.customOrangeColor())
        
        
        self.addSubview(sampleTextField)
        return sampleTextField

    }
    func addTextField( placeholder: String = "Enter your value", _ tag : Int, _ location_x: CGFloat = 20, _ location_y: CGFloat = 100, _ width : CGFloat = 300){
        let sampleTextField = UITextField(frame: CGRectMake(location_x, location_y, width , 40))
       // sampleTextField.tintColor = UIColor.customOrangeColor()
       // sampleTextField.backgroundColor = UIColor.clearColor()
        sampleTextField.placeholder = placeholder
        //sampleTextField.font = UIFont.systemFontOfSize(18)
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
        
        var textFields = [UITextField]()
        
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
        let width = CGFloat(2.5)
        border.borderColor = color.CGColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width,   width:  self.frame.size.width, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
extension UITextView{
    func setBottomBorder(color: UIColor)
    {
        //self.borderStyle = UITextBorderStyle.None;
        
        let border = CALayer()
        let width = CGFloat(2.5)
        border.borderColor = color.CGColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width,   width:  self.frame.size.width, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}

