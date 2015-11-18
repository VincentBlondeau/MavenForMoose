Extension { #name : #XMLNodeList }

{ #category : #'*Maven-Importer' }
XMLNodeList >> getStringAt: anElementSelector [
	^ (self elementAt: anElementSelector ifAbsent: [ MavenNotFound signalFor: anElementSelector ]) firstNode asString
]

{ #category : #'*Maven-Importer' }
XMLNodeList >> moduleArtifactId [
	^ self getStringAt: #artifactId
]

{ #category : #'*Maven-Importer' }
XMLNodeList >> moduleGroupId [
	^ self getStringAt: #groupId 
]

{ #category : #'*Maven-Importer' }
XMLNodeList >> moduleName [
	^ self getStringAt: #name 
]

{ #category : #'*Maven-Importer' }
XMLNodeList >> moduleScope [
	^ self getStringAt: #scope 
]

{ #category : #'*Maven-Importer' }
XMLNodeList >> moduleVersion [
	^ self getStringAt: #version
]
