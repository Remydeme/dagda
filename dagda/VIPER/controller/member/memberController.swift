//
//  memberController.swift
//  dagda
//
//  Created by remy DEME on 16/04/2018.
//  Copyright © 2018 remy DEME. All rights reserved.
//

import Foundation
import UIKit



class MemberController : UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    let id = "cellDesription"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    
    func setUp(){
        collectionView?.register(MemberCell.self, forCellWithReuseIdentifier: id)
        //collectionView?.isPagingEnabled = true
        collectionView?.backgroundColor = .black
        navigationItem.title = "Descriptions list"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign out", style: .plain, target: self, action: #selector (MemberController.signOut(_:)))
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesBackButton = true 
    }
    
    @objc func signOut(_ sender : Any){
        print("Sign out")
       API.instance.signOut()
       User.instance.disconnect()
       navigationController?.popToRootViewController(animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as! MemberCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat(collectionView.frame.width), height: CGFloat(collectionView.frame.height))
    }
    
}







