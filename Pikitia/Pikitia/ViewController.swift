//
//  ViewController.swift
//  Pikitia
//
//  Created by Johan Wejdenstolpe on 2023-02-11.
//

import UIKit

typealias DataSource = UICollectionViewDiffableDataSource<Section, Photo>
typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Photo>

enum Section {
  case main
}

class ViewController: UIViewController {
    var viewModel = MainViewModel()
    
    private lazy var dataSource = makeDataSource()

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var shadowView: UIView!
    
    override func viewDidLoad()  {
        super.viewDidLoad()
        textField.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        shadowView.addGestureRecognizer(tapGesture)
        
        navigationController?.isNavigationBarHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        collectionView.collectionViewLayout = viewModel.flowLayout(viewSize: view.bounds.size)
        collectionView.register(UINib(nibName:"ImageCell",bundle: nil), forCellWithReuseIdentifier: "ImageCell")
        collectionView.delegate = self
        
        viewModel.updateUi = { [weak self] in
            DispatchQueue.main.async {
                self?.applySnapshot()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    private func makeDataSource() -> DataSource {
        let dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, photo) ->
              UICollectionViewCell? in
              guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "ImageCell",
                for: indexPath) as? ImageCell else { return UICollectionViewCell()}
              cell.configure(photo: photo)
              return cell
          })
          return dataSource
    }
    
    private func applySnapshot(animatingDifferences: Bool = true) {
        guard let photos = viewModel.photos?.photo else { return }
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(photos)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
      }
    
    @objc func hideKeyboard() {
        textField.resignFirstResponder()
    }
    
    
    @objc func keyboardWillAppear() {
        shadowView.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.shadowView.alpha = 1
        }
    }

    @objc func keyboardWillDisappear() {
        UIView.animate(withDuration: 0.3) {
            self.shadowView.alpha = 0
        } completion: { _ in
            self.shadowView.isHidden = true
        }
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let photos = viewModel.photos?.photo else { return }
        
        let photo = photos[indexPath.row]
        
        let pageViewController = PageViewController(photos: photos, selectedPhoto: photo)
        
        navigationController?.pushViewController(pageViewController, animated: true)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let searchString = textField.text else { return false }
        viewModel.searchPhotos(searchString: searchString)
        textField.resignFirstResponder()
        return true
    }
    
    
}
