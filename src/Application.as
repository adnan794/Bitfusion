package src
{
	import flash.display.Loader;
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
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.utils.Timer;
	import flash.events.Event;
	import flash.system.*;
	
	
	public class Application extends Sprite
	{
		private var _flvURL;String;
		private var _errorShowing:Boolean = false;
		private var _firstTimeError:Boolean = true;
		private var _timer:Timer;
		private var _fullScreen:Boolean = false;
		private var videoControls:MovieClip;
		private var _imageURL:String;
		//private var _fullScreen:Boolean = f;
		//private var _errorClip:ErrorClip;
		public function Application()
		{
			trace("Created");
			
			
			
			init();
			//playCuePoint();
		}
		private function init()
		{
			if(root.loaderInfo.parameters["flvURL"] != null)
				_flvURL = root.loaderInfo.parameters["flvURL"];
			else
				_flvURL = "assets/flv/test.flv";
				
			if(root.loaderInfo.parameters["imageURL"] != null)
				_imageURL = root.loaderInfo.parameters["imageURL"];
			else
				_imageURL = "assets/images/test.jpg";
				
			
				setupImage();
				
			
			
			stage.scaleMode	= StageScaleMode.NO_SCALE;
            stage.align		= StageAlign.TOP_LEFT;
			stage.addEventListener(FullScreenEvent.FULL_SCREEN, onFullscreen);
            Container.getInstance().x = 0;
			Container.getInstance().y = 0;
			
			
			
			addChild(Container.getInstance());
			videoControls = Transporter.getInstance();
			videoControls.x = 5;
		    videoControls.y = 212;
			addChild(videoControls);
			
			
			
			
			
		}
		private function setupImage()
		{
			var loader:Loader = new Loader;
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, displayImage);
			
			loader.load(new URLRequest(_imageURL));
			
            }
			
			private function displayImage(e:Event) {
				trace(e.target);
				Container.getInstance().addChild(e.target.content);
				setupVideoPlayer();
				Container.getInstance().showHide(true);
				
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
    
		videoControls.x = (Capabilities.screenResolutionX - 640) / 2;
		videoControls.y = (Capabilities.screenResolutionY - 142);
		VideoPlayer.getInstance().videoDimensions(0, 0, stage.fullScreenWidth, stage.fullScreenHeight);

		videoControls.mcFeatures.closePanel();
		checkImage();
       // Container.getInstance().resize(0,0, stage.fullScreenWidth, stage.fullScreenHeight )
		
    } else {
		
        
     	 _fullScreen = false;
		videoControls.x = 5;
		videoControls.y = 212;
		checkImage();
		videoControls.mcFeatures.closePanel();
		VideoPlayer.getInstance().videoDimensions(0, 0, 640, 360);
	//	Container.getInstance().visible = false;
		if (this.contains(this.getChildByName("email"))){
		this.getChildByName("email").x = 187.5;
			   this.getChildByName("email").y = 110;
		}	
		//Container.getInstance().resize(0, 0, 640, 340 );
		
		
				
		//if (Container.getInstance().isShowing()) {
			
			
		//}

    }
}
		
		
		private function playCuePoint(val:String){
			var txt:TextField = new TextField;
			txt.wordWrap = true;
			txt.text = "This has been sent from flash " + val;
			//addChild(txt);
			//Container.getInstance().jumpToCuePoint(val);
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
			videoControls.mcFeatures.closePanel();
			videoControls.mouseEnabled = false;
			videoControls.mouseChildren = false;
			VideoPlayer.getInstance().disableVideo();
			if (Container.getInstance().isShowing())
			Container.getInstance().alpha = 0.4;
			
			
		}
		
		public function enableInterface() {
			trace("MAIN EMAIL");
			
				Container.getInstance().alpha = 1;
			    Container.getInstance().showHide(false);
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
		
		public function checkImage():void 
		{
			
			if (_fullScreen)
			Container.getInstance().resize(0,0,stage.fullScreenWidth, stage.fullScreenHeight);
			else 
			Container.getInstance().resize(0,0,640, 340);
			
		}
		
		
	}
}