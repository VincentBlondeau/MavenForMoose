"
A MavenModuleImporter is an importer of maven pom.xml file and create a model to represent it.

Instance Variables
	model:		a MooseModel

model
	- the model created at the end of the importation

"
Class {
	#name : #MavenModuleImporter,
	#superclass : #MAMAbstractXMLImporterInModel,
	#category : #'Maven-Importer'
}

{ #category : #accessing }
MavenModuleImporter class >> neededSources [
	^ #()
]

{ #category : #adding }
MavenModuleImporter >> addDependenciesFrom: aXMLDocument to: module [
	| dependencies |
	dependencies := self findElementNamed: #dependencies in: aXMLDocument.
	dependencies
		do: [ :aDependency | self addDependencyFrom: aDependency nodes to: module isGlobal: false ]
]

{ #category : #adding }
MavenModuleImporter >> addDependencyFrom: aDependency to: module isGlobal: aBoolean [
	| searchResult |
	searchResult := self getElementWithXMLDescriptionNodes: aDependency.
	searchResult isEmpty
		ifTrue: [ 
			| stub |
			stub := self createModuleStubWithXMLDescription: aDependency.
			model
				add:
					(MavenDependency new 
						target: stub;
						source: module;
						scope: (self ensureIsNotMandatory: [ aDependency moduleScope ]);
						isGlobal: aBoolean;
						yourself) ]
		ifFalse: [ 
			searchResult
				do: [ :foundModule | 
					(self isExistingDependencyFrom: module to: foundModule)
						ifFalse: [ 
							self
								addDependencyLinkFrom: module
								to: foundModule
								withScope: (self ensureIsNotMandatory: [ aDependency moduleScope ])
								isGlobal: aBoolean ] ] ]
]

{ #category : #adding }
MavenModuleImporter >> addDependencyLinkFrom: module to: foundModule withScope: scope isGlobal: aBoolean [
	model
		add:
			(MavenDependency new 
				source: module;
				target: foundModule;
				scope: scope;
				isGlobal: aBoolean;
				yourself)
]

{ #category : #adding }
MavenModuleImporter >> addFileSourceAnchorTo: module [
	| source |
	"	(self xmlFile fullName
				includesSubstring: 		 'D:\Utilisateurs\A577142\Documents\Damar\damartex-1.2.3\damartex-1.2.3\damartex-shopzilla\damartex-shopzilla-webservice\damartex-shopzilla-webservice-client\pom.xml') ifTrue: [self halt ]."
	source := FAMIXFileAnchor new fileName: self relativeFileName; element: module; yourself.
	model add: source.
	module sourceAnchor: source
]

{ #category : #adding }
MavenModuleImporter >> addGlobalDependenciesFrom: aXMLDocument to: module [
	| dependencies |
	dependencies := self findElementNamed: #dependencyManagement in: aXMLDocument.
	dependencies firstElement nodes
		do: [ :aDependency | self addDependencyFrom: aDependency nodes to: module isGlobal: true ]
]

{ #category : #adding }
MavenModuleImporter >> addHeaderFrom: anXMLDocument to: module [
	module artifactID: anXMLDocument firstElement moduleArtifactId.
	module name: (self ensureIsNotMandatory: [ anXMLDocument firstElement moduleName ]).
	module version: (self getVersionFrom: anXMLDocument with: module).
	module groupID: (self getGroupIDFrom: anXMLDocument firstElement nodes )
]

{ #category : #adding }
MavenModuleImporter >> addModulesFrom: anXMLDocument to: module [
	| modulesColl |
	modulesColl := self findElementNamed: #modules in: anXMLDocument.
	modulesColl ifNotEmpty: [ module modules: (modulesColl collect: [ :m | m firstNode asString ]) collection ]
]

{ #category : #adding }
MavenModuleImporter >> addParentFrom: anXMLDocument to: module [
	| moduleParentXMLDescription searchResult |
	moduleParentXMLDescription := self findElementNamed: #parent in: anXMLDocument.
	searchResult := self getElementWithXMLDescriptionNodes: moduleParentXMLDescription.
	searchResult isEmpty
		ifTrue: [ 
			| stub |
			stub := self createModuleStubWithXMLDescription: moduleParentXMLDescription.
			model
				add:
					(MavenInheritance new
						superclass: stub;
						subclass: module;
						yourself) ]
		ifFalse: [ 
			searchResult
				do: [ :foundModule | 
					model
						add:
							(MavenInheritance new
								superclass: foundModule;
								subclass: module;
								yourself) ] ]
]

{ #category : #adding }
MavenModuleImporter >> addPropertiesFrom: anXMLDocument to: module [
	| properties |
	properties := self findElementNamed: #properties in: anXMLDocument.
	properties
		do: [ :prop | 
			self model
				add:
					(MavenProperty new
						name: prop name;
						value: prop nodes first asString;
						parentType: module;
						yourself) ]
]

{ #category : #private }
MavenModuleImporter >> basicRun [
	"converts XML maven description to Moose model with Maven entities"
	self createModelFromXML: self xmlDocument
]

{ #category : #creating }
MavenModuleImporter >> createModelFromXML: anXMLDocument [
	| module element |
	element := self getElementWithXMLDescriptionNodes: anXMLDocument firstElement nodes.
	element isEmpty
		ifTrue: [ module := MavenModule new ]
		ifFalse: [ 
			module := element first.
			module isStub: false ].
	self addFileSourceAnchorTo: module.
	self ensureIsNotMandatory: [ self addPropertiesFrom: anXMLDocument to: module ].
	self ensureIsNotMandatory: [ self addModulesFrom: anXMLDocument to: module ].
	self ensureIsNotMandatory: [ self addParentFrom: anXMLDocument to: module ].
	self ensureIsNotMandatory: [ self addDependenciesFrom: anXMLDocument to: module ].
	self ensureIsNotMandatory: [ self addGlobalDependenciesFrom: anXMLDocument to: module ].
	self addHeaderFrom: anXMLDocument to: module.	"The header must be after the parent to get the not set elements"
	element isEmpty
		ifTrue: [ self model add: module ]
]

{ #category : #creating }
MavenModuleImporter >> createModuleStubWithXMLDescription: moduleXMLDescription [
	| stub |
	stub := MavenModule new
		isStub: true;
		groupID: moduleXMLDescription moduleGroupId;
		artifactID: moduleXMLDescription moduleArtifactId;
		version: (self ensureIsNotMandatory: [ moduleXMLDescription moduleVersion ]);
		yourself.
	model add: stub.
	^ stub
]

{ #category : #accessing }
MavenModuleImporter >> defaultValue [
	"The default value is the value is not found in the XML file"
	^ nil
]

{ #category : #exceptions }
MavenModuleImporter >> ensureIsNotMandatory: aBlock [
	^ [ aBlock value ]
		on: MavenNotFound
		do: [ self defaultValue ]
]

{ #category : #searching }
MavenModuleImporter >> findElementNamed: anElementName in: anXMLDocument [
	^ (anXMLDocument firstElement elementAt: anElementName ifAbsent: [ MavenNotFound signalFor: anElementName ]) nodes 
]

{ #category : #accessing }
MavenModuleImporter >> getElementWithXMLDescriptionNodes: xmlModuleDescrption [
	^ model
		findMavenModulesWithGroupId: (self getGroupIDFrom: xmlModuleDescrption)
		withArtifactId: xmlModuleDescrption moduleArtifactId
		withVersion: (self ensureIsNotMandatory: [xmlModuleDescrption moduleVersion ])
]

{ #category : #accessing }
MavenModuleImporter >> getGroupIDFrom: anXMLModuleDescription [
	^ [ anXMLModuleDescription moduleGroupId ]
		on: MavenNotFound
		do: [ (anXMLModuleDescription elementAt: #parent) moduleGroupId ]
]

{ #category : #accessing }
MavenModuleImporter >> getVersionFrom: anXMLDocument with: module [
	^ [ anXMLDocument firstElement moduleVersion ]
		on: MavenNotFound
		do: [ (self findElementNamed: #parent in: anXMLDocument) moduleGroupId ]
]

{ #category : #testing }
MavenModuleImporter >> isExistingDependencyFrom: module to: foundModule [
	^ (module outgoingDependencies select: [ :refs | refs to = foundModule ]) isNotEmpty
]
