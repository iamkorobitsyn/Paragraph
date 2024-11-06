//
//  DocumentPeacker.swift
//  Paragraph
//
//  Created by Александр Коробицын on 24.05.2024.
//

import SwiftUI
import UniformTypeIdentifiers
import MobileCoreServices

struct DocPicButton: View {
    @State private var showDocumentPicker = false

    var body: some View {
        VStack {
            Button("Выбрать файл") {
                showDocumentPicker = true
            }
        }
        .sheet(isPresented: $showDocumentPicker) {
            DocumentPicker()
        }
    }
}

struct DocumentPicker: UIViewControllerRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.data])
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}

    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var parent: DocumentPicker

        init(_ parent: DocumentPicker) {
            self.parent = parent
        }

        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard let url = urls.first else { return }
            // Сохранение файла в приложении
            do {
                
                let fileManager = FileManager.default
                let documentsURL = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                print("Work")
                let savedURL = documentsURL.appendingPathComponent(url.lastPathComponent)
                try fileManager.copyItem(at: url, to: savedURL)
                print("Файл сохранен: \(savedURL)")
            } catch {
                print("Ошибка сохранения файла: \(error.localizedDescription)")
            }
        }
    }
}
