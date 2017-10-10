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
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    
    //a test for adding a label
    func addLabel(_ what: String){
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        label.center = CGPoint(x: 100, y: 284)
        label.textAlignment = NSTextAlignment.center
        label.text = what
        label.backgroundColor = UIColor.orange
        self.view.addSubview(label)
    
    }
    func addGreenButton(_ title: String, _ buttonaction:Selector, _ location_x: CGFloat = 100, _ location_y: CGFloat = 100, _ size_width: CGFloat = 100, _ size_height: CGFloat = 50){
        let button = UIButton(frame: CGRect(x: location_x, y: location_y, width: size_width, height: size_height))
        button.backgroundColor = UIColor.customGreenColor()
        button.setTitle(title, for: UIControlState())
        button.addTarget(self, action: buttonaction, for: .touchUpInside)
        self.view.addSubview(button)
        //buttonaction is a type of selector.
        //on your viewcontroller page, you should have
        //func buttonaction(sender:UIButton!)
        //{}
    }
    func addYellowButton(_ title: String, _ buttonaction:Selector, _ location_x: CGFloat = 100, _ location_y: CGFloat = 100, _ size_width: CGFloat = 100, _ size_height: CGFloat = 50){
        let button = UIButton(frame: CGRect(x: location_x, y: location_y, width: size_width, height: size_height))
        //button.backgroundColor = UIColor.customOrangeColor()
        button.backgroundColor =  UIColor(red: 254/255, green: 211/255, blue: 141/255, alpha: 1)
        button.setTitle(title, for: UIControlState())
        button.setTitleColor(UIColor.black, for: UIControlState())
        button.titleLabel!.font = UIFont(name: BIGTITLE, size: 14)
        button.addTarget(self, action: buttonaction, for: .touchUpInside)
       // button.installConstraints(self.view)
        self.view.addSubview(button)
    
    }
    func addWhiteBorderButton(_ title: String, _ buttonaction:Selector, _ location_x: CGFloat, _ location_y: CGFloat, _ size_width: CGFloat, _ size_height: CGFloat){
        let button = UIButton(frame: CGRect(x: location_x, y: location_y, width: size_width, height: size_height))
        button.backgroundColor = .clear
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.white.cgColor
        button.setTitle(title, for: UIControlState())
        button.addTarget(self, action: buttonaction, for: .touchUpInside)
        self.view.addSubview(button)
        //buttonaction is a type of selector.
        //on your viewcontroller page, you should have
        //func buttonaction(sender:UIButton!)
        //{}
    }
    func addOrangeBorderButton(_ title: String, _ buttonaction:Selector, _ location_x: CGFloat, _ location_y: CGFloat, _ size_width: CGFloat, _ size_height: CGFloat, _ tag: Int){
        let button = UIButton(frame: CGRect(x: location_x, y: location_y, width: size_width, height: size_height))
        button.tag = tag
        button.backgroundColor = .clear
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.customOrangeColor().cgColor
        button.setTitle(title, for: UIControlState())
        button.setTitleColor(UIColor.customOrangeColor(), for: UIControlState())
        button.addTarget(self, action: buttonaction, for: .touchUpInside)
        self.view.addSubview(button)
        //buttonaction is a type of selector.
        //on your viewcontroller page, you should have
        //func buttonaction(sender:UIButton!)
        //{}
    }
    
    func addBlackLayer(_ myview: UIViewController){
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
    func addBackgroundImage(_ imagename: String, _ myview: UIViewController){
        myview.view.backgroundColor = UIColor(patternImage: UIImage (named: imagename)!)
    }
    
    func addTextField( _ placeholder: String = "Enter your value", _ tag: Int , _ location_x: CGFloat = 20, _ location_y: CGFloat = 100){
        let sampleTextField = UITextField(frame: CGRect(x: location_x, y: location_y, width: self.view.bounds.width - (43 * 2), height: 40))
        sampleTextField.placeholder = placeholder
        sampleTextField.autocorrectionType = UITextAutocorrectionType.no
        sampleTextField.keyboardType = UIKeyboardType.default
        sampleTextField.returnKeyType = UIReturnKeyType.done
        sampleTextField.clearButtonMode = UITextFieldViewMode.whileEditing;
        sampleTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        sampleTextField.tag = tag
        

        //sampleTextField.delegate = myview
       
        sampleTextField.setBottomBorder(UIColor.customOrangeColor())
        
        
        self.view.addSubview(sampleTextField)
        
    }
    func addImage(_ name: String , _ location_x : CGFloat = 0, _ location_y: CGFloat =  0, _ imageWidth: CGFloat = 121, _ imageHeight : CGFloat = 121  ){
        let imageName = name
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: location_x, y: location_y, width: imageWidth, height: imageHeight)
        self.view.addSubview(imageView)
        
    }
    func addTextView(_ placeholder: String, _ textTag : Int, _ location_x : CGFloat, _ location_y: CGFloat){
        let textView = UITextView(frame: CGRect(x: location_x, y: location_y, width: self.view.bounds.width - (43 * 2),height: 145) )
        //textView.frame = CGRect(x: location_x, y: location_y, width: self.view.bounds.width - (43 * 2), height: 145)
        textView.text = placeholder
        textView.tag = textTag
        textView.textColor = UIColor.lightGray
        
        //textView.setBottomBorder(UIColor.customOrangeColor())
        
        self.view.addSubview(textView)
    }
}


extension UIView {
    // Add a single label
   // func addWarningLabel()
    func addGreenLabel(_ what: String, _ location_x : CGFloat = 0, _ location_y: CGFloat = 0, _ width : CGFloat = 0 , _ height : CGFloat = 49){
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
        let label = UILabel(frame: CGRect(x: 0, y: 0,width: wd  , height: height))
        label.center = CGPoint(x: w, y: h)
        label.textAlignment = NSTextAlignment.center
        label.text = what
        label.backgroundColor = UIColor.customLabelGreen()
        //label.font = UIFont(name: THINFONT, size: 18)
        self.addSubview(label)
        
    }
    // This is used to add a title/header
    func addHeader(_ what: String, _ location_x : CGFloat = 0, _ location_y: CGFloat = 0, _ width : CGFloat = 0 , _ height : CGFloat = 49){
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
        let label = UILabel(frame: CGRect(x: 0, y: 0,width: wd  , height: height))
        label.center = CGPoint(x: w, y: h)
        label.textAlignment = NSTextAlignment.center
        //label.textAlignment = NSTextAlignment.Left
        label.text = what
        //label.font = UIFont(name: THINFONT, size: 18)
        label.font = UIFont(name: BIGTITLE , size: 20)
        //label.backgroundColor = UIColor.customLabelGreen()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        self.addSubview(label)

    }
    //This is used to add a paragraph
    func addText(_ what: String, _ location_x : CGFloat = 0, _ location_y: CGFloat = 0, _ width : CGFloat = 0 , _ height : CGFloat = 49, _ textAlignment : NSTextAlignment = .center){
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
        let label = UILabel(frame: CGRect(x: 0, y: 0,width: wd  , height: height))
        label.center = CGPoint(x: w, y: h)
        label.textAlignment = textAlignment
        //label.textAlignment = NSTextAlignment.Left
        label.text = what
        label.font = UIFont(name: SMALLTITLE, size: 18)
        label.textColor =  UIColor.gray
        //label.backgroundColor = UIColor.customLabelGreen()
        //label.lineBreakMode = .ByTruncatingMiddle
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        self.addSubview(label)
        
    }
    
    func addImage(_ name: String , _ location_x : CGFloat = 0, _ location_y: CGFloat =  0, _ imageWidth: CGFloat = 121, _ imageHeight : CGFloat = 121  ){
        let imageName = name
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: location_x, y: location_y, width: imageWidth, height: imageHeight)
        self.addSubview(imageView)
        
    }
    func addTextView(_ placeholder: String, _ textTag : Int, _ location_x : CGFloat, _ location_y: CGFloat, _ width_w : CGFloat = 300, _ height_w : CGFloat = 500){
        let textView = UITextView()
        textView.frame = CGRect(x: location_x, y: location_y, width: width_w, height: height_w)
        textView.text = placeholder
        textView.tag = textTag
        textView.textColor = UIColor.lightGray
   
        //textView.setBottomBorder(UIColor.customOrangeColor())
        
        self.addSubview(textView)
    }
    func addYellowButton(_ title: String, _ buttonaction:Selector, _ location_x: CGFloat = 100, _ location_y: CGFloat = 100, _ size_width: CGFloat = 100, _ size_height: CGFloat = 50, _ target: UIViewController){
        let button = UIButton(frame: CGRect(x: location_x, y: location_y, width: size_width, height: size_height))
        //button.backgroundColor = UIColor.customOrangeColor()
        button.backgroundColor =  UIColor(red: 254/255, green: 211/255, blue: 141/255, alpha: 1)
        button.setTitle(title, for: UIControlState())
        button.setTitleColor(UIColor.black, for: UIControlState())
        button.titleLabel!.font = UIFont(name: BIGTITLE, size: 14)
        button.addTarget(target, action: buttonaction, for: .touchUpInside)
        //button.installConstraints(self)
        self.addSubview(button)
        
    }
    func addLinkButton(_ title: String, _ buttonaction: Selector, _ location_x: CGFloat = 100, _ location_y: CGFloat = 100, _ size_width: CGFloat = 100, _ size_height: CGFloat = 50, _ target: UIViewController){
        let button = UIButton(frame: CGRect(x: location_x, y: location_y, width: size_width, height: size_height))
        button.setTitle(title, for: UIControlState())
        button.setTitleColor(UIColor.customOrangeColor(), for: UIControlState())
        button.titleLabel!.font = UIFont(name: BIGTITLE, size:14)
        button.addTarget(target, action: buttonaction, for: .touchUpInside)
       // button.layer.borderWidth = 1.0
       // button.layer.borderColor = UIColor.customOrangeColor().CGColor
        let border = CALayer()
        let width = CGFloat(2.5)
        border.borderColor = UIColor.customOrangeColor().cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width,   width:  self.frame.size.width, height: self.frame.size.height)
        
        border.borderWidth = width
        button.layer.addSublayer(border)
        button.layer.masksToBounds = true

        self.addSubview(button)
    }
    func addImageButton(_ title: String, _ buttonaction: Selector, _ image: String, _ location_x: CGFloat = 100, _ location_y: CGFloat = 100, _ size_width: CGFloat = 100, _ size_height: CGFloat = 50, _ target: UIViewController){
        let button = UIButton(frame: CGRect(x: location_x, y: location_y, width: size_width, height: size_height))
        button.setTitle(title, for: UIControlState())
        button.setTitleColor(UIColor.orange, for:  UIControlState())
        //button.titleLabel!.font = UIFont(name: SMALLTITLE, size: 14)
        button.addTarget(target, action: buttonaction, for: .touchUpInside)
        let i:UIImage = UIImage(named: image)!
        button.setImage(i, for: UIControlState())
        
        button.centerTextAndImage(10)
        self.addSubview(button)
    }
    
    //http://stackoverflow.com/questions/2451223/uibutton-how-to-center-an-image-and-a-text-using-imageedgeinsets-and-titleedgei
    //=========This is used for aling image with a button ===========
    func setupButton(_ button: UIButton) {
        let spacing: CGFloat = 6.0
        let imageSize: CGSize = button.imageView!.image!.size
        button.titleEdgeInsets = UIEdgeInsetsMake(0.0, -imageSize.width, -(imageSize.height + spacing), 0.0)
        let labelString = NSString(string: button.titleLabel!.text!)
        let titleSize = labelString.size(attributes: [NSFontAttributeName: button.titleLabel!.font])
        button.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height + spacing), 0.0, 0.0, -titleSize.width)
        let edgeOffset = abs(titleSize.height - imageSize.height) / 2.0;
        button.contentEdgeInsets = UIEdgeInsetsMake(edgeOffset, 0.0, edgeOffset, 0.0)
    }
    //===================================
    func addLabelGreenButton(_ title: String, _ buttonaction:Selector, _ location_x: CGFloat = 100, _ location_y: CGFloat = 100, _ size_width: CGFloat = 100, _ size_height: CGFloat = 50, _ target: UIViewController){
        let button = UIButton(frame: CGRect(x: location_x, y: location_y, width: size_width, height: size_height))
        //button.backgroundColor = UIColor.customOrangeColor()
        //button.backgroundColor =  UIColor(red: 245/255, green: 166/255, blue: 35/255, alpha: 0.62)
        button.backgroundColor = UIColor.customLabelGreen()
       // button.backgroundColor = UIColor.customGreenColor()
        button.setTitle(title, for: UIControlState())
        button.setTitleColor(UIColor.black, for: UIControlState())
       // button.titleLabel!.font = UIFont(name: SMALLTITLE, size: 14)
        button.layer.shadowRadius = 3.0;
        button.layer.shadowColor = UIColor.blue.cgColor
        //button.layer.shadowColor = UIColor.chartBlueColor().CGColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
       button.layer.shadowOpacity = 0.5;
        button.layer.masksToBounds = false
        button.addTarget(target, action: buttonaction, for: .touchUpInside)
        self.addSubview(button)

    }
    func addOrangeBorderButton(_ title: String, _ buttonaction:Selector, _ location_x: CGFloat, _ location_y: CGFloat, _ size_width: CGFloat, _ size_height: CGFloat, _ tag: Int, _ target : UIViewController!){
        let button = UIButton(frame: CGRect(x: location_x, y: location_y, width: size_width, height: size_height))
        button.tag = tag
        button.backgroundColor = .clear
        button.layer.borderWidth = 2.5
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.customOrangeColor().cgColor
        button.setTitle(title, for: UIControlState())
        button.setTitleColor(UIColor.black, for: UIControlState())
        button.addTarget(target, action: buttonaction, for: .touchUpInside)
       
        //button.layer.shadowRadius = 3.0;
        //button.layer.shadowColor = UIColor.customBlackColor().CGColor
        //button.layer.shadowOffset = CGSizeMake(0.0, 1.0)
        //button.layer.shadowOpacity = 0.5;
        //button.layer.masksToBounds = false
        self.addSubview(button)
        //==================notes====================
        //buttonaction is a type of selector.
        //on your viewcontroller page, you should have
        //func buttonaction(sender:UIButton!)
        //{}
    }
    
    
    func addBackground(_ imagename: String) {
        // screen width and height:
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        let imageViewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        imageViewBackground.image = UIImage(named: imagename )
        
        // you can change the content mode:
        imageViewBackground.contentMode = UIViewContentMode.scaleAspectFill
        
        self.addSubview(imageViewBackground)
        self.sendSubview(toBack: imageViewBackground)
    }
    func darken(_ opacity: CGFloat){
        var blackCover: UIView = UIView()
        blackCover.frame = self.frame
        blackCover.backgroundColor = UIColor.customBackgroundColor(opacity)
        blackCover.layer.opacity = 1.0
        self.addSubview(blackCover)
    }
    func whiten(_ opacity: CGFloat){
        var blackCover: UIView = UIView()
        blackCover.frame = self.frame
        blackCover.backgroundColor = UIColor.customWhiteColor(opacity)
        blackCover.layer.opacity = 1.0
        self.addSubview(blackCover)
    }
    func addWhiteButton(_ title: String, _ buttonaction:Selector, _ location_x: CGFloat, _ location_y: CGFloat, _ size_width: CGFloat, _ size_height: CGFloat){
        let button = UIButton(frame: CGRect(x: location_x, y: location_y, width: size_width, height: size_height))
        button.backgroundColor = .clear
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.white.cgColor
        button.setTitle(title, for: UIControlState())
        button.addTarget(self, action: buttonaction, for: .touchUpInside)
        self.addSubview(button)
        //buttonaction is a type of selector.
        //on your viewcontroller page, you should have
        //func buttonaction(sender:UIButton!)
        //{}
    }
    func addWarningButton(_ title: String, _ buttonaction:Selector, _ location_x: CGFloat, _ location_y: CGFloat, _ size_width: CGFloat, _ size_height: CGFloat,_ target : UIViewController!, _ id: Int) -> UIButton{
    let button = UIButton(frame: CGRect(x: location_x, y: location_y, width: size_width, height: size_height))
    button.setTitle(title, for: UIControlState())
    button.setTitleColor(UIColor.chartRedColor(), for: UIControlState())
    button.addTarget(target, action: buttonaction, for: .touchUpInside)
    button.tag = id
    self.addSubview(button)
    return button
    }
    
    //This is used to return an uiswitch
    func returnSwitch(_ buttonAction: Selector, _ target : UIViewController, _ location_x : CGFloat, _ location_y: CGFloat) -> UISwitch{
        let switchDemo = UISwitch(frame: CGRect(x: location_x,y: location_y,width: 0,height: 0))
        switchDemo.isOn = false
        switchDemo.setOn(false, animated: true)
        //switchDemo.addTarget(target, action: buttonAction, forControlEvents: .ValueChanged)
        self.addSubview(switchDemo)
        return switchDemo
    }
    //=======================================
    /*
    func switchValueDidChange(sender: UISwitch!){
        if (sender.on == true) {
            prinln("on")
        } else {
            prinln("off")
        }
    }
    //=======================================
    */
    //This is just used to return a value
    func returnTextField(_ placeholder: String = "Enter your value",  _ location_x: CGFloat = 20, _ location_y: CGFloat = 100, _ width : CGFloat = 300)->UITextField{
        let sampleTextField = UITextField(frame: CGRect(x: location_x, y: location_y, width: width , height: 40))
        // sampleTextField.tintColor = UIColor.customOrangeColor()
        // sampleTextField.backgroundColor = UIColor.clearColor()
        sampleTextField.placeholder = placeholder
        //sampleTextField.font = UIFont.systemFontOfSize(18)
        sampleTextField.autocorrectionType = UITextAutocorrectionType.no
        sampleTextField.keyboardType = UIKeyboardType.default
        sampleTextField.returnKeyType = UIReturnKeyType.done
        sampleTextField.clearButtonMode = UITextFieldViewMode.whileEditing;
        sampleTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.center
       // sampleTextField.tag = tag
        
        //sampleTextField.delegate = myview
        
        sampleTextField.setBottomBorder(UIColor.customOrangeColor())
        
        
        self.addSubview(sampleTextField)
        return sampleTextField

    }
    func addTextField( _ placeholder: String = "Enter your value", _ tag : Int, _ location_x: CGFloat = 20, _ location_y: CGFloat = 100, _ width : CGFloat = 300){
        let sampleTextField = UITextField(frame: CGRect(x: location_x, y: location_y, width: width , height: 40))
       // sampleTextField.tintColor = UIColor.customOrangeColor()
       // sampleTextField.backgroundColor = UIColor.clearColor()
        sampleTextField.placeholder = placeholder
        //sampleTextField.font = UIFont.systemFontOfSize(18)
        sampleTextField.autocorrectionType = UITextAutocorrectionType.no
        sampleTextField.keyboardType = UIKeyboardType.default
        sampleTextField.returnKeyType = UIReturnKeyType.done
        sampleTextField.clearButtonMode = UITextFieldViewMode.whileEditing;
        sampleTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.center
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
    func setBottomBorder(_ color: UIColor)
    {
        self.borderStyle = UITextBorderStyle.none;
        let border = CALayer()
        let width = CGFloat(2.5)
        border.borderColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width,   width:  self.frame.size.width, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
extension UITextView{
    func setBottomBorder(_ color: UIColor)
    {
        //self.borderStyle = UITextBorderStyle.None;
        
        let border = CALayer()
        let width = CGFloat(2.5)
        border.borderColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width,   width:  self.frame.size.width, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
extension UIButton {
    func centerTextAndImage(_ spacing: CGFloat) {
        let insetAmount = spacing / 2
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
    }
    
    //这个function可能会不好使，还会crash程序本身。
    func installConstraints(_ parentView: UIView){
        
        let floatButtonRadius = 50
        let views = ["floatButton": self, "parentView": parentView]
        let width = NSLayoutConstraint.constraints(withVisualFormat: "H:[floatButton(\(floatButtonRadius))]", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: views)
        let height = NSLayoutConstraint.constraints(withVisualFormat: "V:[floatButton(\(floatButtonRadius))]", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: views)
        self.addConstraints(width)
        self.addConstraints(height)
        
        let trailingSpacing = NSLayoutConstraint.constraints(withVisualFormat: "V:[floatButton]-50-|", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: views)
        let bottomSpacing = NSLayoutConstraint.constraints(withVisualFormat: "H:[floatButton]-50-|", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: views)
        parentView.addConstraints(trailingSpacing)
        parentView.addConstraints(bottomSpacing)
        
    }

}

