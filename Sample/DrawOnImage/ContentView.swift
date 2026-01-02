//
//  ContentView.swift
//  DrawOnImage
//
//  Created by Bartolomeo Sorrentino on 03/02/23.
//

import SwiftUI
import PencilKit
import DrawOnImage

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
    @Environment( \.colorScheme) var colorScheme
    @StateObject var document = DrawableObservableDocument()
    @State var scroll: Bool = false
    @State var draw: Bool = false
    @State private var snapshot: UIImage?
    @State private var resultImage: UIImage? = nil
    @State private var requestImage = false

    var body: some View {
        DrawingView( document: document,
                     isUsePickerTool: draw,
                     isScrollEnabled: scroll,
                     requestImage: requestImage,
                     resultImage: $resultImage)
        .onChange( of: requestImage ) { newValue in
            if newValue {
                processImage()
                requestImage = false
            }
        }
        .onAppear {
            document.drawingBackgroundImage = image
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button( action: {
                    //processImage()
                    requestImage = true
                }, label: {
                    Label( "share", systemImage: "")
                        .labelStyle(.titleOnly)
                })
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    
                } label: {
                    Label("Import", systemImage: "photo.badge.plus")
                        .foregroundColor(Color.orange)
                }
            }
            
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
    
    func processImage() {
        guard let resultImage else {
            return
        }
        
        // getting image from Canvas
        
        let backgroundColor:UIColor = (colorScheme == .dark ) ? .black : .white
        let image = resultImage.withBackground(color: backgroundColor)
        
        if let imageData = image.pngData() {
            
            saveData(imageData,
                     toFile: "image.png",
                     inDirectory: .picturesDirectory)
        }
    }
    
    fileprivate func saveData( _ data: Data,
                               toFile fileName: String,
                               inDirectory directory: FileManager.SearchPathDirectory ) {
        do {
            let dir = try FileManager.default.url(for: directory,
                                                  in: .userDomainMask,
                                                  appropriateFor: nil,
                                                  create: true)
            let fileURL = dir.appendingPathComponent(fileName)
            print( "fileURL\n\(fileURL)")
            try data.write(to: fileURL)
        }
        catch {
            print( "error saving file \(error.localizedDescription)" )
        }
    }

  
}

#Preview {
    NavigationStack {
        ContentView( image: UIImage( named: "diagram1" )  )
    }
}


