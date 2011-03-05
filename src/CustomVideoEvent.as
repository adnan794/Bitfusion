﻿package src{import flash.events.*;// A class representing the custom "toggle" eventpublic class CustomVideoEvent extends Event{// A constant for the "toggle" event typepublic static const VIDEO_FINISHED:String = "videofinished";// Indicates whether the switch is now on or offpublic var videoEvent:String;//public var videoEvent:int;// Constructorpublic function CustomVideoEvent (videoEvent:String, type:String, 							 bubbles:Boolean = false, 							 cancelable:Boolean = false){// Pass constructor parameters to the superclass constructorsuper(type, bubbles, cancelable);// Remember the toggle switch's state so it can be accessed within// ToggleEvent.TOGGLE listenersthis.videoEvent = videoEvent;}// Every custom event class must override clone( )public override function clone( ):Event {return new CustomVideoEvent(videoEvent, type, bubbles, cancelable);}// Every custom event class must override toString( ). Note that// "eventPhase" is an instance variable relating to the event flow.// See Chapter 21.public override function toString( ):String {return formatToString("CustomVideoEvent", "type", "bubbles","cancelable", "eventPhase", "videoEvent");}}}