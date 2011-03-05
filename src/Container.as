package src 
{
	//import caurina.transitions.*;
	
	import flash.display.*;
	import flash.events.MouseEvent;
	
	public class Container extends Sprite
	{

		static private  var _instance:Container;
		private var _displayObject:DisplayObject;
		private var _oldObject:DisplayObject;
		private var _index:Number;
		private var _currentPlayingId:int;
		
		
		public function Container(singletonEnforcer:SingletonEnforcer)
		{
			
			this.addEventListener(MouseEvent.CLICK, onClickHandler);
         
		 //_content = new Content;
		 //addChild(_content);
		}
		
		private function onClickHandler(e:MouseEvent){
			trace("THis is the target" + e.target);
			trace("THis is the currentTarget" + e.currentTarget);
			
			trace("The Cue point name is " + e.target.cuePointName + " the time of this cue point is " + e.target.time);
			VideoPlayer.getInstance().seekVideoTo(e.target.time);
			
		}
		public static function getInstance():Container
		{
			if (Container._instance == null)
			{
				Container._instance=new Container(new SingletonEnforcer  );
			}
			return Container._instance;
		}
		public function addDisplayObject(displayObject:DisplayObject):void
		{
			   // removeDisplayObject();
				
				
		}
		public function createCuePoints(infoObject:Object){
			trace("onMetaData >");
			trace("\tNumber of cue points: " + infoObject.cuePoints.length);
			
			
			for(var i:Number = 0; i <infoObject.cuePoints.length; i++){
				/*var oCue:Object = infoObject.cuePoints[i];
				trace("\t\t" + i + ": " + oCue.name + ", " + oCue.type, ", " + oCue.time);
				//Global.getInstance().sendTracking(_currentVideo + "started/");
				//trace(_currentVideo + "started/")*/
				
				var cuePointClip:CuePointClip = new CuePointClip(i, infoObject.cuePoints[i].name, infoObject.cuePoints[i].time);
				cuePointClip.buttonMode = true;
				cuePointClip.name = infoObject.cuePoints[i].name;
				cuePointClip.x = (infoObject.cuePoints[i].time * 473 / infoObject.duration) + 45 ;
				//cuePointClip.y = 0;
				addChild(cuePointClip);
			}
		}
		
		public function jumpToCuePoint(val:String){
			for(var i:int = 0; i <= this.numChildren; i++ )
				if(this.getChildByName(val) != null){
					var oCue:CuePointClip = CuePointClip(this.getChildByName(val));
					VideoPlayer.getInstance().seekVideoTo(oCue.time);
				}
				else
					trace("this is null");
		}
		
		public function removeDisplayObject():void
		{
			if (numChildren > 0)
			{
				removeChildAt(0);
				//addChild(displayObject);
			}
			else
			{
				trace("No Object to remove");
				//addChild(displayObject);
			}
		}
	
}
	
	
}
class SingletonEnforcer
{
}