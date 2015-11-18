"
A MavenDependancy is a dependency between two MavenModules.

Instance Variables
	scope:		aString
	isGlobal:         aBoolean 

scope
	- The context in which the dependency should be used

isGlobal
	- true if the link provides from dependencyManagement tag
"
Class {
	#name : #MavenDependency,
	#superclass : #FAMIXAssociation,
	#instVars : [
		'source',
		'target',
		'scope',
		'isGlobal'
	],
	#category : #'Maven-Core'
}

{ #category : #meta }
MavenDependency class >> annotation [
	<MSEClass: #Reference super: #FAMIXAssociation>
	<package: #FAMIX>
	^self
]

{ #category : #'initialize-release' }
MavenDependency class >> source: source target: target [
	^ self new source: source; target: target
]

{ #category : #accessing }
MavenDependency >> from [
	<MSEProperty: #source type: #MavenModule opposite: #outgoingReferences>
	<MSEComment: 'Source entity making the dependency. from-side of the association'>
	^ self source. 
]

{ #category : #accessing }
MavenDependency >> from: aSource [
	self source: aSource
]

{ #category : #'initialize-release' }
MavenDependency >> initialize [
	super initialize.
	source := nil.
	target := nil.
	isGlobal := false.
	scope := nil
]

{ #category : #accessing }
MavenDependency >> isGlobal [
	<MSEProperty: #isGlobal type: #Boolean>
	<MSEComment: 'True if definied in global dependencies'>
	^ isGlobal
	
]

{ #category : #accessing }
MavenDependency >> isGlobal: aBoolean [
	isGlobal := aBoolean
	
]

{ #category : #printing }
MavenDependency >> mooseNameOn: aStream [

	self from name ifNotNil: [ aStream nextPutAll: self from name ].
	aStream nextPutAll: ' depends on '.
	self to name ifNotNil: [ aStream nextPutAll: self to name ]
]

{ #category : #printing }
MavenDependency >> printOn: aStream [
	super printOn: aStream.
	aStream nextPutAll: ' (Dependency)'
]

{ #category : #accessing }
MavenDependency >> scope [
	<MSEProperty: #scope type: #String>
	<MSEComment: 'The scope of the dependency. Nil if any'>
	^ scope
]

{ #category : #accessing }
MavenDependency >> scope: aString [
	scope := aString
]

{ #category : #accessing }
MavenDependency >> source [
	<MSEProperty: #source type: #MavenModule opposite: #outgoingDependencies>
	<MSEComment: 'Source entity making the dependency. from-side of the association'>
	
	^source
]

{ #category : #accessing }
MavenDependency >> source: aContainerEntity [
	source := FMMultivalueLink on: self
					update: #outgoingDependencies
					from: self source
					to: aContainerEntity
]

{ #category : #accessing }
MavenDependency >> target [
	<MSEProperty: #target type: #MavenModule opposite: #incomingDependencies>
	<MSEComment: 'Target entity dependent. to-side of the association'>
	
	^target
]

{ #category : #accessing }
MavenDependency >> target: aContainerEntity [
	target := FMMultivalueLink on: self
					update: #incomingDependencies
					from: self target
					to: aContainerEntity
]

{ #category : #accessing }
MavenDependency >> to [
	<MSEProperty: #target type: #MavenModule opposite: #incomingDependencies>
	<MSEComment: 'Target entity referenced. to-side of the association'>
	^ self target
]

{ #category : #accessing }
MavenDependency >> to: aTarget [
	self target: aTarget
]
