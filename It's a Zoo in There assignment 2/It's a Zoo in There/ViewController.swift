//
//  ViewController.swift
//  It's a Zoo in There
//
//  Created by Ian on 2022/1/21.
//

import UIKit
import AVFoundation
var myPlayer: AVAudioPlayer?


class ViewController: UIViewController {
    @IBOutlet var scroll: UIScrollView!
    @IBOutlet var label: UILabel!
    
    var animals = [Animal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let cat = Animal(nam: "Rengar", spec: "Cat", a: 6, im: UIImage(named: "cat")!, sp: "cat_sound.wav")
        let dog = Animal(nam: "Lucky", spec: "Dog", a: 3, im: UIImage(named: "dog")!, sp: "dog_sound.wav")
        let lion = Animal(nam: "Simba", spec: "Lion", a: 10, im: UIImage(named: "lion")!, sp: "lion_sound.wav")
        animals.append(cat)
        animals.append(dog)
        animals.append(lion)
        animals.shuffle()
        
        scroll.contentSize = CGSize(width: 1170, height: 600)
        scroll.isPagingEnabled = true
        scroll.delegate = self
        
        label.text = animals[0].species
        
        for i in 0...2{
            let x_pos = i * 390
            let pic = UIImageView(frame: CGRect(x: x_pos, y: 0, width: 390, height: 600))
            pic.image = animals[i].image
            
            scroll.addSubview(pic)
        }
        
        
        
        for i in 0...2{
            var config = UIButton.Configuration.filled()
            config.title = "\(animals[i].name)"
            config.background.backgroundColor = .systemRed
            
            let x_pos = 20 + (i * 390)
            
            let button = UIButton(frame: CGRect(x: x_pos, y: 50, width: 80, height: 40))
            button.configuration = config
            button.tag = i
            button.addTarget(self, action: #selector(buttonTapped), for: UIControl.Event.touchDown)
            
            scroll.addSubview(button)
            
        }
        
        
        
    }
    @objc func buttonTapped(_ button: UIButton){
        let cur_animal = animals[button.tag]
        
        let alert = UIAlertController(title: "\(cur_animal.name)", message: "This \(cur_animal.species) is \(cur_animal.age) years old.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Play Sound", style: .default, handler: {
            action in print(cur_animal.description)
            let path  = Bundle.main.path(forResource: cur_animal.soundPath, ofType: nil)!
            let url = URL(fileURLWithPath: path)
            do{
                myPlayer = try AVAudioPlayer(contentsOf: url)
                myPlayer?.play()
            } catch{
                print("can't load file")
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }

}

extension ViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("User scrolled!~ ")
        let numb = Int(min((scroll.contentOffset.x + 194) / 390, 2))
        label.text = animals[numb].species
        label.alpha = CGFloat(abs(1 - (scroll.contentOffset.x.truncatingRemainder(dividingBy: CGFloat(390))/195)))
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("Done moving")
    }
}

