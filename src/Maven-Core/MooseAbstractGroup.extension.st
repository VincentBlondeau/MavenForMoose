Extension { #name : #MooseAbstractGroup }

{ #category : #'*Maven-Core' }
MooseAbstractGroup >> allMavenModules [
	<navigation: 'All modules'>
	^ self allWithType: MavenModule  
]

{ #category : #'*Maven-Core' }
MooseAbstractGroup >> allRootModules [
	<navigation: 'All root modules'>
	^ (self allWithType: MavenModule)
		select: [ :m | (m anySuperclass isNil and: [ m isStub not ]) or: [ m anySuperclass isNotNil and: [ m anySuperclass isStub ] ] ] 
]

{ #category : #'*Maven-Core' }
MooseAbstractGroup >> findMavenModulesWithGroupId: moduleGroupId withArtifactId: moduleArtifactId withVersion: moduleVersion [
	| result |
	result := self allMavenModules select: [ :m | m groupID = moduleGroupId and: [ m artifactID = moduleArtifactId ] ].
	(result select: [ :m | m version = moduleVersion ])
		do: [ :m | self log: 'Existing ' , m artifactID ,'( ',m groupID,' ) has not the same version than ' , moduleArtifactId, String cr].
	^ result
]
