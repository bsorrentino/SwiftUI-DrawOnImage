
import SwiftUI
import PencilKit

class PlantUMLObservableDocument : ObservableObject{
    @Published var drawing: PKDrawing
    @Published var drawingBackgroundImage: UIImage?
    
    init( ) {
        self.drawing = PKDrawing()
    }
}
