//
//  MovieClient.swift
//  Project6
//
//  Created for MPCS 501030
//

import Foundation
import UIKit

   /// Creates a task that retrieves the contents of the an itunes URL, then calls a handler upon completion.
   class MovieClient {
    static let cache = NSCache<NSString, UIImage>()
    /// Fetch movies from iTunes with completion block
    /// - Parameters:
    ///     - completion: A tuple with an `Array` of the movies and an error code
    /// - Throws:
    /// - Returns:
       static func fetchMovies(searchQuery: String = "love", completion: @escaping (movielist?, Error?) -> Void) {
             let url = URL(string: "https://itunes.apple.com/search?country=US&media=movie&limit=200&term=\(searchQuery)")!
             let task = URLSession.shared.dataTask(with: url) { data, _, error in
             guard let data = data, error == nil else {
                 DispatchQueue.main.async { completion(nil, error) }
                 return
                 }

                do{
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let issues = try decoder.decode(movielist.self, from: data)
                    DispatchQueue.main.async { completion(issues, nil) }
                } catch(let parsingError) {
                    DispatchQueue.main.async { completion(nil, parsingError) }
              }
              }

task.resume()
    }
    
    // FIXME: Change this to use the new Async Image method
       //update this to cache an image. always check to see if the image exists
       // in cache before trying to download it. If you download it, then make sure to add it to the cache.
    static func getImage(url: String, completion: @escaping (UIImage?, Error?) -> Void) {
        let cached = cache.object(forKey: url as NSString)  // cache the image
        let urlChanged=URL(string: url)!
        let session = URLSession.shared
        if (cached != nil) {
            completion(cached, nil)
        }
        else{
            let task=session.dataTask(with:urlChanged as URL,completionHandler:{(data,response,error)->Void in
                
                 guard let data = data, error == nil else {
                    DispatchQueue.main.async { completion(nil, error) }
                    return
               }
                
                if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                // Do something with this
                // image on the main thread
                    completion(image, nil)
                    cache.setObject(image, forKey: url as NSString)
                    }
                }else{
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
              }
            })
            task.resume()
        }
        
    }
       // search online method for getting the average color
       // reference: https://www.hackingwithswift.com/example-code/media/how-to-read-the-average-color-of-a-uiimage-using-ciareaaverage
       static func averageColor(image: UIImage) -> UIColor{
           guard let inputImage = CIImage(image: image) else { return UIColor.yellow }
                   let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)

                   guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return UIColor.yellow }
                   guard let outputImage = filter.outputImage else { return UIColor.yellow }

                   var bitmap = [UInt8](repeating: 0, count: 4)
                let context = CIContext(options: [.workingColorSpace: kCFNull!])
                   context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)

                   return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
       }
}
