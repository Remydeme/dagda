//
//  QRCodeController.swift
//  dagda
//
//  Created by remy DEME on 13/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit


class QRCodeHomeController : UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    let navTitle = "Dagda"
    let id = "cell"
    let sign = SignIn()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        setUp()
    }
    
    
    func setUp(){
        navigationItem.title = navTitle
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.prefersLargeTitles = true
        tabBarController?.tabBar.isHidden = false
        collectionView?.backgroundColor = .black
        collectionView?.register(QRCodeCell.self, forCellWithReuseIdentifier: id)
        collectionView?.backgroundColor = .clear
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign In", style: .plain, target: self, action: #selector (signIn(_:)))
       
    }
    
  
    
    @objc func signIn(_ sender: Any){
        let controller = UINavigationController(rootViewController: sign)
        present(controller, animated:  true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        navigationController?.isNavigationBarHidden = true 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        navigationController?.isNavigationBarHidden = false
        collectionView?.reloadData()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as! QRCodeCell
        cell.topController = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    

}











