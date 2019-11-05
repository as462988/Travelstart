//
//  DetailPageHeaderView.swift
//  TravelstartInterview
//
//  Created by Yueh-chen Hsu on 2019/11/6.
//  Copyright © 2019 Yueh-chen Hsu. All rights reserved.
//

import UIKit

class DetailPageHeaderView: UIView, UIScrollViewDelegate {

        let pageScrollView = UIScrollView()
        let pageControl = UIPageControl(frame: CGRect.zero)
        let fullScreen = UIScreen.main.bounds
        
        init(numberOfImage: Int, images: [String]) {
            super .init(frame: CGRect.zero)
            setupScrollLViewLayout(number: numberOfImage)
            showImage(number: numberOfImage, images: images)
            changePageLayout(number: numberOfImage)
            pageScrollView.delegate = self
          
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        // MARK: - ScrollLView
        func setupScrollLViewLayout(number: Int) {
            
            pageScrollView.contentSize.height = fullScreen.height / 3
            pageScrollView.contentSize.width = fullScreen.width * CGFloat(number)
            pageScrollView.isPagingEnabled = true
            addSubview(pageScrollView)
            
            pageScrollView.anchor(top: self.topAnchor,
                                  leading: self.leadingAnchor,
                                  bottom: self.bottomAnchor,
                                  trailing: self.trailingAnchor)

        }
        
        // MARK: - showImage
        func showImage(number: Int, images: [String]) {
           let putImageStackView = UIStackView(frame: CGRect.zero)
            putImageStackView.axis = .horizontal //指定方向
            putImageStackView.translatesAutoresizingMaskIntoConstraints = false
            
            for num in 0...number-1 {
                let showImageView = UIImageView(frame: CGRect.zero)
                showImageView.loadImage(images[num])
                showImageView.contentMode = .scaleAspectFill
                showImageView.clipsToBounds = true
                
                showImageView.constrainWidth(constant: fullScreen.width)
                showImageView.constrainHeight(constant: pageScrollView.contentSize.height)
                
                putImageStackView.addArrangedSubview(showImageView)

            }
          
            pageScrollView.addSubview(putImageStackView)
        }

        // MARK: - 更換頁面
        func changePageLayout(number: Int) {
            
            pageControl.numberOfPages = number
            pageControl.currentPage = 0
            pageControl.currentPageIndicatorTintColor = .darkGray
            pageControl.pageIndicatorTintColor = .white
            self.addSubview(pageControl)
            
            let padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
            
            pageControl.anchor(top: nil, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: nil, padding: padding, size: .zero)
            
            pageControl.addTarget(self, action: #selector (pageChanged(sender:)), for: .valueChanged)
            
        }

        @objc func pageChanged(sender: UIPageControl) {
            let currentPageNumber = sender.currentPage
            let width = pageScrollView.frame.size.width
            let offset = CGPoint(x: width * CGFloat(currentPageNumber), y: 0)
            pageScrollView.setContentOffset(offset, animated: true)
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
             let currentPage = Int(pageScrollView.contentOffset.x / pageScrollView.frame.size.width)

            pageControl.currentPage = currentPage
            
        }
        
    }
