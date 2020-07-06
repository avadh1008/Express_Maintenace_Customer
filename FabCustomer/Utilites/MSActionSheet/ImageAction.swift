//
//  Filedgfg.swift
//  FabCustomer
//
//  Created by AmitSharma on 02/08/19.
//

import Foundation
import UIKit
import MobileCoreServices

class ImageAction: UIAlertController, UINavigationControllerDelegate  {
    
    fileprivate static var sheet : UIAlertController?
    static let instance = ImageAction()
    
    var  cropFigureType = 1
    var  cornerRadiousType : CGFloat = 0
    
    var clientVC : UIViewController?
    var cropVc : ImageCropperViewController?
    
    // Button names
    fileprivate var library = "Photo Library"
    fileprivate var frontCamera = "Front Camera"
    fileprivate var rearCamera = "Rear Camera"
    fileprivate var cancel = "Cancel"
    
    /// Create Full ActionSheet
    /// - parameters:
    ///   - vc: The view controller to show the ActionSheet at
    ///   - handler: The function that  will execute after the user took the image, also you get the optional UIImage
    func showFullActionSheet(on vc : UIViewController,handler : @escaping (_ : UIImage?) -> Void) {
        let sheet = create().addLibrary().addFrontCamera().addRearCamera().addCancelButton()
        sheet.show(on: vc){ (image : UIImage?) in
            handler(image)
        }
    }
    
    
    /// Create new ActionSheet
    /// - parameters:
    ///   - title: (_optional_) - A title for the ActionSheet, by default does not contain title
    ///   - message: (_optional_) - A message for the ActionSheet, by default does not contain title
    func create(title: String = "", message: String = "") -> ImageAction {
        if title.isEmpty && message.isEmpty{
            ImageAction.sheet = UIAlertController()
        }else{
            ImageAction.sheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        }
        return self
    }
    
    /// Presents Library button in ActionSheet
    /// - parameters:
    ///   - title: (_optional_) - A title for the button, by default the title is "Photo Library"
    ///   - destructive : (_optional_) - Apply destructive style for this action
    ///   - image: (_optional_) - Custom image for button, by default the image is "msactionsheet_library" from assets
    func addLibrary(title : String = "Photo Library",destructive style : Bool = false ,  image : UIImage? = nil) -> ImageAction{
        library = title
        let libraryAction = UIAlertAction(title: library, style : isDestructive(style), handler: handler)
        
        if let img : UIImage = image{ // client select different image
            libraryAction.image = img
        }else{
            if let img = UIImage(named: "msactionsheet_library") { //the image exists..
                libraryAction.image = img
            }
        }
        ImageAction.sheet?.addAction(libraryAction)
        return self
    }
    
    /// Presents Front Camera button in ActionSheet
    /// - parameters:
    ///   - title: (_optional_) - A title for the button, by default the title is "Front Camera"
    ///   - destructive : (_optional_) - Apply destructive style for this action
    ///   - image: (_optional_) - Custom image for button, by default the image is "msactionsheet_frontCam" from assets
    func addFrontCamera(title : String = "Front Camera",destructive style : Bool = false, image : UIImage? = nil) -> ImageAction{
        guard UIImagePickerController.isCameraDeviceAvailable(.front) else {
            return self
        }
        
        frontCamera = title
        let frontCamAction = UIAlertAction(title: frontCamera, style: isDestructive(style), handler: handler)
        
        if let img : UIImage = image{ // client select different image
            frontCamAction.image = img
        }else{
            if let img = UIImage(named: "msactionsheet_frontCam") { //the image exists..
                frontCamAction.image = img
            }
        }
        ImageAction.sheet?.addAction(frontCamAction)
        return self
        
    }
    
    /// Presents Rear Camera button in ActionSheet
    /// - parameters:
    ///   - title: (_optional_) - A title for the button, by default the title is "Rear Camera"
    ///   - destructive : (_optional_) - Apply destructive style for this action
    ///   - image: (_optional_) - Custom image for button, by default the image is "msactionsheet_rearCam" from assets
    func addRearCamera(title : String = "Rear Camera", destructive style : Bool = false , image : UIImage? = nil) -> ImageAction{
        guard UIImagePickerController.isCameraDeviceAvailable(.rear) else {
            return self
        }
        
        self.rearCamera = title
        let rearCamAction = UIAlertAction(title: rearCamera, style: isDestructive(style), handler: handler)
        
        if let img : UIImage = image{ // client select different image
            rearCamAction.image = img
        }else{
            if let img = UIImage(named: "msactionsheet_rearCam") { //the image exists..
                rearCamAction.image = img
            }
        }
        ImageAction.sheet?.addAction(rearCamAction)
        return self
    }
    
    
    /// Presents Cancel button in ActionSheet
    /// - parameters:
    ///   - title: (_optional_) - A title for the button, by default the title is "Cancel"
    func addCancelButton(title : String = "Cancel") -> ImageAction{
        cancel = title
        ImageAction.sheet?.addAction(UIAlertAction(title: cancel, style: .cancel, handler: nil))
        return self
    }
    
    
    /// Presents the builded ActionSheet on passed view controller.
    /// (Make sure this is the last method called!)
    /// - parameters:
    ///   - vc: The view controller to show the ActionSheet at
    func show(on vc : UIViewController, onFinishPicking  handler: @escaping (_ : UIImage?) -> Swift.Void){
        self.handler = handler
        clientVC = vc
        vc.present(ImageAction.sheet!, animated: true, completion: nil)
    }
    
    
    fileprivate func handler(_ action : UIAlertAction){
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        //picker.mediaTypes = [kUTTypeImage as String]
        
        switch action.title ?? "" {
        case library:
            picker.sourceType = .photoLibrary
        case rearCamera:
            picker.sourceType = .camera
            picker.cameraDevice = .rear
            picker.showsCameraControls = true
        case frontCamera:
            picker.sourceType = .camera
            picker.cameraDevice = .front
            picker.showsCameraControls = true
        default: return
        }
        
        clientVC?.present(picker, animated: true, completion: nil)
    }
    
    fileprivate var img : UIImage?
    
    /// Get the selected image by the user
    /// (Make sure this method called inside the onFinishPicking()  method or inside showFullActionSheet() handler)
    func getImage() -> UIImage?{
        return img ?? nil
    }
    
    // get info about selected image when finish picking
    
    
    /* func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
     
     // dismiss picker
     picker.dismiss(animated: true, completion: nil)
     // get image
     if let image = info[.originalImage] as? UIImage{
     img = image
     handler!(image)
     }
     
     reset()
     
     }*/
    
    fileprivate var handler : ((_ : UIImage?) -> Void)?
    
    /*  /// Event will execute after the user took the image
     /// - parameters:
     ///   - handler: The function that  will execute after the user took the image
     func onFinishPicking(handler : @escaping (_ : UIImage?) -> Swift.Void){
     self.handler = handler
     }*/
    
    /// Set color for ActionSheet
    /// - parameters:
    ///   - color: The color for actionsheet
    func tintColor(color : UIColor) -> ImageAction{
        ImageAction.sheet?.view.tintColor = color
        return self
    }
    
    
    fileprivate func isDestructive(_ destructive : Bool) -> UIAlertAction.Style {
        return destructive ? .destructive : .default
    }
    
    fileprivate func reset(){
        handler = nil
        img = nil
        clientVC = nil
        ImageAction.sheet = nil
    }
}


extension ImageAction : UIImagePickerControllerDelegate{
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage{
            guard let figure = ImageCropperConfiguration.ImageCropperFigureType(rawValue: cropFigureType) else { return }
            
            
            picker.dismiss(animated: false, completion: nil)
            openCropper(with: figure, image: image, cornerRadius: cornerRadiousType)
            
        }
        
        
    }
    
    func openCropper(with figure: ImageCropperConfiguration.ImageCropperFigureType, image: UIImage?, cornerRadius: CGFloat?) {
        guard let img = image else { return }
        var config = ImageCropperConfiguration(with: img, and: figure, cornerRadius: cornerRadius)
        config.showGrid = false
        if figure == .customRect {
            config.customRatio = CGSize(width: 6, height: 5)
        }
        
        config.backTintColor = .black
        config.backTitle = ""
        
        var croppedImage = img
        
        
        let cropper = ImageCropperViewController.initialize(with: config, completionHandler: { _croppedImage in
            guard let _img = _croppedImage else { return }
            croppedImage = _img
            
        }) {
            self.img = croppedImage
            self.handler!(croppedImage)
            self.reset()
            
            self.cropVc?.dismiss(animated: false, completion: nil)
        }
        cropVc = cropper
        self.clientVC?.present(cropper, animated: true)
        //self.clientVC?.navigationController?.
        // self.clientVC?.navigationController?.pushViewController(cropper, animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true, completion: nil)
        
        
        
    }
    
    
}

extension ImageAction : PKCCropDelegate{
    func pkcCropImage(_ viewController: PKCCropViewController, _ image: UIImage?, originalImage: UIImage?) {
        
        if let image = image{
            
            
            
            img = image
            handler!(image)
            
            reset()
            viewController.navigationController?.popViewController(animated: false)
        }
        
    }
    
    //If crop is canceled
    func pkcCropCancel(_ viewController: PKCCropViewController) {
        viewController.navigationController?.popViewController(animated: true)
        // viewController.dismiss(animated: true, completion: nil)
    }
    
    //Successful crop
    func pkcCropComplete(_ viewController: PKCCropViewController) {
        if viewController.tag == 0{
            viewController.navigationController?.popViewController(animated: true)
        }else{
            viewController.dismiss(animated: true, completion: nil)
        }
    }
}

