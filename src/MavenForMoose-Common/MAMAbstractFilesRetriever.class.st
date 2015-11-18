"
A PAIAFilesRetriever is a finder of files named in fileName and not present in excludedDirectories.

<aPAIAAbstractFilesRetriever  subclass> runOn: <aRootfolder>
<aRootfolder> should be a string an not a FileReference

Instance Variables
	rootFolder:		aString

rootFolder
	- the file dir to begin the files search
.

"
Class {
	#name : #MAMAbstractFilesRetriever,
	#superclass : #Object,
	#instVars : [
		'rootFolder'
	],
	#category : #'MavenForMoose-Common-Core'
}

{ #category : #public }
MAMAbstractFilesRetriever class >> runOn: aRootFolder [
	^ self new
		rootFolder: aRootFolder;
		run
]

{ #category : #collecting }
MAMAbstractFilesRetriever >> collectFiles [
	| visitor |
	visitor := SelectVisitor select: self fileSelectionBlock.
	^ visitor
		visit: self rootFolder
		with:
			((BreadthFirstGuide for: visitor)
				selectChildren: [ :entry | self  excludedDirectories inject: true into: [ :boolean :dirName | boolean and: [ entry name ~= dirName ] ] ])
]

{ #category : #accessing }
MAMAbstractFilesRetriever >> excludedDirectories [ 
	^ {'target' . '.svn' . 'src' }
]

{ #category : #accessing }
MAMAbstractFilesRetriever >> fileName [
	self subclassResponsibility
]

{ #category : #collecting }
MAMAbstractFilesRetriever >> fileSelectionBlock [
	^ [ :file | file name = self fileName ]
]

{ #category : #accessing }
MAMAbstractFilesRetriever >> rootFolder [
	^ rootFolder
]

{ #category : #accessing }
MAMAbstractFilesRetriever >> rootFolder: aFileReference [
	rootFolder := aFileReference 
]

{ #category : #running }
MAMAbstractFilesRetriever >> run [
	^ self collectFiles
]
