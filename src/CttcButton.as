package siemensdm
{
	import flash.display.*;
	import flash.text.*;
	import flash.events.*;
	import flash.geom.ColorTransform;

	public class CttcButton extends Sprite 
	{
		private var _id:int;
		private var _cttcURL:String;
		

		//private var 
		public function CttcButton(label:String, cttcURL:String) {

			
			
			_cttcURL = cttcURL;
		    
			createButton(label);
			buttonMode = true;
			mouseEnabled = true;
			
			addEventListener(MouseEvent.CLICK, onClick);
			addEventListener(MouseEvent.MOUSE_OVER, onOver);
			addEventListener(MouseEvent.MOUSE_OUT, onOut);

		}// end constructor

		
		public function onClick(event:MouseEvent)
		{
			VideoPlayer.getInstance().playVideo(_cttcURL);
			Container.getInstance().removeDisplayObject();
		}
		public function onOver(e:MouseEvent):void {
			trace("over");
			//setBgColor(_overColor);

		}// end onOver
		public function onOut(e:MouseEvent):void {
			//trace("OUT");
			//setBgColor(_outColor)
		}// end onOut
		
		private function createButton(label:String)
		{
			switch(label)
			{
				case "Streamline":
				var bg:StreamlineCttc = new StreamlineCttc;
				bg.alpha = 0;
				bg.x = 503.5;
				bg.y = 112;
				addChild(bg);
				break;
				case "Compete":
				var bg1:OutsmartCttc = new OutsmartCttc;
				bg1.alpha = 0;
				bg1.x = 524.5;
				bg1.y = 109.5;
				addChild(bg1);
				break;
				case "Prepare":
				var bg2:PrimedCttc = new PrimedCttc;
				bg2.alpha = 0;
				bg2.x = 498.5;
				bg2.y = 94;
				addChild(bg2);
				break;
				
			}
		}
	}// end of launch class
}// end package