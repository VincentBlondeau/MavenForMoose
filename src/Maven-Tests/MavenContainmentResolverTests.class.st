Class {
	#name : #MavenContainmentResolverTests,
	#superclass : #MavenImporterTests,
	#instVars : [
		'module'
	],
	#category : #'Maven-Tests'
}

{ #category : #accessing }
MavenContainmentResolverTests >> moduleArtifactID [
	^ #('module1' 'module2' 'module3') asOrderedCollection
]

{ #category : #running }
MavenContainmentResolverTests >> setUp [
	| subModule |
	super setUp.
	module := MavenModule new modules: self moduleArtifactID.
	model add: module.
	self moduleArtifactID
		do: [ :eachArtifactID | 
			subModule := model add: (MavenModule new artifactID: eachArtifactID).
			model
				add:
					(MavenInheritance new
						superclass: module;
						subclass: subModule) ]
]

{ #category : #tests }
MavenContainmentResolverTests >> testModuleContainmentResolving [
	MavenContainmentResolver new model: model; run.
	
	self assert: module types size equals: 3.
	
]
