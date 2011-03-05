package siemensdm
{
	import flash.display.*;
	import flash.text.*;
	import flash.events.*;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.geom.ColorTransform;

	public class LinkButton extends Sprite 
	{
		private var _parentTitle:String; // name of the movie which the buttons are embedded
		private var _linkURL:String;
		private var _openWindowType:String;// whether to open a new window or self
		
		public function LinkButton(label:String, linkURL:String, 
								   openWindowType:String, parentTitle:String) 
		{
			
			_label.text = label;
			_label.mouseEnabled = false;
			_linkURL = linkURL;
			_openWindowType = openWindowType;
			_parentTitle = parentTitle;
			
			
			buttonMode = true;
			mouseEnabled = true;
			
			addEventListener(MouseEvent.CLICK, onClick);
			//addEventListener(MouseEvent.MOUSE_OVER, onOver);
			//addEventListener(MouseEvent.MOUSE_OUT, onOut);

		}// end constructor

		
		public function onClick(event:MouseEvent)
		{
			navigateToURL(new URLRequest(_linkURL), _openWindowType);
			Global.getInstance().sendTracking(_label.text + "clicked/")
		}
		
		public function onOver(e:MouseEvent):void
		{
			trace("over");
		}//end onOver
		
		public function onOut(e:MouseEvent):void
		{
			//trace("OUT");
			//setBgColor(_outColor)
		}// end onOut
		
		
		
	}// end of launch class
}// end package