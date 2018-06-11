//
//  ViewController.swift
//  SeeFood
//
//  Created by Andrew Jenson on 12/21/17.
//  Copyright © 2017 Andrew Jenson. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!

    let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self

        // this allows the user to use the photo library
        // (If you had access to your phone, then you could replace with .camera, but the simulator only works with the photo library).
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
    }

    // What should happen once they picked an image, we should send the image to our Machine Learning model. So add a delegate method
    // This method comes from the UIImagePickerController class
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // use diectionary to retrieve the value of the key which is the image that was taken by the camera
        if let userPickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {

            // Next, set the selected image to the imageView for display
            // if this piece of data can be downcasted into a UIImage optional data type, then execute the code
            imageView.image = userPickedImage

            // convert UIImage into a Core Image Image which allows us to us the vision framework
            guard let ciimage = CIImage(image: userPickedImage) else {
                fatalError("Could not convert UIImage into a CIImage")
            }
            detect(image: ciimage)
        }

        // dismiss the imagePicker and go back to our view controller
        imagePicker.dismiss(animated: true, completion: nil)
    }

    func detect(image: CIImage) {
        // used to classify an image

        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("Loading CoreML Model Failed.")
        }

        let request = VNCoreMLRequest(model: model) { (request, error) in
            // we get two things back (request, error)
            // and after the request has completed, we want to process the results of the request.

            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model failed to process VNClassificationObservation request")
            }

            // Access first result (highest probabilty) from results
            if let firstResult = results.first {
                if firstResult.identifier.contains("hotdog") {
                    self.navigationItem.title = "Hotdog!"
                } else {
                    self.navigationItem.title = "Not Hotdog"
                }
            }
        }

        // create a handler that specifies the image we want to classify
        let handler = VNImageRequestHandler(ciImage: image)

        do {
            try handler.perform([request])
        } catch {
            print("Error: \(error)")
        }
    }

    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {

        // we have to specify when we want our imagePicker to appear
        present(imagePicker, animated: true, completion: nil)
    }

}
