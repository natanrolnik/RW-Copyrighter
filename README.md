# RW-Copyrighter

This executable has the purpose of adding the Ray Wenderlich copyright notice to specific files in a project.

## Usage

After cloning this repo, you can use the script in two ways:

### Using [Swift Sh](https://github.com/mxcl/swift-sh)

1. Install swift-sh `brew install mxcl/made/swift-sh`
2. In the project root, run the following command:

`swift-sh Sources/RW-Copyrighter/main.swift "/Your/Project/Path"`

By default, the copyright notice is added to Swift, Objective-C, Kotlin, and Java files. If you want to add the notice to other files instead of the default, just specify the desired file types (comma separated):

`swift-sh Sources/RW-Copyrighter/main.swift "/Your/Project/Path" --filetypes swift,js`

### Using Xcode

1. Run `swift package update`
2. Open Xcode
3. Insert the path as the first (**unnamed**) argument, and if desired, the file types as another argument: `--filetypes swift,js`.
