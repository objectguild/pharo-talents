Class {
	#name : #TaAbstractTalentTest,
	#superclass : #TestCase,
	#instVars : [
		'taTestTalentUsingAMessageDefined',
		'taTestTalent',
		'taTestTalentWithTwoMethods',
		'taRecursiveMethodTalent',
		'taTalentWithASlot',
		'taTalentWithASlotInitialized',
		'taAnotherInitializedSlot',
		'createdClasses',
		'taTalentWithClassSide'
	],
	#category : #'Talents-Tests'
}

{ #category : #'as yet unclassified' }
TaAbstractTalentTest >> newTalent: aName [
	^ self newTalent:aName with:#().
]

{ #category : #'instance creation' }
TaAbstractTalentTest >> newTalent: aName with: slots [
	| class |
	class := Trait named: aName uses: { } slots: slots category: 'Talents-Tests-TestClasses'  env: self class environment. 
	createdClasses add:class.
	
	^class.
]

{ #category : #running }
TaAbstractTalentTest >> setUp [
	TalentInstaller reset.
	
	createdClasses := Set new.
	

	taTestTalent := self newTalent:#TaTestTalent.
	taTestTalent compile: '
	someMessage
	^ 42.'.
	
	taTestTalentUsingAMessageDefined := self newTalent:#TaTestTalentUsingAMessageDefined.
	taTestTalentUsingAMessageDefined compile: '
	anotherMessage
	^ self anInstanceVariable.'.
	
	taTestTalentWithTwoMethods := self newTalent: #TaTestTalentWithTwoMethods.
	taTestTalentWithTwoMethods compile: ' aM1 ^ 42'.
	taTestTalentWithTwoMethods compile: ' aM2 ^ 22'.
	
	taRecursiveMethodTalent := self newTalent: #TaRecursiveMethodTalent.
	taRecursiveMethodTalent compile: '
		someRecursive: x 
			^ x = 0 ifTrue:[ 0 ] ifFalse:[ x + (self someRecursive: x - 1) ]
	'.
	
	taTalentWithASlot := self newTalent: #TaTalentWithASlot with: {#anSlot => InstanceVariableSlot}.
	taTalentWithASlot compile: '
		anSlot
			^ anSlot.
	'.
		taTalentWithASlot compile: '
		anSlot: aValue
			anSlot:=aValue.
	'.
	
	taTalentWithASlotInitialized := self newTalent: #TaTalentWithASlotInitiliazed with: #(anSlot).
	taTalentWithASlotInitialized compile: '
		anSlot
			^ anSlot.
	'.
	taTalentWithASlotInitialized compile: '
		initializeTalent
			anSlot := 55.
	'.
	
	taAnotherInitializedSlot := self newTalent: #TaAnotherInitializedSlot with: #(anotherSlot).
	taAnotherInitializedSlot compile: '
		anotherSlot
			^ anotherSlot.
	'.
	taAnotherInitializedSlot compile: '
		initializeTalent
			anotherSlot := 93.
	'.

	taTalentWithClassSide := self newTalent: #TaTalentWithClassSide with: #().
	taTalentWithClassSide class compile: '
	aClassMessage 
		^ 42
	'.
]

{ #category : #running }
TaAbstractTalentTest >> tearDown [
	TalentInstaller reset.
	createdClasses do:#removeFromSystem.
	createdClasses := nil.
]
