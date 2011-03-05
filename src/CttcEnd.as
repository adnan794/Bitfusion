package siemensdm 
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class CttcEnd extends Sprite
	{

		static private  var __instance:CttcEnd;
		private var _loader:Loader;
		private var _mc:MovieClip;
        private var _loaded:Boolean = false;
		private var _endTimer:Timer;
		private var _endTimerOn:Boolean;
		
		
		public function CttcEnd(singletonEnforcer:SingletonEnforcer)
		{
			_endTimer = new Timer(5000);
		}
		public static function getInstance():CttcEnd
		{
			if (CttcEnd.__instance == null)
			{
				CttcEnd.__instance = new CttcEnd(new SingletonEnforcer  );
			}
			return CttcEnd.__instance;
		}
		
		public function loadSWF(swfURL:String)
		{
		    _loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, handleComplete);
			_loader.load(new URLRequest(swfURL));
			
		} // end constructor
		
		
		private function handleComplete(event:Event):void
		{
			_loaded = true;
		} // handleIntroComplete
		
		 public function playSWF():void
		 {
			_mc = new MovieClip();
			_mc = MovieClip(_loader.content);
			_mc.gotoAndPlay(2);
			
		 } // end playSWF
		 
		 public function swfLoaded():Boolean
		 {
			 return _loaded;
		 }
		 public function startEndTimer()
		 {
			 _endTimer.addEventListener(TimerEvent.TIMER, onEndTimer);
			 _endTimer.start();
			 _endTimerOn = true;
		 }
		 private function onEndTimer(event:TimerEvent)
		 {
			 stopEndTimer();
			 VideoPlayer.getInstance().stopStream();
			 ButtonManager.getInstance().enableButtons();
			 LinksContainer.getInstance().FadeOut();
			 playSWF();
			 Container.getInstance().addDisplayObject(_mc);
			 Global.getInstance().startEndTimer();
		 }
		 
		 public function clearEndTimer()
		 {
			 if(_endTimerOn)
			 stopEndTimer();
		 }
		 
		 public function stopEndTimer()
		 {
		  _endTimer.removeEventListener(TimerEvent.TIMER, onEndTimer);
		  _endTimer.stop();
		  _endTimerOn = false;
		
		 }
		
		
		
	}//end class
}// end package


class SingletonEnforcer
{
}