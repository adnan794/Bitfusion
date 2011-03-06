////////////////////////////////////////////////////////////////////////////////
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
		private var _progressBarLength:Number = 342;
		private var _videoFinished:Boolean = false;
		private var _vidURL:String;
		private var _txt:TextField = new TextField;

		public function VideoPlayer(singletonEnforcer:SingletonEnforcer)
		{
			netConnection();
			_timer = new Timer(100);
			Transporter.getInstance().mcProgressScrubber.addEventListener(MouseEvent.MOUSE_DOWN, progressScrubberClicked);
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
					Container.getInstance().visible = true;
				
					break;
					case "NetStream.Buffer.Empty":
						Transporter.getInstance().showHide(false);
						Container.getInstance().visible = false;
						trace("Buffer is empty");
					break;
					case "NetStream.Seek.InvalidTime" :
						trace("Invalid seek time");
						Application(root.loaderInfo.content).showError();
						_netStream.seek(_netStream.time);
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
			
			if(_currentVideo != null)
			{
				_previousVideo = _currentVideo;
			}
			
			//settrackingid(videoURL);

			if (_netStreamConnected)
			{
				_netStream.play(videoURL);
				_timer.addEventListener(TimerEvent.TIMER, updateDisplay);
				_timer.start();
				

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
			
			Container.getInstance().createCuePoints(_infoObject);
			
		}
		
		public function onCuePoint(infoObject:Object)
		{
			//CuePointsHandler.onCuePoints(infoObject);
			trace(infoObject.name);
			trace(infoObject.time);
			
		}
		
		
		public function pauseNetStream()
		{
			_netStream.pause();
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
			//	Transported.getInstance().
		    //  _netStream.play(_vidURL);
				
			}
				_netStream.resume();	
				
			
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
			var sndTransform:SoundTransform= new SoundTransform(intVolume);
			// assign object to netstream sound transform object
			_netStream.soundTransform= sndTransform;
			// hides/shows mute and unmute button according to the
			// volume

		}
 public function updateDisplay(e:TimerEvent):void {
	
			if(_bolProgressScrub)
			_netStream.seek(Math.round((Transporter.getInstance().mcProgressScrubber.x - 148) * _videoduration/ _progressBarLength))
			else
			Transporter.getInstance().mcProgressScrubber.x = (_netStream.time * _progressBarLength / _videoduration) + 148;
            
      
			//Transporter.getInstance().mcProgressScrubber.x = (_netStream.time * 540 / _videoduration) + 22; 

			Transporter.getInstance().mcProgressFill.width= _netStream.time * _progressBarLength / _videoduration;
			
			Transporter.getInstance().mcLoadFill.width= _netStream.bytesLoaded * _progressBarLength / _netStream.bytesTotal;
			if(_netStream.time >=_videoduration)
					{
					trace("The movie has finished paying: ");
					
					_bolProgressScrub = false;
					//_timer.stop();
					//pauseNetStream();
					_netStream.seek(0);
					//seekVideoTo(0);
					//pauseNetStream();
					//_netStream.seek(0);
					//stopNetStream();
					Transporter.getInstance().mcProgressScrubber.x = (_netStream.time * _progressBarLength / _videoduration) + 148;
					_videoFinished = true;
					Transporter.getInstance().handlePlayPause();
					
					}
			
					
					

}

private function progressScrubberClicked(e:MouseEvent):void {
	// set progress scrub flag to true
	_bolProgressScrub = true;
	
	
	Transporter.getInstance().addEventListener(MouseEvent.MOUSE_UP, progressScrubberUnClicked);
	
	stage.addEventListener(MouseEvent.MOUSE_UP, progressScrubberUnClicked);

	// start drag
	Transporter.getInstance().mcProgressScrubber.startDrag(false, new Rectangle(148, 112, Transporter.getInstance().mcLoadFill.width - 5, 0));
	trace("progress scrubber clicked");
}

private function progressScrubberUnClicked(e:MouseEvent):void {
	// set progress scrub flag to true
	_bolProgressScrub = false;
    
	 
    Transporter.getInstance().removeEventListener(MouseEvent.MOUSE_UP, progressScrubberUnClicked);
	
	stage.removeEventListener(MouseEvent.MOUSE_UP, progressScrubberUnClicked);
	// start drag
	Transporter.getInstance().mcProgressScrubber.stopDrag();
	//Transporter.getInstance().mcProgressFill.width	= Transporter.getInstance().mcProgressScrubber.x + 22;
	//Transporter.getInstance().mcProgressScrubber.x = Transporter.getInstance().mcProgressScrubber.x - 22;
	trace("progress scrubber UNclicked");
}



public function stopNetStream():void
		{
		_netStream.pause();
		_netStream.seek(0);
		
		_netStream.close();
		trace("NET STREAM IS CLOSED")
		
		}






	} // end class
} // end package


class SingletonEnforcer
{
}