"
An AbstractMaven is an Abstract class that can be used by any class that want to interract with a MooseModel. Especially to extend an existing moose model.

To run the operator:
<Operator> runOn: <aMooseModel>

For avoiding errors, the class method neededSources is an array saying what are the loaded model extensions  needed by the operator. If the sources aren't loaded, the operator is skiped.

Once a source is added in the model,  you should execute addImportedSource: <sourceName>.

Instance Variables
	model:		a MooseModel

model
	- The moose model where the operator should be applied

"
Class {
	#name : #MAMAbstractModelOperator,
	#superclass : #MooseOperator,
	#category : #'MavenForMoose-Common-Core'
}

{ #category : #checking }
MAMAbstractModelOperator class >> canRunWithSourcesLoaded: collectionOfSources [
	"sources in= 'Java','Maven','Svn'"
	^ collectionOfSources includesAll: self neededSources.

	
]

{ #category : #accessing }
MAMAbstractModelOperator class >> neededSources [
	^ self subclassResponsibility
]

{ #category : #running }
MAMAbstractModelOperator class >> runOn: aMooseModel [
	self new model: aMooseModel; run
]
