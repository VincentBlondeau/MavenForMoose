"
A MavenProjectImporter is a tool to import a lot of maven projets given a project root directory.

Instance Variables
	model:		a MooseModel
	rootFolder:		aString

model
	- the maven model generated by the importer

rootFolder
	- the folder containing the pom.xml

"
Class {
	#name : #MavenProjectImporter,
	#superclass : #PAIAAbstractFileImporterInModel,
	#category : #'Maven-Importer'
}

{ #category : #accessing }
MavenProjectImporter class >> neededSources [
	^ #()
]

{ #category : #private }
MavenProjectImporter >> basicRun [
	self importModulesFromFiles: self collectMavenPomFiles.
	self resolveSubModulesContainment.

]

{ #category : #private }
MavenProjectImporter >> collectMavenPomFiles [
	^ MavenXMLRetriver runOn: rootFolder
]

{ #category : #private }
MavenProjectImporter >> importModulesFromFiles: aCollectionOfFiles [
	aCollectionOfFiles
		do: [ :aFile | MavenModuleImporter runOnXmlFileNamed: aFile inRootDirectory: self rootFolder with: self model ]
]

{ #category : #private }
MavenProjectImporter >> resolveSubModulesContainment [
	MavenContainmentResolver new model: self model; run.
]