package src
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display.StageDisplayState;
	import flash.events.FullScreenEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.text.TextField;
	import flash.utils.Timer;
	import flash.system.*;
	
	
	public class Application extends Sprite
	{
		private var _flvURL;String;
		private var _errorShowing:Boolean = false;
		private var _firstTimeError:Boolean = true;
		private var _timer:Timer;
		private var _fullScreen:Boolean = false;
		private var videoControls:MovieClip;
		//private var _fullScreen:Boolean = f;
		//private var _errorClip:ErrorClip;
		public function Application()
		{
			trace("Created");
			
			//ExternalInterface.addCallback("playCuePoint", playCuePoint);
			
			init();
			//playCuePoint();
		}
		private function init()
		{
			if(root.loaderInfo.parameters["flvURL"] != null)
				_flvURL = root.loaderInfo.parameters["flvURL"];
			else
				_flvURL = "assets/flv/test.flv";
				
			setupVideoPlayer();
			
			
			
			stage.scaleMode	= StageScaleMode.NO_SCALE;
            stage.align		= StageAlign.TOP_LEFT;
			stage.addEventListener(FullScreenEvent.FULL_SCREEN, onFullscreen);

			videoControls = Transporter.getInstance();
			videoControls.x = 5;
		    videoControls.y = 212;
			addChild(videoControls);
			
			Container.getInstance().x = 0;
			Container.getInstance().y = 316;
			addChild(Container.getInstance());
			
			/*var greyBar:GreyBar = new GreyBar;
			greyBar.x = 0;
			greyBar.y = 0;
			addChild(greyBar);
			*/
			
		}
		
		private function setupVideoPlayer(){
			VideoPlayer.getInstance().video();
			VideoPlayer.getInstance().videoDimensions(0,0,640,360);
			videoContainer.addChild(VideoPlayer.getInstance());
			//addChild(VideoContainer.getInstance());
			VideoPlayer.getInstance().playVideo(_flvURL);
			//videoControls.mcFeatures.mcFullScreen.addEventListener(MouseEvent.CLICK, onFullScreenClicked);
		}
		
		public function onFullScreenClicked() {
			trace("FULL SCREEN");
			if (this.stage.displayState == StageDisplayState.FULL_SCREEN)
			{
			
             this.stage.displayState = StageDisplayState.NORMAL;
			 
			}
			else {
				
             this.stage.displayState=StageDisplayState.FULL_SCREEN;
			}
		}
		
		public function onFullscreen(e:FullScreenEvent = null):void {
			

    if (e.fullScreen) {
		
		 _fullScreen = true;
       // videoControls.btnFullscreenOn.visible = false;
		//mcVideoControls.btnFullscreenOff.visible = true;

		videoControls.x = (Capabilities.screenResolutionX - 640) / 2;
		videoControls.y = (Capabilities.screenResolutionY - 142);
		
		

		//VideoPlayer.height = (Capabilities.screenResolutionY - 33);
		var height:Number = Capabilities.screenResolutionY - 33;
		var width:Number = height * 4 / 3;
		//VideoPlayer.getInstance().videoDimensions(Capabilities.screenResolutionX - width, 0, width, height);
		VideoPlayer.getInstance().videoDimensions(0, 0, stage.fullScreenWidth, stage.fullScreenHeight);
		//videoControls.mcFeatures.gotoAndStop(1);
		//videoControls.mcFeatures.checkPanel();
		videoControls.mcFeatures.closePanel();
		//stage.fullScreenSourceRect = videoplayer.

		//vidDisplay.width = vidDisplay.height * 4 / 3;
		
		//vidDisplay.x	= (Capabilities.screenResolutionX - vidDisplay.width) / 2;
		
    } else {
      /*  mcVideoControls.btnFullscreenOn.visible = true;
		mcVideoControls.btnFullscreenOff.visible = false;*/
		 _fullScreen = false;
		videoControls.x = 5;
		videoControls.y = 212;
		videoControls.mcFeatures.closePanel();
		VideoPlayer.getInstance().videoDimensions(0, 0, 640, 360);
		
		if (this.contains(this.getChildByName("email"))){
		this.getChildByName("email").x = 187.5;
			   this.getChildByName("email").y = 110;
		}
	

		
		
    }
}
		
		
		private function playCuePoint(val:String){
			var txt:TextField = new TextField;
			txt.wordWrap = true;
			txt.text = "This has been sent from flash " + val;
			//addChild(txt);
			Container.getInstance().jumpToCuePoint(val);
		}
		
		public function showError(){
			if(_firstTimeError){
				/*_firstTimeError = false;
				_timer = new Timer(3000);
				_errorClip = new ErrorClip;
				_errorClip.x = 184.80;
				_errorClip.y = 139.20;
				*/
			}
			
			if(_errorShowing){
				trace("Already showing error don;t do anything")
			}
			else{
				
				_errorShowing = true;
				_timer.addEventListener(TimerEvent.TIMER, onTimer);
			    _timer.start();
				//addChild(_errorClip);
			}
			
		}
		private function onTimer(e:TimerEvent){
			_errorShowing = false;
			_timer.removeEventListener(TimerEvent.TIMER, onTimer);
			_timer.stop();
			//this.removeChild(_errorClip);
		}
		
		public function disableInterface() {
			trace("MAIN EMAIL");
			videoControls.mouseEnabled = false;
			videoControls.mouseChildren = false;
			VideoPlayer.getInstance().disableVideo();
			
			
		}
		
		public function enableInterface() {
			trace("MAIN EMAIL");
			videoControls.mouseEnabled = true;
			videoControls.mouseChildren = true;
			VideoPlayer.getInstance().enableVideo();
			this.removeChild(this.getChildByName("email"));
			
		}
		
		public function addEmailToStage() {
			if (_fullScreen)
			{
				this.getChildByName("email").x = (Capabilities.screenResolutionX - 265) / 2;
			   this.getChildByName("email").y = (Capabilities.screenResolutionY - 140) / 2;
		
				
			}
			else {
				this.getChildByName("email").x = 187.5;
				this.getChildByName("email").y = 110;
			}
			
		}
		
		
	}
}