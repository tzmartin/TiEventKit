/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "TiEventkitModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import <EventKit/EventKit.h>

@implementation TiEventkitModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"2e959bc4-eec9-4cda-a0ab-06b571c308c7";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"ti.eventkit";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];
	
	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably
	
	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup 

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"my_event"])
	{
		// the first (of potentially many) listener is being added 
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"my_event"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}

#pragma Public APIs

-(BOOL)newEvent:(id)args {
    //*** Pull the arguments out of the object passed in by Titanium
    id startDate = [args objectAtIndex:0];
    id endDate = [args objectAtIndex:1];
    id title = [args objectAtIndex:2];
    id location = [args objectAtIndex:3];
    id notes = [args objectAtIndex:4];
    
    //*** See what's coming in.  Comment this out for final build
    NSLog(@"[OBJ-C] arg1 is: %@", [args objectAtIndex:0]);
    NSLog(@"[OBJ-C] arg2 is: %@", [args objectAtIndex:1]);
    NSLog(@"[OBJ-C] arg3 is: %@", [args objectAtIndex:2]);
    NSLog(@"[OBJ-C] arg4 is: %@", [args objectAtIndex:3]);
    NSLog(@"[OBJ-C] arg5 is: %@", [args objectAtIndex:4]);
    
    //*** Instantiate EventKit objects
    EKEventStore *eventDB = [[EKEventStore alloc] init];
    EKEvent *theEvent  = [EKEvent eventWithEventStore:eventDB];
    
    //*** Create date formater and timezone object
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZoneGMT = [NSTimeZone timeZoneWithName:@"GMT"]; 
    
    [dateFormatter setTimeZone: timeZoneGMT];   
    [dateFormatter setDateFormat: @"yyyy-MM-dd hh:mm:ss Z"];
    
    //*** Provide POSIX date formatting to prevent date from drifting into a format that iCal won't accept
    NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setLocale:enUSPOSIXLocale];
    [enUSPOSIXLocale release];
    
    //*** Read data into the event
    theEvent.startDate = [dateFormatter dateFromString: startDate];
    theEvent.endDate   = [dateFormatter dateFromString: endDate];
    theEvent.title     = title;
    theEvent.location  = location;
    theEvent.notes     = notes;
    theEvent.allDay = NO;
    
    //*** Set the calendar
    [theEvent setCalendar:[eventDB defaultCalendarForNewEvents]];
    
    //*** Provide error trapping
    NSError *err;
    //*** Do save
    [eventDB saveEvent:theEvent span:EKSpanThisEvent error:&err];
    
    [dateFormatter release];    
    
    //*** Return.  YES returns as 1, NO as 0
    if (err == noErr) {
        return YES;
    } else {
        return NO;
    }
    
}

@end
