Extension { #name : #FAMIXClass }

{ #category : #'*Maven-Core' }
FAMIXClass >> importedClasses [
	^ self queryOutgoingDependencies atTypeScope withoutSelfLoops
		collect: [ :javaImportedType | 
			(javaImportedType isKindOf: FAMIXParameterizedType)
				ifTrue: [ javaImportedType parameterizableClass ]
				ifFalse: [ javaImportedType ] ]
]

{ #category : #'*Maven-Core' }
FAMIXClass >> mavenModule [
	<MSEProperty: #mavenModule type: #MavenModule opposite: #relatedJavaClasses>
	<multivalued>
	<MSEComment: 'the Maven module containing this class'>
	^ self privateState cacheAt: #mavenModule ifAbsent: [ nil ]
]

{ #category : #'*Maven-Core' }
FAMIXClass >> mavenModule: aMavenModule [
	self privateState cacheAt: #mavenModule put: (FMMultivalueLink 
		on: self
		update: #relatedJavaClasses
		from: self mavenModule
		to: aMavenModule).
]
