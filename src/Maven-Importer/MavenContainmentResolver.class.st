"
A MavenContainmentResolver is a class that links the module with its submodules (in <modules> </modules> tag in the pom.xml)  in a model.

This resolving have to be done after adding all modules into the model else the resolution will be not complete

Instance Variables
	model:		a MooseModel

model
	- the model where the links have to be made

"
Class {
	#name : #MavenContainmentResolver,
	#superclass : #PAIAAbstractModelOperator,
	#category : #'Maven-Importer'
}

{ #category : #accessing }
MavenContainmentResolver class >> neededSources [
	^ #()
]

{ #category : #'as yet unclassified' }
MavenContainmentResolver >> basicRun [
	self modulesToResolve do: [ :module | self resolveModule: module ]
]

{ #category : #private }
MavenContainmentResolver >> findInto: moduleGroup moduleWithArtifactId: subModuleName [
	^ moduleGroup
		detect: [ :module | module artifactID = subModuleName ]
		ifNone: [ 
			moduleGroup
				detect: [ :module | 
					module directSubclasses
						ifNotEmpty: [ self findInto: module directSubclasses moduleWithArtifactId: subModuleName ]
						ifEmpty: [ false ] ] ]
]

{ #category : #private }
MavenContainmentResolver >> findInto: moduleGroup moduleWithArtifactIdContaining: subModuleName [
	^ moduleGroup
		detect: [ :module | module sourceAnchor fileName includesSubstring: subModuleName ]
		ifNone: [ 
			moduleGroup
				detect: [ :module | 
					module directSubclasses
						ifNotEmpty: [ self findInto: module directSubclasses moduleWithArtifactId: subModuleName ]
						ifEmpty: [ false ] ] ]
]

{ #category : #private }
MavenContainmentResolver >> modulesToResolve [
	^ (self model allWithType: MavenModule) select: [ :m | m modules isNotNil ]
]

{ #category : #private }
MavenContainmentResolver >> resolveModule: module [
	module modules
		do: [ :subModuleName | 
			| subModuleElement |
			[ 
			subModuleElement := [ self findInto: module directSubclasses moduleWithArtifactId: subModuleName ]
				on: NotFound
				do: [ self findInto: module directSubclasses moduleWithArtifactIdContaining: subModuleName ].
			subModuleElement container: module ]
				on: Error
				do: [ self log: 'The module' , subModuleName , 'is not found !' ] ]
]
