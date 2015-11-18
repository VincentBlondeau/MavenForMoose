"
A PAIAAbstractFileImporterInModel is an abstract importer where the data that expend the moose model is contained in a file.

You have to run:
runOnDirectory: <aString representing a directory> with: <aMooseModel>
"
Class {
	#name : #MAMAbstractFileImporterInModel,
	#superclass : #MAMAbstractModelOperator,
	#instVars : [
		'rootFolder'
	],
	#category : #'MavenForMoose-Common-Core'
}

{ #category : #running }
MAMAbstractFileImporterInModel class >> runOn: aMooseModel [
	^ self shouldNotImplement 
]

{ #category : #running }
MAMAbstractFileImporterInModel class >> runOnDirectory: aFolder with: aMooseModel [
	^ self new
		rootFolder: aFolder;
		model: aMooseModel;
		run
]

{ #category : #running }
MAMAbstractFileImporterInModel class >> runWithProgressOnDirectory: aFolder with: aMooseModel [
	^ self new
		rootFolder: aFolder;
		model: aMooseModel;
		runWithProgress
]

{ #category : #accessing }
MAMAbstractFileImporterInModel >> rootFolder [
	^ rootFolder
]

{ #category : #accessing }
MAMAbstractFileImporterInModel >> rootFolder: aString [
	rootFolder := aString
]
