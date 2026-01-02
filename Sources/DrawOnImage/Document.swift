
import SwiftUI
import PencilKit

open class DrawableObservableDocument : ObservableObject{
    @Published public var drawing: PKDrawing
    @Published public var drawingBackgroundImage: UIImage?
    
    public init( ) {
        self.drawing = PKDrawing()
    }
}
