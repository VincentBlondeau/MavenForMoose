Extension { #name : #XMLNodeWithElements }

{ #category : #'*Maven-Importer' }
XMLNodeWithElements >> getStringAt: anElementSelector [
	^ (self elementAt: anElementSelector ifAbsent: [ MavenNotFound signalFor: anElementSelector ]) firstNode asString
]

{ #category : #'*Maven-Importer' }
XMLNodeWithElements >> moduleArtifactId [
	^ self getStringAt: #artifactId 
]

{ #category : #'*Maven-Importer' }
XMLNodeWithElements >> moduleGroupId [
	^ self getStringAt: #groupId
]

{ #category : #'*Maven-Importer' }
XMLNodeWithElements >> moduleName [
	^ self getStringAt: #name
]

{ #category : #'*Maven-Importer' }
XMLNodeWithElements >> moduleScope [
	^ self getStringAt: #scope
]

{ #category : #'*Maven-Importer' }
XMLNodeWithElements >> moduleVersion [
	^ self getStringAt: #version
]
