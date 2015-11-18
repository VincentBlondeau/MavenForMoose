"
A MavenModule is a maven module representing a pom.xml.

Instance Variables
	artifactID:		aString
	groupID:		aString
	version:		aString
	modules:	aCollectionOfStrings


artifactID
	- xxxxx

groupID
	- xxxxx

version
	- xxxxx

modules
	- xxxxx

"
Class {
	#name : #MavenModule,
	#superclass : #FAMIXType,
	#instVars : [
		'groupID',
		'artifactID',
		'version',
		'modules'
	],
	#category : #'Maven-Core'
}

{ #category : #'as yet unclassified' }
MavenModule class >> annotation [
	<MSEClass: #MavenModule super: #FAMIXType>
	<package: #Maven>
	^ self
]

{ #category : #accessing }
MavenModule >> artifactID [
	<MSEProperty: #artifactID type: #String>
	<MSEComment: 'ID of the maven module'>
	^ artifactID
]

{ #category : #accessing }
MavenModule >> artifactID: aString [
	artifactID := aString
]

{ #category : #accessing }
MavenModule >> classes [
	^#()
]

{ #category : #accessing }
MavenModule >> groupID [
	<MSEProperty: #groupID type: #String>
	<MSEComment: 'Name of the maven module group'>
	^ groupID
]

{ #category : #accessing }
MavenModule >> groupID: aString [
	groupID := aString
]

{ #category : #accessing }
MavenModule >> incomingDependencies [
	<MSEProperty: #incomingDependencies type: #MavenDependency opposite: #target>
	<multivalued>
	<derived>
	<MSEComment: 'Dependences to this module by other modules.'>
	^ self privateState
		attributeAt: #incomingDependencies
		ifAbsentPut: [ FMMultivalueLink on: self opposite: #target: ]
]

{ #category : #'initialize-release' }
MavenModule >> initialize [
	super initialize.
	modules := OrderedCollection new.
	groupID := nil.
	artifactID := nil.
	version := nil
]

{ #category : #accessing }
MavenModule >> modules [
	<MSEProperty: #modules type: #String>	<multivalued>
	<MSEComment: 'Modules defined in the maven  module, if any.'>
	^ modules
]

{ #category : #accessing }
MavenModule >> modules: anObject [
	modules := anObject
]

{ #category : #accessing }
MavenModule >> name [
	^ self artifactID ifNil: [ 'unamed' ]
]

{ #category : #accessing }
MavenModule >> outgoingDependencies [
	<MSEProperty: #outgoingDependencies type: #MavenDependency opposite: #source>
	<multivalued>
	<derived>
	<MSEComment: 'Dependences from this module to other modules.'>
	^ self privateState
		attributeAt: #outgoingDependencies
		ifAbsentPut: [ FMMultivalueLink on: self opposite: #source: ]
]

{ #category : #accessing }
MavenModule >> outgoingMavenDependencies [
	^ self outgoingDependencies collect: #target
]

{ #category : #printing }
MavenModule >> printOn: aStream [
	self name ifNotNil: [ aStream nextPutAll: self name ]
]

{ #category : #accessing }
MavenModule >> propertiesDictionary [
	<MSEProperty: #propertiesDictionary type: #MavenProperty opposite: #parentScope> <multivalued> <derived>
	<MSEComment: 'Global variables defined in the maven module scope, if any.'>
	^ self attributes
]

{ #category : #accessing }
MavenModule >> propertiesDictionary: anObject [
	self attributes: anObject
]

{ #category : #accessing }
MavenModule >> version [
	<MSEProperty: #version type: #String>
	<MSEComment: 'Version of the maven module'>
	^ version
]

{ #category : #accessing }
MavenModule >> version: anEnvironmentVariable [
	version := anEnvironmentVariable
]
