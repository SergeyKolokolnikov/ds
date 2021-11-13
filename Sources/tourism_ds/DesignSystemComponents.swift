
import Foundation
import UIKit

enum ComponentName: String {
    case RButton            = "RButton"
    case RButtonSimple      = "RButtonSimple"
    case RCheckbox          = "RCheckbox"
    case RCol               = "RCol"
    case RDashboard         = "RDashboard"
    case RGridSystem        = "RGridSystem"
    case RIcon              = "RIcon"
    case RInput             = "RInput"
    case RListGroup         = "RListGroup"
    case RListItem          = "RListItem"
    case RMenuItemDashboard = "RMenuItemDashboard"
    case RPopover           = "RPopover"
    case RRadioButton       = "RRadioButton"
    case RSelect            = "RSelect"
    case RSpinner           = "RSpinner"
    case RTextarea          = "RTextarea"
}

struct DesignSystemComponents {
    let components: [String: [String: Any]]
    
    init() {
        var components = [String: [String: Any]]()
        if let url = Bundle.main.url(forResource: "components", withExtension: "bundle") {
            
            if let files = try? FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: []) {
                for file in files {
                    if file.pathExtension != "json" {
                        continue
                    }
                    if let jsonData = try? Data(contentsOf: file) {
                        if let jsonResult = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String : Any] {
                            let name = file.lastPathComponent.replacingOccurrences(of: ".\(file.pathExtension)", with: "")
                            if let level0 = jsonResult[name] as? [String: Any] {
                                components[name] = level0
                                if name == "RButton" {
                                    //print(jsonResult)
                                }
                            }
                        }
                    }
                }
            }
        }
        self.components = components
    }
    
    func stringValue(component: String, key: String) -> String? {
        guard let componentObject = self.components[component] else {return nil}
        return componentObject[key] as? String
    }

    func intValue(component: String, key: String) -> Int? {
        guard let componentObject = self.components[component] else {return nil}
        return componentObject[key] as? Int
    }

    func cgfloatValue(component: String, key: String) -> CGFloat? {
        guard let componentObject = self.components[component] else {return nil}
        return componentObject[key] as? CGFloat
    }

    func dictValue(component: String, key: String) -> [String: Any]? {
        guard let componentObject = self.components[component] else {return nil}
        return componentObject[key] as? [String: Any]
    }

}
