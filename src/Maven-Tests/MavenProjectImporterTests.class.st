Class {
	#name : #MavenProjectImporterTests,
	#superclass : #MavenImporterTests,
	#category : #'Maven-Tests'
}

{ #category : #running }
MavenProjectImporterTests >> setUp [
	super setUp.
	importer := MavenProjectImporter new
		model: model;
		yourself.
		


]

{ #category : #tests }
MavenProjectImporterTests >> testMavenProjectImporter [
	| files |
	importer
		rootFolder: (self fileNamed: '/root') asFileReference; 
		run.
	files := model allWithType: FAMIXFileAnchor.
	self assert: files size equals: 4.
	self assert: files first fileName equals: './pom.xml'.
	self assert: files second fileName equals: './empty/pom.xml'.
	self assert: files third fileName equals: './sub/pom.xml'.
	self assert: (files at: 4) fileName equals: './sub2/pom.xml'.
	self assert: model allMavenModules size equals: 24.
	self assert: model allRootModules size equals: 4
]
