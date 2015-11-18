Extension { #name : #FAMIXNamespace }

{ #category : #'*Maven-Core' }
FAMIXNamespace >> mavenModule [
	"The maven module should be the same for maven Module (that can be not true)"

	| modules |
	modules := self classes collectAsSet: #mavenModule.
	modules size > 1
		ifTrue: [ Error signal ].
	^ modules anyOne
]
