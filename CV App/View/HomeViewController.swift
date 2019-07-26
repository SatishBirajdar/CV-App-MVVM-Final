//
//  ViewController.swift
//  CV App
//
//  Created by Satish Birajdar on 2019-07-18.
//  Copyright © 2019 SBSoftwares. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: UIComponents
    var pageTitle: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.boldSystemFont(ofSize: 30.0)
        title.text = "RESUME"
        title.textColor = UIColor.white
        return title
    }()
    
    var profilePicImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "ProfilePicturePlaceholder")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        label.text = "Name:"
        return label
    }()
    
    var nameValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.text = ""
        return label
    }()
    
    var contactLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        label.text = "Contact:"
        return label
    }()
    
    var contactValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.text = ""
        return label
    }()
    
    var detailTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 15.0)
        textView.text = ""
        textView.isEditable = false
        return textView
    }()
    
    var sectionSegmentControl: UISegmentedControl = {
        let segmentControl = UISegmentedControl()
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.insertSegment(withTitle: "Summary", at: 0, animated: true)
        segmentControl.insertSegment(withTitle: "Skills", at: 1, animated: true)
        segmentControl.insertSegment(withTitle: "Experience", at: 2, animated: true)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(HomeViewController.indexChanged(_:)), for: .valueChanged)
        segmentControl.isEnabled = false
        return segmentControl
    }()
    
    var loadingSpinner: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.color = UIColor.red
        loader.isHidden = false
        return loader
    }()
    
    let viewModel = HomeViewModel(service: WebService())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.init(red: 0.4, green: 0.7, blue: 0.4, alpha: 1.0)
        
        // MARK: adding subviews
        view.addSubview(pageTitle)
        view.addSubview(profilePicImageView)
        view.addSubview(nameLabel)
        view.addSubview(nameValueLabel)
        view.addSubview(contactLabel)
        view.addSubview(contactValueLabel)
        view.addSubview(detailTextView)
        view.addSubview(sectionSegmentControl)
        view.addSubview(loadingSpinner)
        
        setupUI()
        attemptToFetchBiodatas()
    }
    
    private func setupUI(){
        
        // setup UI component constraints
        pageTitle.widthAnchor.constraint(equalToConstant: 150).isActive = true
        pageTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true
        pageTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        pageTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        
        profilePicImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        profilePicImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        profilePicImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        profilePicImageView.topAnchor.constraint(equalTo: pageTitle.bottomAnchor,constant: 10).isActive = true
        
        nameLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        nameLabel.topAnchor.constraint(equalTo: profilePicImageView.bottomAnchor, constant: 10).isActive = true
        
        nameValueLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
        nameValueLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        nameValueLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10).isActive = true
        nameValueLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 0).isActive = true
        
        contactLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
        contactLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        contactLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        contactLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        
        contactValueLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        contactValueLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        contactValueLabel.leadingAnchor.constraint(equalTo: contactLabel.trailingAnchor, constant: 10).isActive = true
        contactValueLabel.topAnchor.constraint(equalTo: contactLabel.topAnchor, constant: 0).isActive = true
        
        detailTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        detailTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        detailTextView.topAnchor.constraint(equalTo: contactLabel.bottomAnchor, constant: 10).isActive = true
        detailTextView.bottomAnchor.constraint(equalTo: sectionSegmentControl.topAnchor, constant: -10).isActive = true
        
        sectionSegmentControl.widthAnchor.constraint(equalToConstant: 250).isActive = true
        sectionSegmentControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        sectionSegmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sectionSegmentControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        
        loadingSpinner.widthAnchor.constraint(equalToConstant: 30).isActive = true
        loadingSpinner.heightAnchor.constraint(equalToConstant: 30).isActive = true
        loadingSpinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingSpinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func attemptToFetchBiodatas() {
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
                self.nameValueLabel.text = self.viewModel.nameString
                self.contactValueLabel.text = self.viewModel.contactString
                self.detailTextView.text = self.viewModel.detailString
                self.sectionSegmentControl.isEnabled = true
                guard let imagePath = self.viewModel.profilePicturePath else { return }
                self.profilePicImageView.imageFromUrl(urlString: imagePath)
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
    @objc func indexChanged(_ sender: UISegmentedControl) {
        guard let biodatas = self.viewModel.biodatas else {
            print("Candidate details is null")
            return
        }
        
        if sender.selectedSegmentIndex == 0 {               // Summary segment clicked
            guard let summary = biodatas.first?.professionalSummary else {
                print("Candidate summary is null")
                return
            }
            self.detailTextView.text = summary
        } else if sender.selectedSegmentIndex == 1 {        // Skills segment clicked
            guard let skills = biodatas.first?.skills else {
                print("Candidate skills is null")
                return
            }
            self.detailTextView.text = skills
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
            
            self.detailTextView.text = experienceDetailText
        }
    }
}
