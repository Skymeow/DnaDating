//
//  Traits.swift
//  Dndating
//
//  Created by Sky Xu on 12/10/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import Foundation

struct Trait: Codable{
//    var traits: String?
    var weight: Int?
    var motionSickness: Int?
    var height: Int?
    var freckles: Int?
//    let waistHipRatio: Int?
//    let breastSize: Int?
//    let skinPigmentation: Int?
//    let agreeableness: Int?
    var neuroticism: Int?
    
    enum firstKeys: String, CodingKey {
        case traits
    }
    enum CodingKeys: String, CodingKey {
        case weight
        case motionSickness = "motion-sickness"
        case height
        case freckles
        case neuroticism
    }
//    init(weight: Int?, motionSickness: Int?, height: Int?, freckles: Int?, neuroticism: Int?) {
//        self.weight = weight
//        self.motionSickness = motionSickness
//        self.height = height
//        self.freckles = freckles
//        self.neuroticism = neuroticism
//    }
    func encode(to encoder: Encoder) throws {
         var allValues = encoder.container(keyedBy: firstKeys.self)
         var traits = allValues.nestedContainer(keyedBy: CodingKeys.self, forKey: .traits)
         try traits.encode(weight, forKey: .weight)
         try traits.encode(height, forKey: .height)
         try traits.encode(motionSickness, forKey: .motionSickness)
         try traits.encode(freckles, forKey: .freckles)
         try traits.encode(neuroticism, forKey: .neuroticism)
        
    }
    
}


