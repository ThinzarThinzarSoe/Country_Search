
import UIKit

enum Direction {
    case leftToRight
    case rightToLeft
    case topToBottom
    case bottomToTop
}

enum iOSDeviceSizes {
    case tabletSize
    case miniSize
    case plusSize
    case maxSize
    
    func getBool() -> Bool {
        switch self {
        case .miniSize:
            return UIDevice.is_iPhoneMiniDevices()
        case .tabletSize:
            return UIDevice.is_iPadDevice()
        case .plusSize:
            return UIDevice.is_iPhonePlusDevices()
        case .maxSize:
            return UIDevice.is_iPhoneMaxDevices()
        }
    }
}

enum ErrorType: Error {
    case NoInterntError
    case NoDataError
    case SeverError
    case KnownError(_ errorMessage: String)
    case UnKnownError
}

public enum RequestType: String {
    case GET, POST
}
