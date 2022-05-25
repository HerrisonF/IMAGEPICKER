//
//  FinalViewController.swift
//  fotoroid
//
//  Created by Herrison Feres on 25/05/22.
//

import UIKit
import Photos

class FinalViewController: UIViewController {

    @IBOutlet weak var ivPhoto: UIImageView!
    
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ivPhoto.image = image
        ivPhoto.layer.borderWidth = 10
        ivPhoto.layer.borderColor = UIColor.white.cgColor
    }
    
    func saveToAlbum(){
        PHPhotoLibrary.shared().performChanges {
            let creationRequest = PHAssetChangeRequest.creationRequestForAsset(from: self.image)
            let addAssetRequest = PHAssetCollectionChangeRequest()
            addAssetRequest.addAssets([creationRequest.placeholderForCreatedAsset] as NSArray)
            
        } completionHandler: { success, error in
            if !success {
                print(error?.localizedDescription)
            }else {
                let alert = UIAlertController(title: "Imagem Salva", message: "Sua imagem foi salva no álbum de fotos", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel)
                alert.addAction(okAction)
                self.present(alert, animated: true)

            }
        }

    }
    
    @IBAction func save(_ sender: Any) {
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .authorized:
                self.saveToAlbum()
            
            default:
                let alert = UIAlertController(title: "Erro", message: "Você precisa ceder acesso ao álbum", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel)
                alert.addAction(okAction)
                self.present(alert, animated: true)

            }
        }
    }
    
    
    
    @IBAction func restart(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }

}
