"
A PAIAAbstractXMLImporterInModel class is an importer of an XML file.
With this you can import only one xml file locaated in a folder.

You should use the method:
runOnXmlFileNamed: <xmlFileName> inRootDirectory: <aFolder represented by a string> with: <aMooseModel>
to execute it.

"
Class {
	#name : #MAMAbstractXMLImporterInModel,
	#superclass : #MAMAbstractFileImporterInModel,
	#instVars : [
		'xmlFile'
	],
	#category : #'MavenForMoose-Common-Core'
}

{ #category : #running }
MAMAbstractXMLImporterInModel class >> runOnDirectory: aFolder with: aMooseModel [
	^ self shouldNotImplement
]

{ #category : #running }
MAMAbstractXMLImporterInModel class >> runOnXmlFileNamed: xmlFileName inRootDirectory: aFolder with: aMooseModel [
	^ self new
		xmlFile: xmlFileName ;
		rootFolder: aFolder;
		model: aMooseModel;
		run
]

{ #category : #accessing }
MAMAbstractXMLImporterInModel >> parser [
	^ XMLDOMParser
]

{ #category : #accessing }
MAMAbstractXMLImporterInModel >> relativeFileName [
	^ './', (self xmlFile fullName 
		copyFrom: self rootFolder fullName size + 2 
		to: self xmlFile fullName size)
]

{ #category : #accessing }
MAMAbstractXMLImporterInModel >> xmlDocument [
	^ self parser parse: self xmlFile readStream
]

{ #category : #accessing }
MAMAbstractXMLImporterInModel >> xmlFile [
	^ xmlFile
]

{ #category : #accessing }
MAMAbstractXMLImporterInModel >> xmlFile: aFileLocationOrAString [
	xmlFile := aFileLocationOrAString
]
