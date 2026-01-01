//
//  ContentView.swift
//  DrawOnImage
//
//  Created by Bartolomeo Sorrentino on 03/02/23.
//

import SwiftUI
import PencilKit


struct ToggleButton<Label> : View where Label : View  {
     
    @Binding var state:Bool
    var content: ( Bool ) -> Label

    init( _ state: Binding<Bool>, content: @escaping ( Bool ) -> Label ) {
        self._state = state
        self.content = content
    }
    
    var body: some View {
        Button {
            state.toggle()
        } label: {
            content( state )
        }
    }
    
}

struct ContentView: View {
    
    var image: UIImage?
    @State var document = PlantUMLObservableDocument()
    @State var scroll: Bool = false
    @State var draw: Bool = false
    @State private var snapshot: UIImage?
    
    var body: some View {
        DrawingView( document: document,
                     isUsePickerTool: draw,
                     isScrollEnabled: scroll,
                     requestImage: false,
                     resultImage: .constant(nil))
        .onAppear {
            document.drawingBackgroundImage = image
        }
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                ToggleButton($scroll) {
                    ($0 ?
                     Label("", systemImage: "lock") :
                        Label("", systemImage: "lock.open"))
                    .labelStyle(.iconOnly)
                }
                ToggleButton($draw) {
                    ($0 ?
                     Label("", systemImage: "pencil.circle.fill") :
                        Label("", systemImage: "pencil.circle"))
                    .labelStyle(.iconOnly)
                }
            }
        }
    }
}

#Preview(traits: .portrait) {
    ContentView( image: UIImage( named: "diagram1" )  )
}
#Preview(traits: .landscapeLeft) {
    ContentView( image: UIImage( named: "diagram1" )  )
}

