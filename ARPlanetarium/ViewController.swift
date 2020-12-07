//
//  ViewController.swift
//  ARPlanetarium
//
//  Created by Oscar Castillo on 12/6/20.
//

import UIKit
import ARKit

class ViewController: UIViewController {
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.debugOptions = [.showFeaturePoints, .showWorldOrigin]
        sceneView.session.run(configuration)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        createSun()
    }
    
    func createSun() {
        let sun = createPlanetNode(geometry: SCNSphere(radius: 0.3),
                                   position: SCNVector3(0,0,-1),
                                   diffuse: .sunDiffuse)
        sceneView.scene.rootNode.addChildNode(sun)
        sun.geometry?.firstMaterial?.diffuse.contents = PlanetImages.sunDiffuse.makeImage()
    }
    
    func createPlanetNode(geometry: SCNGeometry,
                          position: SCNVector3,
                          diffuse: PlanetImages,
                          specular: PlanetImages? = nil,
                          normal: PlanetImages? = nil,
                          emission: PlanetImages? = nil) -> SCNNode {
        let planetNode = SCNNode(geometry: geometry)
        planetNode.geometry?.firstMaterial?.diffuse.contents = diffuse.makeImage()
        planetNode.geometry?.firstMaterial?.specular.contents = specular?.makeImage()
        planetNode.geometry?.firstMaterial?.normal.contents = normal?.makeImage()
        planetNode.geometry?.firstMaterial?.emission.contents = emission?.makeImage()
        planetNode.position = position
        
        return planetNode
    }
}


