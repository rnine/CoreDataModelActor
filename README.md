# CoreDataModelActor

**CoreDataModelActor** is a Swift Package that extends and enhances the ideas presented by **fatbobman** in his [article](https://fatbobman.com/en/posts/core-data-reform-achieving-elegant-concurrency-operations-like-swiftdata/) and the associated experimental project [CoreDataEvolution](https://github.com/fatbobman/CoreDataEvolution). This package introduces support for older platforms (down to iOS 13) and provides two different executors to manage Core Data concurrency across various versions of Apple's operating systems.

### Example Usage

Here’s an example of how to use **CoreDataModelActor** to manage Core Data operations with actors:

```swift
import Foundation
import CoreDataModelActor
import CoreDataModelActorMacros

@NSModelActor
actor DocumentsRepository {
    func toggleFavorite(objectURIs: [URL]) async throws {
        let documents: [CDDocument] = await modelContext.objects(withURIRepresentations: objectURIs)

        for document in documents {
            document.isFavorite.toggle()
        }

        try modelContext.saveIfNeeded()
    }
}
```

### Minimum Supported Targets

- macOS 10.15
- iOS 13
- tvOS 13
- watchOS 6
- Mac Catalyst 13

### Credits

This project is inspired by and based on the experimental work done by [fatbobman](https://github.com/fatbobman). You can find the original article and project at the following links:

- Article: [Core Data Reform: Achieving Elegant Concurrency Operations Like SwiftData](https://fatbobman.com/en/posts/core-data-reform-achieving-elegant-concurrency-operations-like-swiftdata/)
- Experimental Project: [CoreDataEvolution](https://github.com/fatbobman/CoreDataEvolution)
