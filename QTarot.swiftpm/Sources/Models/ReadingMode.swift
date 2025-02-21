enum ReadingMode {
    case randomReading
    case questionReading(String)
    case fullReading
    
    var hasQuestion: Bool {
        if case .questionReading(_) = self {
            return true
        }
        return false
    }
    
    var question: String? {
        if case .questionReading(let question) = self {
            return question
        }
        return nil
    }
} 