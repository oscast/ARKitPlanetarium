//
//  PlanetImages.swift
//  ARPlanetarium
//
//  Created by Oscar Castillo on 12/6/20.
//

import UIKit

enum PlanetImages: String {
    case sunDiffuse
    case mercuryDiffuse
    case venusDiffuse
    case venusSpecular
    case earthDiffuse
    case earthSpecular
    case earthNormal
    case earthClouds
    case marsDiffuse
    case jupiterDiffuse
    case saturnDiffuse
    case saturnRingDiffuse
    case uranusDiffuse
    case neptuneDiffuse
    case moonDiffuse
    
    func makeImage() -> UIImage {
        UIImage(named: self.rawValue) ?? UIImage()
    }
}

