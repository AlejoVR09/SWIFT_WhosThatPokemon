//
//  ImageManager.swift
//  who is that pokemon
//
//  Created by Alejandro Vanegas Rondon on 19/01/24.
//

import Foundation

protocol ImageManagerDelegate {
    func didImageUpdate(image: ImageModel)
    func didImageFailWithError(error: Error)
}

struct ImageManager {
    var delegate: ImageManagerDelegate?
    
    func callFetch(url: String){
        self.perfomFetch(urlString: url)
    }
    
    private func perfomFetch(urlString: String){
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url){
                data, response, error in
                if let error = error {
                    delegate?.didImageFailWithError(error: error)
                }
                
                if let data = data {
                    if let image = parseJSON(imageData: data){
                        delegate?.didImageUpdate(image: image)
                    }
                }
            }
            task.resume()
        }
    }
    
    private func parseJSON(imageData: Data) -> ImageModel? {
        
        do{
            let decodeData = try JSONDecoder().decode(ImageData.self, from: imageData)
            let image = decodeData.sprites?.other?.officialArtwork?.frontDefault ?? ""
            return  ImageModel(imageUrl: image)
        }catch{
            return nil
        }
    }
}
