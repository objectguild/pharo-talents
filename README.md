# Talents for Pharo

Pharo-Talents is a library that provides a clean implementation of Talents for Pharo Smalltalk. 
It is based in a new implementation of the ClassBuilder and Traits that allows the creation of really independent classes in the system.

Allowing adding and removing behavior to objects, without modifying the classes.

## Install Talents

Talents is developed using the new Traits implementation, this implementation is still to be integrated in the image. 
To get an image compatible you can execute
```bash
wget "https://ci.inria.fr/pharo-ci-jenkins2/job/Test%20pending%20pull%20request%20and%20branch%20Pipeline/view/change-requests/job/PR-871/lastSuccessfulBuild/artifact/bootstrap-cache/*zip*/bootstrap-cache.zip"
unzip -jo bootstrap-cache.zip "bootstrap-cache/Pharo7.0-32bit-*.zip"
unzip Pharo7.0-32bit-*.zip
````

Once you have an image you can execute the following script to install the project.

```
Metacello new
  baseline: 'Talents';
  repository: 'github://tesonep/pharo-talents/src';
  load.
```

## Usage

### What is a Talent?

A talent is only a trait definition. This library uses regular traits as talents. This is in order of reuse the existing 
infrastructure of Pharo. 

When you add a talent to an object all the behavior and slots of the trait used as a talent are flatenized in the object. 

Any trait composition can be used to as a talent, allowing more complex talented objects.

### Adding a Talent

The library provides two ways of adding a talent to an object, the first one returns a copy of the object with the new 
"enhanced" behavior and the second one modifies the receiver of the message.

For creating a copy you should use:

```
newObject := anObject copyWithTalent:aTalent
```

For talenting an existing object:

```
anObject addTalent: aTalent
```

As any Trait composition can be used as a Talent, we can use the operations in traits. 
For example, we can alias one of the selector in the talent.

```
anObject addTalent: (aTalent @ {#originalSelector -> #aliasSelector}) 
```

### Removing a Talent

Removing a talent is also straight forward.

```
anObject removeTalent: aTalent.
```

If an object has more than one talent only the passed talent is removed from the object.

### Composition Operations

As said before any trait composition operation can be used as talents.

When two talents are added to an object they are sequenced in a trait composition:

```
anObject addTalent: aTalent
anObject addTalent: otherTalent
```

is equivalent to:

```
anObject addTalent: aTalent + otherTalent.
```

Other more complex operations can be performed using the trait algebra. For more details check the class TaAbstractComposition.
