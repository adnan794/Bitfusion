﻿////////////////////////////////////////////////////////////////////////////////
//
//  Adnan Babar, Siemens Open Web video Player
//  
//  NOTICE: AMAZE PLC does not permits you to use, modify, and distribute this 
//          file
//
////////////////////////////////////////////////////////////////////////////////

package src
{
	//--------------------------------------------------------------------------

	import flash.display.Sprite;
	import flash.events.*;
	import flash.geom.Rectangle;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;


	//--------------------------------------------------------------------------

	/**
	*  ActionScript 3.0 VideoPlayer 
	        *  18 Feb 2008
	        *
	        *  This document class receives the url to the XML video file from 
	*  the html page that embeds the swf. It then loads and parses the
	*  XML file to initialize the video player.
	*
	        */

	//--------------------------------------------------------------------------

	public class VideoPlayer extends Sprite
	{

		private static  var __instance:VideoPlayer;

		private var _videoURL:String;
		private var _netConnection:NetConnection;
		private var _netStream:NetStream;
		private var _video:Video;
		private var objInfo:Object;
		private var _duration:Number;
		private var loaded:Number;
		private var _timer:Timer;
		private var _count:Number = 0;
		//private var _txt:loading;
		private var _netStreamConnected:Boolean = false;
		private var _videoduration:Number;
		private var _bolProgressScrub:Boolean = false;
		private var _currentVideo:String;
		private var _previousVideo:String;
		private var _infoObject:Object;
		public var _progressBarLength:Number = 340;
		private var _videoFinished:Boolean = false;
		private var _vidURL:String;
		private var _txt:TextField = new TextField;
        private var bolVolumeScrub:Boolean = false;
		private var _videoDisabled:Boolean = false;
		
		public function VideoPlayer(singletonEnforcer:SingletonEnforcer)
		{
			netConnection();
			_timer = new Timer(10);
			Transporter.getInstance().mcProgressScrubber.addEventListener(MouseEvent.MOUSE_DOWN, progressScrubberClicked);
			Transporter.getInstance()._muteButton.mcVolumeScrubber.addEventListener(MouseEvent.MOUSE_DOWN, volumeScrubberClicked);
			//Transporter.getInstance()._muteButton.mcVolumeScrubber.y -= (68  * 0.6 ) ;
			trace()
			//Transporter.getInstance()._muteButton.mcVolumeFill.height = 68 * 0.6;
			
			setVolume(0.6);
			
			//Transporter.getInstance()._muteButton.mcVolumeScrubber.y = 50;
			
		}
		private function volumeScrubberClicked(e:MouseEvent):void {
	// set volume scrub flag to true
	bolVolumeScrub = true;
	Transporter.getInstance().addEventListener(MouseEvent.MOUSE_UP, volumeScrubberUnClicked);
	
	stage.addEventListener(MouseEvent.MOUSE_UP, volumeScrubberUnClicked);
	
	// start drag
	Transporter.getInstance()._muteButton.mcVolumeScrubber.startDrag(true, new Rectangle(15.35, 74 , 0, -68)); // NOW TRUE
}

private function volumeScrubberUnClicked(e:MouseEvent):void {
	// set volume scrub flag to true
	bolVolumeScrub = false;
	Transporter.getInstance().removeEventListener(MouseEvent.MOUSE_UP, volumeScrubberUnClicked);
	
	stage.removeEventListener(MouseEvent.MOUSE_UP, volumeScrubberUnClicked);
	
	// start drag
	Transporter.getInstance()._muteButton.mcVolumeScrubber.stopDrag(); // NOW TRUE
}

		public static function getInstance():VideoPlayer
		{
			if (VideoPlayer.__instance == null)
			{
				VideoPlayer.__instance = new VideoPlayer(new SingletonEnforcer);
			}
			return VideoPlayer.__instance;
		}
		private function netStatusHandler(event:NetStatusEvent):void
		{
			trace(event.info.code);
			switch (event.info.code)
			{
				case "NetConnection.Connect.Success" :
					netStream();
					trace("Success");
					break;
				case "NetStream.Play.NetStreamNotFound" :
					trace("Unable to locate video: " + _videoURL);
					break;
				case "NetStream.Buffer.Full" :
					trace("the buffer is full and the _netStream will start playing: " );
					_txt.visible = false;
					_video.visible = true;
					Transporter.getInstance().showHide(true);
					Transporter.getInstance().mouseEnabled = true;
					Container.getInstance().showHide(false);
				
					break;
					case "NetStream.Buffer.Empty":
					//	Transporter.getInstance().showHide(false);
						Transporter.getInstance().mouseEnabled = false;
						Container.getInstance().showHide(true);
						
						trace("Buffer is empty");
					break;
					case "NetStream.Seek.InvalidTime" :
						trace("Invalid seek time");
						//Application(root.loaderInfo.content).showError();
						//_netStream.seek(_netStream.time);
						break;
					
			}
		}
		private function netConnection()
		{
			_netConnection = new NetConnection();
			_netConnection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			_netConnection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			_netConnection.connect(null);
		}

		private function netStream()
		{
			

			_netStream = new NetStream(_netConnection);
			_netStream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			_netStream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			_netStream.bufferTime = 20;
			//var custom_obj:Object = new Object();
			//custom_obj.onMetaData = onMetaDataHandler;
			//_netStream.onCuePoint;
			//custom_obj.onPlayStatus = playStatus;
			//_ns.client = custom_obj;
			_netStream.client = this;
			_netStreamConnected = true;
			video();
		}
		
		public function seekVideoTo(time:Number){
			if(_videoFinished){
				_videoFinished = false;
				_timer.start();
				trace("Entered Resume");
				_netStream.seek(time);
				Transporter.getInstance().handlePlayPause();	
			}
			else{
				_netStream.seek(time);	
			}
			
			
		}
		public function video()
		{
			_video = new Video();
			
			_video.attachNetStream(_netStream);
			_video.visible = false;

			var txtFormat:TextFormat = new TextFormat;
			txtFormat.size = 18;
			txtFormat.color = 0Xffffff;
			//_txt = new loading;
			
			_txt.x = 270;
			_txt.y = 120
			_txt.visible = false;
			addChild(_video);
			addChild(_txt);
		}
		public function videoDimensions(xValue:Number = 0, yValue:Number = 0,
		                                w:Number = 604, h:Number = 276)
		{
			_video.x = xValue;
			_video.y = yValue;
			_video.width = w;
			_video.height = h;
			_video.smoothing = true;
		}
		public function playVideo(videoURL:String):void
		{
			_vidURL = videoURL;
			_netStream.close();
			_video.visible = false;
			_txt.visible = true;
			Transporter.getInstance().showHide(false);
			
			//settrackingid(videoURL);
            
			if (_netStreamConnected)
			{
				_netStream.play(videoURL);
				_timer.addEventListener(TimerEvent.TIMER, updateDisplay);
				_timer.start();
				Transporter.getInstance().mcProgressScrubber.addEventListener(MouseEvent.MOUSE_DOWN, progressScrubberClicked);
	            _video.alpha = 1;
			}
			else
			{
				trace("NetStream not connected");
			}
		}
		private function securityErrorHandler(event:SecurityErrorEvent):void
		{
			trace("securityErrorHandler: " + event);
		}
		private function asyncErrorHandler(event:AsyncErrorEvent):void
		{
			// ignore AsyncErrorEvent events.
		}
		
	    public function onMetaData(infoObject:Object)
		{
			_videoduration = infoObject.duration;
			_infoObject = infoObject;
			trace("The duration of the video is given as: " + _videoduration);
			
		}
		
		public function onCuePoint(infoObject:Object)
		{
			//CuePointsHandler.onCuePoints(infoObject);
			trace(infoObject.name);
			trace(infoObject.time);
			
		}
		
		public function displayTotalTime(duration:Number) {
		Transporter.getInstance().lblTotalTimeDuration.text = formatTime(duration);	
		}
		
		public function pauseNetStream()
		{
			_netStream.pause();
			Container.getInstance().showHide(true);
		}
		public function resumeNetStream()
		{
			
			
			if(_videoFinished)
			{
				_videoFinished = false;
				//_bolProgressScrub = true;
				 _timer.start();
				//_netStream.seek(1);
				trace("Entered Resume")

			}

			    _videoDisabled = false;
				enableVideo();
			    Container.getInstance().showHide(false);	

				
			
		}
		
		public function stopStream():void
		{
		_netStream.close();
		_video.visible = false;
		_txt.visible = false;
		}
		
		
		public function setVolume(intVolume:Number = 0):void
		{
			// create soundtransform object with the volume from
			// the parameter
			if (intVolume < 0 )
			intVolume = 0;
			var sndTransform:SoundTransform= new SoundTransform(intVolume);
			// assign object to netstream sound transform object
			_netStream.soundTransform = sndTransform;
			// hides/shows mute and unmute button according to the
			// volume

		}
		
		public function forward() {
			//trace("net stream time is given as:" + _netStream.time)
			//trace("net stream Seek time is given as:" + (_netStream.time + 0.005))
		//	_netStream.seek(_netStream.time + 0.0005);
		_netStream.seek(_netStream.time + 0.5);
		}
		public function rewind() {
			_netStream.seek(_netStream.time - 3);
		}
 public function updateDisplay(e:TimerEvent):void {
	
	 
			if(_bolProgressScrub)
			_netStream.seek(Math.round((Transporter.getInstance().mcProgressScrubber.x - 142) * _videoduration/ _progressBarLength))
			else
			Transporter.getInstance().mcProgressScrubber.x = (_netStream.time * _progressBarLength / _videoduration) + 142;
            
      
			//Transporter.getInstance().mcProgressScrubber.x = (_netStream.time * 540 / _videoduration) + 22; 

			Transporter.getInstance().mcProgressFill.width= _netStream.time * _progressBarLength  / _videoduration;
			
			Transporter.getInstance().mcLoadFill.width = _netStream.bytesLoaded * _progressBarLength / _netStream.bytesTotal;
			
			if(bolVolumeScrub) {
	setVolume(((74 - Transporter.getInstance()._muteButton.mcVolumeScrubber.y ) / 74));
		//trace("The Volume is given as:  " +  ((74 - Transporter.getInstance()._muteButton.mcVolumeScrubber.y ) / 74));
		//trace("The Y Positon is given as: " + Transporter.getInstance()._muteButton.mcVolumeScrubber.y);
		
		Transporter.getInstance()._muteButton.mcVolumeFill.height =  74 - Transporter.getInstance()._muteButton.mcVolumeScrubber.y;
	}
			
			
			if(_netStream.time >=_videoduration - 0.05)
					{
					trace("The movie has finished paying: ");
					
					_bolProgressScrub = false;
					_videoFinished = true;
					//_timer.stop();
					//pauseNetStream();
					_netStream.seek(0);
					//seekVideoTo(0);
					//pauseNetStream();
					//_netStream.seek(0);
					//stopNetStream();
					pauseNetStream();
					Transporter.getInstance().playButtonState();
					Container.getInstance().showHide(true);
					Transporter.getInstance().mcProgressScrubber.x = (_netStream.time * _progressBarLength / _videoduration) + 142;
					
					_video.visible = true;
					Transporter.getInstance().showHide(true);
					Transporter.getInstance().mouseEnabled = true;
					
				
					
					}
					
					Transporter.getInstance().leftContainer.lblTimePassed.text = formatTime(_netStream.time);
			
					
		         e.updateAfterEvent();			

}

private function progressScrubberClicked(e:MouseEvent):void {
	// set progress scrub flag to true
	_bolProgressScrub = true;
	
	
	Transporter.getInstance().addEventListener(MouseEvent.MOUSE_UP, progressScrubberUnClicked);
	
	stage.addEventListener(MouseEvent.MOUSE_UP, progressScrubberUnClicked);

	// start drag
	Transporter.getInstance().mcProgressScrubber.startDrag(false, new Rectangle(148, 110.10, Transporter.getInstance().mcLoadFill.width - 10, 0));
	trace("progress scrubber clicked");
}

private function progressScrubberUnClicked(e:MouseEvent):void {
	// set progress scrub flag to true
	_bolProgressScrub = false;
    
	 
    Transporter.getInstance().removeEventListener(MouseEvent.MOUSE_UP, progressScrubberUnClicked);
	
	stage.removeEventListener(MouseEvent.MOUSE_UP, progressScrubberUnClicked);
	// start drag
	Transporter.getInstance().mcProgressScrubber.stopDrag();
	
	trace("progress scrubber UNclicked");
}

public function disableVideo()
{
	_netStream.pause();
	_timer.removeEventListener(TimerEvent.TIMER, updateDisplay);
	_timer.stop();
	//Transporter.getInstance().removeEventListener();
	Transporter.getInstance().mcProgressScrubber.removeEventListener(MouseEvent.MOUSE_DOWN, progressScrubberClicked);
	if (_videoDisabled)
	_video.alpha = 0;
	else
	_video.alpha = 0.3;
}

public function enableVideo()
{
	_netStream.resume();
	_timer.addEventListener(TimerEvent.TIMER, updateDisplay);
	_timer.start();
	//Transporter.getInstance().removeEventListener();
	Transporter.getInstance().mcProgressScrubber.addEventListener(MouseEvent.MOUSE_DOWN, progressScrubberClicked);
	_video.alpha = 1;
}
public function videoDisabled(val:Boolean) {
	_videoDisabled = val;
}	


public function resizeProgressBar(num:Number) {
	_progressBarLength = num;
	
	Transporter.getInstance().progressBg.width = num;
	
	}



public function stopNetStream():void
		{
		_netStream.pause();
		_netStream.seek(0);
		
		_netStream.close();
		trace("NET STREAM IS CLOSED")
		
		}
private function formatTime(t:int):String {
	// returns the minutes and seconds with leading zeros
	// for example: 70 returns 01:10
	var s:int = Math.round(t);
	var m:int = 0;
	if (s > 0) {
		while (s > 59) {
			m++; s -= 60;
		}
		return String((m < 10 ? "0" : "") + m + ":" + (s < 10 ? "0" : "") + s);
	} else {
		return "00:00";
	}
}

	} // end class
} // end package


class SingletonEnforcer
{
}