operations
extendClass: aClass with:aTalent
	| builder newClass |
	builder := ShiftClassBuilder new
		buildEnvironment: ShSmalltalkGlobalsEnvironment new;
		yourself.

	builder 
		name: (aClass name , '_' , aTalent name);
		slots: aTalent slots;
		superclass: aClass.	  
	
	newClass := builder build.

	aTalent selectors do: [:sel | newClass recompile: sel from: aTalent].	

	talentedClasses at: newClass put: aTalent.

	^ newClass