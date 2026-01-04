
import SwiftUI
import PencilKit

#if USE_OBSERVABLE
import Observation

@Observable
open class DrawableObservableDocument {
    public var drawing: PKDrawing
    public var drawingBackgroundImage: UIImage?
    
    public init( drawing: PKDrawing ) {
        self.drawing = drawing
    }
    
    public convenience init() {
        self.init( drawing: PKDrawing() )
    }
}
#else
open class DrawableObservableDocument : ObservableObject {
    @Published public var drawing: PKDrawing
    @Published public var drawingBackgroundImage: UIImage?
    
    public init( drawing: PKDrawing ) {
        self.drawing = drawing
    }
    
    public convenience init() {
        self.init( drawing: PKDrawing() )
    }
}
#endif
