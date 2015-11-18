"
A MavenXMLRetriver is a finder of pom.xml.

"
Class {
	#name : #MavenXMLRetriver,
	#superclass : #MAMAbstractFilesRetriever,
	#category : #'Maven-Importer'
}

{ #category : #accessing }
MavenXMLRetriver >> fileName [
	^ 'pom.xml' 
]
