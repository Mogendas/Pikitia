//
//  UiImageView+Cache.swift
//  Pikitia
//
//  Created by Johan Wejdenstolpe on 2023-02-12.
//

import UIKit

extension UIImageView {
    
    func load(url: URL, placeholder: UIImage?, cache: URLCache? = nil) {
        let cache = cache ?? URLCache.shared
        let request = URLRequest(url: url)
        
        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            DispatchQueue.main.async {
                self.image = image
            }
        } else {
            self.image = placeholder
            
            URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
                guard let data = data, let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode,  let image = UIImage(data: data) else { return }
                
                let cachedData = CachedURLResponse(response: httpResponse, data: data)
                cache.storeCachedResponse(cachedData, for: request)
                if url.absoluteString == httpResponse.url?.absoluteString {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }.resume()
        }
    }
}
