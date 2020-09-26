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
    @IBOutlet weak var labelMovieCategories: UILabel!
    @IBOutlet weak var imageViewPoster: UIImageView!
    @IBOutlet weak var textViewSummary: UITextView!
    @IBOutlet weak var buttonSave: UIButton!
    @IBOutlet weak var buttonSelectImage: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    //MARK: - Properties
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func selectImage(_ sender: UIButton) {
    }
    
    @IBAction func save(_ sender: UIButton) {
    }
    
    @objc
    private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo, let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let valueKeyboardHeightSize = keyboardFrame.size.height - view.safeAreaInsets.bottom
        scrollView.contentInset.bottom = valueKeyboardHeightSize
        scrollView.verticalScrollIndicatorInsets.bottom = valueKeyboardHeightSize
    }
    
    @objc
    private func keyboardWillHide() {
        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets.bottom = 0
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
