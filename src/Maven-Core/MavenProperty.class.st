"
A MavenProperty is a kind of global variable linked to the maven module.

Instance Variables
	value:		a String

value
	- the value of the variable

"
Class {
	#name : #MavenProperty,
	#superclass : #FAMIXAttribute,
	#instVars : [
		'value'
	],
	#category : #'Maven-Core'
}

{ #category : #'as yet unclassified' }
MavenProperty class >> annotation [
	<MSEClass: #MavenProperty super: #FAMIXAttribute>
	<package: #Maven>
	^ self
]

{ #category : #'initialize-release' }
MavenProperty >> initialize [
	super initialize.
	value := nil
]

{ #category : #accessing }
MavenProperty >> value [
	<MSEProperty: #value type: #String>
	<MSEComment: 'The value of the global maven property.'>
	^ value
]

{ #category : #accessing }
MavenProperty >> value: aString [
	value := aString
	
]
