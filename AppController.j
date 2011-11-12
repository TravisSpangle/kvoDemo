/*
 * AppController.j
 * kvoDemo
 * 
 *  This demo is to provide a basic understanding of Key-Value Observations.
 *  Open in Index-debug.html to view the log messages
 *
 * Created by Travis Spangle on November 11, 2011.
 * Copyright 2011, Your Company All rights reserved.
 */

@import <Foundation/CPObject.j>


@implementation AppController : CPObject
{
    CPWindow    theWindow; //this "outlet" is connected automatically by the Cib

	//fido will be the variable we use KVO on. As we modify the fido variable here
	//	we will see the changes reflected in the interface.
	CPNumber fido; 
}

/*Fido Get Accessor Method
	whenever fido is asked for it will call this method */
-(CPNumber)fido
{
	CPLog("fido is returning "+fido);
	return fido;
}

/*Fido Set Accessor Method
	whenever fido is set, it will be done through this method */
-(void)setFido:(CPNumber)newFido
{
	CPLog("set fido is called with "+newFido);
	self.fido = newFido;
}


- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    // This is called when the application is done loading.

	/*Here we use KVO -setValue:forKey:
	- 'self' is the object with the fido attribute.
		If instead we had another object, like PetOwner, we would call this metho on PetOwner and not self.
	- The KVO methods work with objects. So we pass our value through the CPNumber object. In Cappuccino 
		you can get away with just passing 50, but I like to develop habbits that will work in both
		Cocoa and Cappuccion
	- forKey specifies the objects attributes. Fido is the variable we want to set. 
	*/	
	[self setValue:[CPNumber numberWithInt:50] forKey:@"fido"];
		
	/*Another demonstration for KVO. This time we don't want to set a value. We just want to retrive it.
	Same rules apply, we want the value of fido, which will be our Key. Then we need to call the KVO method
	of the object fido belongs to.*/
	n = [self valueForKey:@"fido"];

	CPLog("The value of Fido during initial launch: "+n);
}

/*BINDING
 When you bind objects you are declaring one object as a listener and another as the broadcaster. 
 In the xib file, review the Bindings Inspector and see how the IB elemetns are connected to our pal Fido.
 */

- (void)awakeFromCib
{
    [theWindow setFullPlatformWindow:YES];
}

-(IBAction)increaseFidoWithOutKVO:(id)sender
{
	//This method will modify the value of fido without any KVO methods.
	//Notice what happes to our variable fido.
	//Notice if these changes are acknowledged to the interface.
	
	fido++;
	CPLog("Fido is increment to "+fido+" without KVO methods. Does the UI Reflect these changes?");
	

}

-(IBAction)increaseFidoWithKVO:(id)sender
{
	//Fido is still modified without KVO. But we can use the willChange and didChange KVO methods  
	// to notify observers that the value has changed.
	
	[self willChangeValueForKey:@"fido"];
	fido++;
	console.log("Fido is now "+fido);
	[self didChangeValueForKey:@"fido"];
	CPLog("Fido is increment to "+fido+" without KVO methods but with will & did notifications. Does the UI Reflect these changes?");
}

/*
If you found this example useful then you will love the books by Big Nerd Ranch - Cocoa Programming For Mac OS X
*/

@end
