#!/usr/bin/swift sh

import Files // @JohnSundell
import Commander //@kylef

let copyrightStatement =
"""
/// Copyright (c) 2019 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.


"""

func prependTextIfNeeded(_ text: String, to file: Files.File, fileTypes: Set<String>) throws -> Bool {
    guard let fExtension = file.extension, fileTypes.contains(fExtension) else {
        return false
    }

    let initialFileContents = try file.readAsString()
    let finalFileContents: String

    //TODO: refactor it in a different way in case there are more edge cases
    switch file.name {
    case "Package.swift":
        if let firstLineBreakIndex = initialFileContents.firstIndex(of: "\n") {
            var final = initialFileContents
            final.insert(contentsOf: "\n" + text, at: initialFileContents.index(after: firstLineBreakIndex))
            finalFileContents = final
        } else {
            finalFileContents = text + initialFileContents
        }
    default:
        finalFileContents = text + initialFileContents
    }

    try file.write(string: finalFileContents)

    return true
}

func addCopyrightNotice(at path: String, fileTypes: Set<String>) throws -> Int {
    let rootFolder = try Folder(path: path)
    var addedFilesCount = 0
    try rootFolder.makeFileSequence(recursive: true, includeHidden: false).forEach {
        let added = try prependTextIfNeeded(copyrightStatement, to: $0, fileTypes: fileTypes)
        if added {
            addedFilesCount += 1
        }
    }

    return addedFilesCount
}

command(
    Argument<String>("path", description: "The path of the directory to prepend the copyright notice"),
    Option<String>("filetypes", default: "swift,h,m,kt,java", description: "The file extensions, separated by commas and no spaces, to add the notice to")
) { path, fileTypes in
    do {
        let typesArray = fileTypes.split(separator: ",").map { String($0) }
        let typesSet = Set(typesArray)
        let result = try addCopyrightNotice(at: path, fileTypes: typesSet)
        print("Added the RW Copyright to \(result) swift files")
    } catch {
        print("Error while executing RW-Copyrighter:", error)
    }
}.run()
