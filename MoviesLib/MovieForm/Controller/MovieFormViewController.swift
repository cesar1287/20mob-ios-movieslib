//
//  MovieFormViewController.swift
//  MoviesLib
//
//  Created by Cesar Nascimento on 26/09/20.
//  Copyright © 2020 Cesar Nascimento. All rights reserved.
//

import UIKit

final class MovieFormViewController: UIViewController {

    @IBOutlet weak var textFieldMovieTitle: UITextField!
    @IBOutlet weak var textFieldMovieNote: UITextField!
    @IBOutlet weak var textFieldMovieDuration: UITextField!
    @IBOutlet weak var textFieldRating: UITextField!
    @IBOutlet weak var labelMovieCategories: UILabel!
    @IBOutlet weak var imageViewPoster: UIImageView!
    @IBOutlet weak var textViewSummary: UITextView!
    @IBOutlet weak var buttonSave: UIButton!
    @IBOutlet weak var buttonSelectImage: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: - Properties
    var movie: Movie?
    var selectedCategories: Set<Category> = [] {
        didSet {
            if selectedCategories.count > 0 {
                labelMovieCategories.text = selectedCategories.compactMap({ $0.name }).sorted().joined(separator: " | ")
            } else {
                labelMovieCategories.text = "Categorias"
            }
        }
    }
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - IBActions
    @IBAction func selectImage(_ sender: UIButton) {
        let alert = UIAlertController(
            title: "Selecionar pôster",
            message: "De onde você deseja escolher o pôster?",
            preferredStyle: .actionSheet
        )
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) == true {
            let cameraAction = UIAlertAction(
                title: "Câmera",
                style: .default) { (_) in
                self.selectPictureFrom(.camera)
                }
            alert.addAction(cameraAction)
        }
        
        
        let libraryAction = UIAlertAction(
            title: "Biblioteca de fotos",
            style: .default) { (_) in
            self.selectPictureFrom(.photoLibrary)
            }
        
        alert.addAction(libraryAction)
        
        let photosAction = UIAlertAction(
            title: "Álbum de fotos",
            style: .default) { (_) in
            self.selectPictureFrom(.savedPhotosAlbum)
            }
        alert.addAction(photosAction)
        
        let cancelAction = UIAlertAction(
            title: "Cancelar",
            style: .cancel,
            handler: nil
        )
        alert.addAction(cancelAction)
        
        present(
            alert,
            animated: true,
            completion: nil
        )
    }
    
    private func selectPictureFrom(_ sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = sourceType
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: UIButton) {
        if movie == nil {
            movie = Movie(context: context)
        }
        movie?.title = textFieldMovieTitle.text
        movie?.summary = textViewSummary.text
        movie?.duration = textFieldMovieDuration.text
        let rating = Double(textFieldRating.text!) ?? 0
        movie?.rating = rating
        movie?.image = imageViewPoster.image?.jpegData(compressionQuality: 0.9)
        movie?.categories = selectedCategories as NSSet?
        
        view.endEditing(true)
        do {
            try context.save()
            navigationController?.popViewController(animated: true)
        } catch {
            print(error)
        }
    }
    
    // MARK: - Methods
    private func setupView() {
        if let movie = movie {
            title = "Edição de filme"
            textFieldMovieTitle.text = movie.title
            textFieldRating.text = "\(movie.rating)"
            textFieldMovieDuration.text = movie.duration
            textViewSummary.text = movie.summary
            imageViewPoster.image = movie.poster
            buttonSave.setTitle("Alterar", for: .normal)
            
            if let categories = movie.categories as? Set<Category>, categories.count > 0{
                selectedCategories = categories
            }
            
            if let data = movie.image {
                imageViewPoster.image = UIImage(data: data)
            }
        }
    }
    
    @objc
    private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo, let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {return}
        scrollView.contentInset.bottom = keyboardFrame.size.height - view.safeAreaInsets.bottom
        scrollView.verticalScrollIndicatorInsets.bottom = keyboardFrame.size.height - view.safeAreaInsets.bottom
    }
    
    @objc
    private func keyboardWillHide() {
        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets.bottom = 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? CategoriesTableViewController {
            vc.delegate = self
            vc.selectedCategories = selectedCategories
        }
    }
}

extension MovieFormViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            imageViewPoster.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
    
}

extension MovieFormViewController: CategoriesDelegate {
    
    func setSelectedCategories(_ categories: Set<Category>) {
        selectedCategories = categories
    }
}
