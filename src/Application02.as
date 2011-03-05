////////////////////////////////////////////////////////////////////////////////
//
//  Adnan Babar, Siemens Open Web video Player
//  
//  NOTICE: AMAZE PLC does not permits you to use, modify, and distribute this 
//          file
//
////////////////////////////////////////////////////////////////////////////////

package openscape
{
	//--------------------------------------------------------------------------

	import flash.xml.*;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.events.MouseEvent;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.text.TextFieldAutoSize;

	//--------------------------------------------------------------------------

	/**
	        *  ActionScript 3.0 Application 
	        *  18 Feb 2008
	        *
	        *  This document class receives the url to the XML video file from 
	        *  the html page that embeds the swf. It then loads and parses the
	        *  XML file to initialize the video player.
	        *
	        */

	//--------------------------------------------------------------------------

	public class Application extends Sprite
	{
		private var _xmlURL:String;// the url for xml file on the server
		private var _holder:Sprite;// container for left hand navigation
		//private var _bigHolder:Sprite;// contianer for big images and movies
		//private var _bigMasker:BigMask;// Mask for big images and videos
		private var _loadXml:XmlLoader;// To load xml file
		//private var _bg:VideoBackground;// left background 
		//private var _mask:MaskButton;// mask for left navigation

		private var _startButtonHolder:Sprite;


		//--------------------------------------------------------------------------

		/**
		        *  Constructor
		*  constructor is used to initialize the main containers and backgrounds 
		        *  after doing that it adds them to the display list as children of the
		*  the current project detail object
		        */

		//--------------------------------------------------------------------------

		public function Application()
		{
			// Tell the player not to scale assets
			//stage.scaleMode = StageScaleMode.NO_SCALE;
			// Tell the player to put coords 0,0 to the top left corner
			//stage.align = StageAlign.TOP_LEFT;
			// Listen for resizing events
			//stage.addEventListener(Event.RESIZE, onResize);

			// intialize video background
			//initializeBackground();
			//intializeVideoContainer();
			// intialize Containers
			
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
            addChild(SWFContainer.getInstance());
			intializeVideoContainer();
			
			intializeContainers();
			//_mask = new MaskButton;
			
			
			

			//_mask.y = 233;
			//ButtonManager.getInstance().y = _mask.y;
			//ButtonManager.getInstance().mask = _mask;
			//addChild(_mask);
			addChild(ButtonManager.getInstance());
			//addChild(LinksContainer.getInstance());
			_startButtonHolder = new Sprite;
			//_startButtonHolder.x = 48;
			//_startButtonHolder.y = 113.5;
			//var bg:FirstFrame = new FirstFrame();
			//_startButtonHolder.addChild(bg);
			//addChild(_startButtonHolder);
			// intialize video and images container area
			initializeXML();
		}
		private function initializeXML()
		{

			if (root.loaderInfo.parameters["xmlURL"] != null)
			{
				_loadXml = new XmlLoader(root.loaderInfo.parameters["xmlURL"]);
				//_loadXml = new XmlLoader("assets/data/videoPlayer.xml");
				_loadXml.addEventListener(Event.COMPLETE, handleLoadedXML);
			}
			else
			{
				_loadXml = new XmlLoader("http://209.162.178.214/ow/global/UCApplication/assets/data/openscape.xml");
				_loadXml.addEventListener(Event.COMPLETE, handleLoadedXML);
			}
		}
		private function initializeBackground():void
		{

		}
		private function intializeContainers()
		{
			Container.getInstance().x = 44;
			Container.getInstance().y = 13.8;
			addChild(Container.getInstance());
		}
		private function intializeVideoContainer()
		{
            //Transporter.getInstance().x = 188.5;
			//trace(Transporter.getInstance().height);
			//Transporter.getInstance().y = 276 - Transporter.getInstance().height;
			//Transporter.getInstance().showHide(false);
			VideoPlayer.getInstance().video();
			VideoPlayer.getInstance().videoDimensions(0,0,604,276);
			
			VideoContainer.getInstance().addChild(VideoPlayer.getInstance());
			addChild(VideoContainer.getInstance());
			Transporter.getInstance().x =0;
			Transporter.getInstance().y = 261;
			addChild(Transporter.getInstance());
		}
		public function onResize(e:Event):void
		{

		}
		public function handleLoadedXML(event:Event):void
		{
			ButtonManager.getInstance().setButtonArray(_loadXml.xml);
			ButtonManager.getInstance().createButtons();
			ButtonManager.getInstance().positionButtonSprite(0,244);
			ButtonManager.getInstance().visible = visible;
			ButtonManager.getInstance().customButtonClick(0);
          
			//ButtonManager.getInstance().createLinks("primed");
			//LinksContainer.getInstance().addDisplayObject(ButtonManager.getInstance().primedLinksContainer, 0, 0)
		}//end onComplete

		private function handleStartButton(event:MouseEvent):void
		{

		}
		
				public function onRemoved(event:Event)
		{
			trace("Removed from Stage");
			VideoPlayer.getInstance().stopNetStream();
			
		}
	}// end class
}// end package