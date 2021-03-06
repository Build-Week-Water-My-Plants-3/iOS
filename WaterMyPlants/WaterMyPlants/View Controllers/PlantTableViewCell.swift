//
//  PlantTableViewCell.swift
//  WaterMyPlants
//
//  Created by Craig Swanson on 2/27/20.
//  Copyright © 2020 craigswanson. All rights reserved.
//

import UIKit

class PlantTableViewCell: UITableViewCell {
    
    var plant: Plant? {
        didSet {
            updateViews()
        }
    }
    @IBOutlet weak var plantNicknameLabel: UILabel!
    @IBOutlet weak var plantImage: UIImageView!
    @IBOutlet weak var daysToNextWatering: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateViews() {
        guard let plant = plant else { return }
        plantNicknameLabel.text = plant.nickname
        if let plantImageData = plant.image {
            plantImage.image = UIImage(data: plantImageData)
        } else {
            plantImage.image = #imageLiteral(resourceName: "plantsforuser")
        }
        let daysRemaining = daysToWateringCalc()
        daysToNextWatering.text = daysRemaining
    }
    
    // This function calculates the next watering date and then subtracts the current date from the next watering date (giving us the time remaining until we need to water the plant again).
    // It takes out the value for the number of days from the result and returns that value in type String.
    func daysToWateringCalc() -> String {
        guard let plant = plant else { return "" }
        guard let lastWatered = plant.lastWatered else { return "" }
        let today = Date()
        var dateComponent = DateComponents()
        dateComponent.day = Int(plant.h2oFrequency)
        let newWaterDate = Calendar.current.date(byAdding: dateComponent, to: lastWatered)
        guard let daysRemaining = Calendar.current.dateComponents([.day], from: today, to: newWaterDate!).day else { return ""}
        if daysRemaining >= 1 {
            return "\(daysRemaining + 1) days until next watering."
        } else if daysRemaining >= 0 {
            return "Watering is due tomorrow."
        } else {
            return "Watering is past due!"
        }
    }
}
