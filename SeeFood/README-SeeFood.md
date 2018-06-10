# SeeFood

CoreML App. Take a picture and check if object in image is a hotdog.

## Getting Started

Go to Apple's Machine Learning, run a model homepage [here](https://developer.apple.com/machine-learning/run-a-model/).  Scroll down to Inception v3 and click **Download Core ML Model** to download a zip file.  Drag the **Inceptionv3.mlmodel** file and move it into the file structure of your xCode project file. Make sure the checkbox for **Destination: COpy items if needed** is checked.  And then click the **Finish** button.

### Prerequisites

Before you start coding, download Inception v3 and copy the file into your xCode project (see directions above).

```
Inception v3
```

### Import Frameworks

Import the frameworks below in your view controller:
```
import CoreML
import Vision
```

### Declare Delegates

Declear the delegates below in your view controller:
```
UIImagePickerControllerDelegate
UINavigationControllerDelegate
```

## Built With

* [Udemy CoreML Tutorial](https://www.udemy.com/ios-11-app-development-bootcamp/learn/v4/t/lecture/7554160?start=0) - The tutorial used to build this app

## Authors

* **Andrew Jenson** - *Initial work* - [SeeFood_CoreML](https://github.com/awjenson/SeeFood_CoreML)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

*I would like to thank Udemy and the Complete iOS App Development Bootcamp course that I used to learn how to build this app.

