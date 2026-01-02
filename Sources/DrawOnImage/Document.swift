
import SwiftUI
import Observation
import PencilKit

@Observable
open class DrawableObservableDocument {
    public var drawing: PKDrawing
    public var drawingBackgroundImage: UIImage?
    
    public init( ) {
        self.drawing = PKDrawing()
    }
}
