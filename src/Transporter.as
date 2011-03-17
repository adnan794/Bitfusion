package src
{
	import flash.display.*;
	import flash.events.*;
	//import caurina.transitions.*;



	public class Transporter extends MovieClip
	{

		static private  var _instance:Transporter;
		private var _mute:Boolean = false;
		private var _play:Boolean = true;
		private var _firstTime:Boolean = true;



		public function Transporter(singletonEnforcer:SingletonEnforcer)
		{
			_muteButton.volumeButton.addEventListener(MouseEvent.CLICK, handleMuteClick);
			_muteButton.volumeButton.addEventListener(MouseEvent.MOUSE_OVER, onMuteOver);
		//	_muteButton.volumeButton.addEventListener(MouseEvent.MOUSE_OUT, onMuteOut);
			
			_playButton.addEventListener(MouseEvent.CLICK, handlePlayPause);
			rewind.addEventListener(MouseEvent.CLICK, onRewindClick);
			forward.addEventListener(MouseEvent.CLICK, onForwardClick);
			_muteButton.buttonMode = true;
			_playButton.buttonMode = true;
		    mcProgressScrubber.buttonMode = true;
			_muteButton.gotoAndStop(1);
			_playButton.gotoAndStop(1);
			}
			
			private function onMuteOver(e:MouseEvent) {
				_muteButton.gotoAndPlay(2);
			}
			
		
		
		private function onRewindClick(e:MouseEvent) {
		trace("rewind Click");	
		VideoPlayer.getInstance().rewind();
		}
		
		
		private function onForwardClick(e:MouseEvent) {
		trace("Forward Click");	
		VideoPlayer.getInstance().forward();
		}
		public static function getInstance():Transporter
		{
			if (Transporter._instance == null)
			{
				Transporter._instance = new Transporter(new SingletonEnforcer);
							}
			return Transporter._instance;
		}
		public function handleMuteClick(event:MouseEvent):void
		{
			if (!_mute)
			{
				_mute = true;
				VideoPlayer.getInstance().setVolume(0);
				//_muteButton.gotoAndStop(2);
			}
			else
			{
				_mute = false;
				//_muteButton.gotoAndStop(1);
				VideoPlayer.getInstance().setVolume(1);
			}//
			//_sound.muteSound();*/
		}
		public function handlePlayPause(event:MouseEvent = null):void
		{
			if (_firstTime)
			{
				
			_firstTime = false;
			_play = true;
			_playButton.gotoAndStop(1);
			Application(this.root.loaderInfo.content).playVideo();
			}
			else
			{
			if (_play)
			{
				_play = false;
				_playButton.gotoAndStop(2);
				VideoPlayer.getInstance().pauseNetStream();
			}
			else
			{
				_play = true;
				_playButton.gotoAndStop(1);
				VideoPlayer.getInstance().resumeNetStream();
			}
			}
			//_sound.muteSound();
		
		}
		public function updateProgressBar(playHead:Number, fill:Number)
		{
			//mcProgressScrubber.x = playHead;
			//mcProgressFill.mcFillBlue.width = fill;
		}
		public function showHide(value:Boolean)
		{
			_playButton.visible = value;
			_muteButton.visible = value;
			mcProgressScrubber.visible = value;
			//mcProgressFill.visible = value;
			//mcLoadFill.visible = value;
		}
		public function playButtonState(){
			_play = false;
			_playButton.gotoAndStop(2);
			

		}
	}
}
class SingletonEnforcer
{
}