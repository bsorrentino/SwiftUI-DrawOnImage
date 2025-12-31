
import SwiftUI
import Observation
import PencilKit

@Observable
class PlantUMLObservableDocument {
    var drawing: PKDrawing
    var drawingBackgroundImage: UIImage?
    
    init( ) {
        self.drawing = PKDrawing()
    }
}
