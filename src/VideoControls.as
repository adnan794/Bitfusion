package src
{
	import flash.display.*;
	import flash.events.*;
	//import caurina.transitions.*;



	public class VideoControls extends Sprite
	{

		static private  var _instance:VideoControls;
		private var _mute:Boolean = false;
		private var _play:Boolean = true;


		public function VideoControls(singletonEnforcer:SingletonEnforcer)
		{
			_muteButton.addEventListener(MouseEvent.CLICK, handleMuteClick);
			_playButton.addEventListener(MouseEvent.CLICK, handlePlayPause);
			_muteButton.buttonMode = true;
			_playButton.buttonMode = true;
		    mcProgressScrubber.buttonMode = true;
			_muteButton.gotoAndStop(1);
			_playButton.gotoAndStop(1);
		}
		public static function getInstance():VideoControls
		{
			if (VideoControls._instance == null)
			{
				VideoControls._instance=new VideoControls(new SingletonEnforcer);
			}
			return VideoControls._instance;
		}
		public function handleMuteClick(event:MouseEvent):void
		{
			if (!_mute)
			{
				_mute = true;
				VideoPlayer.getInstance().setVolume(0);
				_muteButton.gotoAndStop(2);
			}
			else
			{
				_mute = false;
				_muteButton.gotoAndStop(1);
				VideoPlayer.getInstance().setVolume(1);
			}//
			//_sound.muteSound();
		}
		public function handlePlayPause(event:MouseEvent = null):void
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
			//_sound.muteSound();
		}
		public function updateProgressBar(playHead:Number, fill:Number)
		{
			//mcProgressScrubber.x = playHead;
			mcProgressFill.mcFillBlue.width = fill;
		}
		public function showHide(value:Boolean)
		{
			_playButton.visible = value;
			_muteButton.visible = value;
			mcProgressScrubber.visible = value;
			mcProgressFill.visible = value;
			//mcLoadFill.visible = value;
		}
	}
}
class SingletonEnforcer
{
}