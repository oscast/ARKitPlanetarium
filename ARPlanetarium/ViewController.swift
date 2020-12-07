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
    let sunPosition = SCNVector3(0,0,-1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.debugOptions = [.showFeaturePoints, .showWorldOrigin]
        sceneView.session.run(configuration)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        createPlanets()
    }
    
    
    func createPlanets() {
        createSun()
        createEarth()
        createMercury()
        createVenus()
        createMars()
        createJupiter()
        createSaturn()
        createUranus()
        createNeptune()
    }
    
    func createSun() {
        let sun = createPlanetNode(geometry: SCNSphere(radius: 0.3),
                                   position: sunPosition,
                                   diffuse: .sunDiffuse)
        sceneView.scene.rootNode.addChildNode(sun)
        sun.geometry?.firstMaterial?.diffuse.contents = PlanetImages.sunDiffuse.makeImage()
        sun.runAction(RotationAction(15))
    }
    
    func createMercury() {
        let mercuryParent = createParentNode(position: sunPosition)
        let mercury = createPlanetNode(geometry: SCNSphere(radius: 0.05),
                                       position: SCNVector3(0.45,0,0),
                                       diffuse: .mercuryDiffuse)
        mercuryParent.addChildNode(mercury)
        mercury.runAction(RotationAction(6))
        mercuryParent.runAction(RotationAction(4))
    }
    
    func createVenus() {
        let venusParent = createParentNode(position: sunPosition)
        let venus = createPlanetNode(geometry: SCNSphere(radius: 0.05),
                                     position: SCNVector3(0.75,0,0),
                                     diffuse: .venusDiffuse,
                                     specular: .venusSpecular)
        venusParent.addChildNode(venus)
        venusParent.runAction(RotationAction(6))
        venusParent.runAction(RotationAction(7))
    }
    
    func createEarth() {
        let earth = createPlanetNode(geometry: SCNSphere(radius: 0.05),
                                   position: SCNVector3(1,0,0),
                                   diffuse: .earthDiffuse,
                                   specular: .earthSpecular,
                                   normal: .earthNormal,
                                   emission: .earthClouds)
        
        let earthParent = createParentNode(position: sunPosition)
        earthParent.addChildNode(earth)
        earthParent.runAction(RotationAction(10))
        earth.runAction(RotationAction(6))
    }
    
    func createMars() {
        let mars = createPlanetNode(geometry: SCNSphere(radius: 0.05),
                                    position: SCNVector3(1.25,0,0),
                                    diffuse: .marsDiffuse)
        
        let marsParent = createParentNode(position: sunPosition)
        marsParent.addChildNode(mars)
        marsParent.runAction(RotationAction(12))
        mars.runAction(RotationAction(6))
    }
    
    func createJupiter() {
        let jupiter = createPlanetNode(geometry: SCNSphere(radius: 0.1),
                                    position: SCNVector3(1.50,0,0),
                                    diffuse: .jupiterDiffuse)
        
        let jupiterParent = createParentNode(position: sunPosition)
        jupiterParent.addChildNode(jupiter)
        jupiterParent.runAction(RotationAction(15))
        jupiter.runAction(RotationAction(10))
    }
    
    func createSaturn() {
        let saturn = createPlanetNode(geometry: SCNSphere(radius: 0.1),
                                    position: SCNVector3(-1.75,0,0),
                                    diffuse: .saturnDiffuse)
        
        let saturnParent = createParentNode(position: sunPosition)
        saturnParent.addChildNode(saturn)
        saturnParent.runAction(RotationAction(17))
        saturn.runAction(RotationAction(10))
    }
    
    func createUranus() {
        let uranus = createPlanetNode(geometry: SCNSphere(radius: 0.1),
                                    position: SCNVector3(-1.75,0,0),
                                    diffuse: .uranusDiffuse)
        
        let uranusParent = createParentNode(position: sunPosition)
        uranusParent.addChildNode(uranus)
        uranusParent.runAction(RotationAction(14))
        uranus.runAction(RotationAction(10))
    }
    
    func createNeptune() {
        let neptune = createPlanetNode(geometry: SCNSphere(radius: 0.1),
                                       position: SCNVector3(-2.00,0,0),
                                    diffuse: .neptuneDiffuse)
        
        let neptuneParent = createParentNode(position: sunPosition)
        neptuneParent.addChildNode(neptune)
        neptuneParent.runAction(RotationAction(12))
        neptune.runAction(RotationAction(10))
    }
    
    
    func createParentNode(position: SCNVector3) -> SCNNode {
        let node = SCNNode()
        node.position = position
        sceneView.scene.rootNode.addChildNode(node)
        return node
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
    
    func RotationAction(_ timeRotation: TimeInterval) -> SCNAction {
        let nodeRotation = SCNAction.rotateBy(x: 0,
                                          y: CGFloat(360.toRadians),
                                          z: 0,
                                          duration: timeRotation)
        let continueAction = SCNAction.repeatForever(nodeRotation)
        return continueAction
    }
}

extension Int {
    var toRadians: Double { return Double(self) * .pi/180 }
}
