//
//  OnboardingViewController.swift
//  qroadapp
//
//  Created by Rashid Karina on 25.04.2023.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    var slides: [OnboardingSlide] = []
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextButton.setTitle("Get Started", for: .normal)
            } else {
                nextButton.setTitle("Next", for: .normal)
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
slides = [
    OnboardingSlide(title: "This is a program to take care of your safety and your loved ones.", description: "l", image: #imageLiteral(resourceName: "first")),
    OnboardingSlide(title: "If you already have an account, you can start using the program, if not, you can click on the register button below to create a new account.", description: "2", image: #imageLiteral(resourceName: "third.jpg"))
    
        ]
        pageControl.numberOfPages = slides.count
    }
    

    @IBAction func nextButtonClicked(_ sender: UIButton) {
        if currentPage == slides.count - 1 {
                   let controller = storyboard?.instantiateViewController(identifier: "HomeNC") as! UINavigationController
                   controller.modalPresentationStyle = .fullScreen
                   controller.modalTransitionStyle = .flipHorizontal
                   UserDefaults.standard.hasOnboarded = true
                   present(controller, animated: true, completion: nil)
               } else {
                   currentPage += 1
                   let indexPath = IndexPath(item: currentPage, section: 0)
                   collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
               }
           }
    
}


extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.setup(slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}

