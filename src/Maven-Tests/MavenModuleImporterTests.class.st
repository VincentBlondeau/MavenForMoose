Class {
	#name : #MavenModuleImporterTests,
	#superclass : #MavenImporterTests,
	#category : #'Maven-Tests'
}

{ #category : #running }
MavenModuleImporterTests >> setUp [
	super setUp.
	importer := MavenModuleImporter new
						model: model ;
						rootFolder: '/root' asFileReference;
						yourself
]

{ #category : #tests }
MavenModuleImporterTests >> testMavenXMLImport [
	importer xmlFile: self filePomRoot; run.
	"model halt."
]

{ #category : #tests }
MavenModuleImporterTests >> testMavenXMLImport2 [
	importer xmlFile: self filePomSub; run
]

{ #category : #tests }
MavenModuleImporterTests >> testMavenXMLImport2WithDuplicatedDependancies [
	| dependencies |
	importer
		xmlFile: self filePomSub;
		run.
	dependencies := model allWithType: MavenDependency.
	self assert: dependencies isNotEmpty.
	dependencies
		do:
			[ :dep1 | 
			dependencies
				do:
					[ :dep2 | 
					self
						deny:
							((dep1 source = dep2 source and: [ dep1 target = dep2 target ])
								xor: [ dep1 mooseID = dep2 mooseID ]) ] ]
]

{ #category : #tests }
MavenModuleImporterTests >> testMavenXMLImport3 [
	importer xmlFile: self filePomSub2; run.
	self assert: (model allWithType: MavenModule) size equals: 5. 
	self assert: (model allWithType: MavenDependency) size equals: 3
]

{ #category : #tests }
MavenModuleImporterTests >> testMavenXMLImportDependenciesLinks [
	| dependancies |
	importer xmlFile: self filePomRoot; run.
	dependancies := model allWithType: MavenDependency. 
	self assert: dependancies size equals: 7.
	(dependancies select: [ :d | d isGlobal not ])
		do: [ :dependency | 
			self assert: (dependency scope isNil or: [ dependency scope isNotEmpty ]).
			self assert: dependency from isNotNil.
			self assert: dependency to isNotNil ].
	self assert: (dependancies select: [ :d | d isGlobal ]) size equals: 1.
	self assert: (dependancies select: [ :d | d isGlobal ]) first scope equals: nil
]

{ #category : #tests }
MavenModuleImporterTests >> testMavenXMLImportEmptyDoc [
	| module |
	importer
		xmlFile: self filePomEmpty;
		run.
	self assert: (model allWithType: MavenModule) size equals: 1.
	module := (model allWithType: MavenModule) first.
	self assert: module groupID equals: 'com.example'.
	self assert: module artifactID equals: 'quickstart'.
	self assert: module version equals: '1.0-SNAPSHOT'.
	self assert: module name equals: 'quickstart'
]

{ #category : #tests }
MavenModuleImporterTests >> testMavenXMLImportGlobalVariables [
	| properties propertiesNotSet |
	importer
		xmlFile: self filePomRoot;
		run.
	properties := model allWithType: MavenProperty.
	self assert: properties size equals: 9.
	propertiesNotSet := properties select: [ :p | p name isNil or: [ p value isNil ] ].
	self assert: propertiesNotSet isEmpty
]

{ #category : #tests }
MavenModuleImporterTests >> testMavenXMLImportInheritanceRelations [
	| inheritances |
	importer
		xmlFile: self filePomRoot;
		run.
	inheritances := model allWithType: MavenInheritance.
	self assert: inheritances isEmpty not.
	self assert: inheritances first superclass artifactID equals: 'kazan-parent'.
	self assert: inheritances first subclass artifactID equals: 'damartex'
]

{ #category : #tests }
MavenModuleImporterTests >> testMavenXMLImportModuleElements [
	| mainModule |
	importer
		xmlFile: self filePomRoot;
		run.
	mainModule := (model allWithType: MavenModule) select: [ :m | m isStub not ].
	self assert: mainModule size equals: 1.
	self assert: mainModule first groupID equals: 'net.atos.awl.ri.damart'.
	self assert: mainModule first artifactID equals: 'damartex'.
	self assert: mainModule first version equals: '1.2.3'.
	self assert: mainModule first attributes size equals: 9.
	self assert: mainModule first modules size equals: 18.
	self assert: (model allWithType: MavenModule) size equals: 9
]

{ #category : #tests }
MavenModuleImporterTests >> testMavenXMLImportModulesItems [
	| mainModule |
	importer xmlFile: self filePomRoot; run.
	mainModule := (model allWithType: MavenModule) select: [ :m | m isStub not ].
	mainModule first modules isNotEmpty.
	self assert: mainModule first modules first equals: 'damartex-front'.
]
