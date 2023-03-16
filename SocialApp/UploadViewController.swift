//
//  UploadViewController.swift
//  SocialApp
//
//  Created by Ali Can Kayaaslan on 15.03.2023.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Clickable ImageView for selector func
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(pickImage))
        imageView.addGestureRecognizer(gestureRecognizer)
        
    }
    
    //Selector Func for picking image from library
    @objc func pickImage() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true)
    }
    
    //DidfinishPickingMedia for when we select the photo from libary
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    
    
    @IBAction func uploadButtonClicked(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("Media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.2) {
            
            //Create and UUIDString for image names
            let uuid = UUID().uuidString
            
            let imageReference = mediaFolder.child("\(uuid).jpeg")
            
            imageReference.putData(data) { storagemetadata, error in
                if error != nil {
                    self.showErrorMessage(title: "Error!", message: error?.localizedDescription ?? "Error! Please Try Again...")
                } else {
                    imageReference.downloadURL { url, error in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            
                            if let imageUrl = imageUrl {
                                
                                //Create Database
                                let firestoreDatabase = Firestore.firestore()
                                let firestorePost = ["imageurl" : imageUrl, "comment" : self.commentTextField.text!, "email" : Auth.auth().currentUser!.email, "date" : FieldValue.serverTimestamp() ] as [String : Any]
                                
                                firestoreDatabase.collection("Post").addDocument(data: firestorePost) { error in
                                    if error != nil {
                                        self.showErrorMessage(title: "Error!", message: error?.localizedDescription ?? "Error! Please Try Again Later...")
                                    } else {
                                        //Database data create then go to Feed Section
                                        self.imageView.image = UIImage(named: "clickforpick")
                                        self.commentTextField.text = ""
                                        self.tabBarController?.selectedIndex = 0 //0-Feed 1-Upload 2-Settings
                                    }
                                }
                                
                            }
                        }
                    }
                }
            }
            
        }
        
    }
    
    func showErrorMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
}
