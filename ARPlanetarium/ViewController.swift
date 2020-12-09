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
    let sunPosition = SCNVector3(0,0,-0.4)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sceneView.session.run(configuration)
        sceneView.autoenablesDefaultLighting = true
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
        let sun = createPlanetNode(geometry: SCNSphere(radius: 0.07),
                                   position: sunPosition,
                                   diffuse: .sunDiffuse)
        sceneView.scene.rootNode.addChildNode(sun)
        sun.geometry?.firstMaterial?.diffuse.contents = PlanetImages.sunDiffuse.makeImage()
        sun.runAction(RotationAction(15))
    }
    
    func createMercury() {
        let mercuryParent = createParentNode(position: sunPosition)
        let mercury = createPlanetNode(geometry: SCNSphere(radius: 0.01),
                                       position: SCNVector3(0.12,0,0),
                                       diffuse: .mercuryDiffuse)
        mercuryParent.addChildNode(mercury)
        mercury.runAction(RotationAction(6))
        mercuryParent.runAction(RotationAction(4))
    }
    
    func createVenus() {
        let venusParent = createParentNode(position: sunPosition)
        let venus = createPlanetNode(geometry: SCNSphere(radius: 0.02),
                                     position: SCNVector3(0.16,0,0),
                                     diffuse: .venusDiffuse,
                                     specular: .venusSpecular)
        venusParent.addChildNode(venus)
        venus.runAction(RotationAction(6))
        venusParent.runAction(RotationAction(12))
    }
    
    func createEarth() {
        let earth = createPlanetNode(geometry: SCNSphere(radius: 0.015),
                                     position: SCNVector3(0.21,0,0),
                                   diffuse: .earthDiffuse,
                                   specular: .earthSpecular,
                                   normal: .earthNormal,
                                   emission: .earthClouds)
        
        let earthParent = createParentNode(position: sunPosition)
        earthParent.addChildNode(earth)
        earthParent.runAction(RotationAction(20))
        earth.runAction(RotationAction(6))
        
        let moonParent = SCNNode()
        moonParent.position = earth.position
        earthParent.addChildNode(moonParent)
        let moon = createPlanetNode(geometry: SCNSphere(radius: 0.004),
                                    position: SCNVector3(0.020, 0.020, 0),
                                    diffuse: .moonDiffuse)
        moonParent.addChildNode(moon)
        moonParent.runAction(RotationAction(3))
        moon.runAction(RotationAction(1))
    }
    
    func createMars() {
        let mars = createPlanetNode(geometry: SCNSphere(radius: 0.012),
                                    position: SCNVector3(0.24,0,0),
                                    diffuse: .marsDiffuse)
        
        let marsParent = createParentNode(position: sunPosition)
        marsParent.addChildNode(mars)
        marsParent.runAction(RotationAction(30))
        mars.runAction(RotationAction(6))
    }
    
    func createJupiter() {
        let jupiter = createPlanetNode(geometry: SCNSphere(radius: 0.03),
                                       position: SCNVector3(0.29,0,0),
                                    diffuse: .jupiterDiffuse)
        
        let jupiterParent = createParentNode(position: sunPosition)
        jupiterParent.addChildNode(jupiter)
        jupiterParent.runAction(RotationAction(50))
        jupiter.runAction(RotationAction(10))
    }
    
    func createSaturn() {
        let saturn = createPlanetNode(geometry: SCNSphere(radius: 0.028),
                                      position: SCNVector3(0,0,0.35),
                                    diffuse: .saturnDiffuse)
        
        let saturnRing = createPlanetNode(geometry: SCNTube(innerRadius: 0.029,
                                                            outerRadius: 0.044,
                                                       height: 0.001),
                                     position: SCNVector3(0, 0, 0),
                                     diffuse: .saturnRingDiffuse)
        saturnRing.eulerAngles = SCNVector3(15.toRadians, 0, 0)
        saturn.addChildNode(saturnRing)
        
        let saturnParent = createParentNode(position: sunPosition)
        saturnParent.addChildNode(saturn)
        saturnParent.runAction(RotationAction(70))
        saturn.runAction(RotationAction(10))
    }
    
    func createUranus() {
        let uranus = createPlanetNode(geometry: SCNSphere(radius: 0.026),
                                      position: SCNVector3(0,0,0.43),
                                    diffuse: .uranusDiffuse)
        
        let uranusParent = createParentNode(position: sunPosition)
        uranusParent.addChildNode(uranus)
        uranusParent.runAction(RotationAction(100))
        uranus.runAction(RotationAction(10))
    }
    
    func createNeptune() {
        let neptune = createPlanetNode(geometry: SCNSphere(radius: 0.024),
                                       position: SCNVector3(0.47,0,0),
                                    diffuse: .neptuneDiffuse)
        
        let neptuneParent = createParentNode(position: sunPosition)
        neptuneParent.addChildNode(neptune)
        neptuneParent.runAction(RotationAction(120))
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
