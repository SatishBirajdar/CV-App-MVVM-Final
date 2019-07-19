//
//  ViewController.swift
//  CV App
//
//  Created by Satish Birajdar on 2019-07-18.
//  Copyright © 2019 SBSoftwares. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    @IBOutlet weak var imageContainer: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var displayTextView: UITextView!
    @IBOutlet weak var sectionsSegmentControl: UISegmentedControl!
    
    let viewModel = HomeViewModel(service: WebService())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        attemptToFetchBiodatas()
    }
    
    func attemptToFetchBiodatas() {
        viewModel.updateLoadingStatus = {
            let _ = self.viewModel.isLoading ? self.startLoader() : self.stopLoader()
        }
        
        viewModel.showAlertClosure = {
            if let error = self.viewModel.error {
                print("Error: \(error.localizedDescription)")
                self.showAlert(title: "Error", message: error.localizedDescription)
            }
        }
        
        viewModel.didFinishFetch = {
            DispatchQueue.main.async {
                self.nameLabel.text = self.viewModel.nameString
                self.contactLabel.text = self.viewModel.contactString
                self.displayTextView.text = self.viewModel.detailString
            }
        }
        
        viewModel.getCandidateDetails()
    }
    
    // Start loading Spinner
    private func startLoader() {
        DispatchQueue.main.async {
            self.loadingSpinner.startAnimating()
            print("Spinner animation is ON")
        }
    }
    
    // Stop loading spinner
    private func stopLoader() {
        DispatchQueue.main.async {
            self.loadingSpinner.stopAnimating()
            print("Spinner animation is OFF")
        }
    }
    
    // Show display alert
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    // Segment control clicked function
    @IBAction func sectionSelectionClicked(_ sender: UISegmentedControl) {
        guard let biodatas = self.viewModel.biodatas else {
            print("Candidate details is null")
            return
        }
        
        if sender.selectedSegmentIndex == 0 {               // Summary segment clicked
            guard let summary = biodatas.first?.professionalSummary else {
                print("Candidate summary is null")
                return
            }
            self.displayTextView.text = summary
        } else if sender.selectedSegmentIndex == 1 {        // Skills segment clicked
            guard let skills = biodatas.first?.skills else {
                print("Candidate skills is null")
                return
            }
            self.displayTextView.text = skills
        } else {                                            // Experience segment clicked
            guard let experiences = biodatas.first?.experiences else {
                print("Candidate experiences is null")
                return
            }
            var experienceDetailText: String = ""
            for experience in experiences {
                experienceDetailText += " Company Name: \(experience.companyName)\n Role: \(experience.role)\n From: \(experience.from)\n To: \(experience.to)\n Responsibilities:\n"
                for responsibility in experience.responsibilities {
                    experienceDetailText += "   - \(responsibility)\n"
                }
                experienceDetailText += "Achievements: \(experience.achievements)\n\n"
            }
            
            self.displayTextView.text = experienceDetailText
        }
    }
}

