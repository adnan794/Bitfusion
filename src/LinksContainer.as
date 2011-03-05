package siemensdm 
{
	import flash.display.*;
    import caurina.transitions.*;
	
	

	public class LinksContainer extends Sprite
	{

		static private  var __instance:LinksContainer;
        private static var _leftVal:Number;
		private static var _rightVal:Number;
		private var _displayObject:DisplayObject;
		private var _oldObject:DisplayObject;
		private var _index:Number;
		
		
		public function LinksContainer(singletonEnforcer:SingletonEnforcer)
		{
         _leftVal = -195;
		 _rightVal = 195;
		 _index = 0;
		 //_content = new Content;
		 //addChild(_content);
		}
		public static function getInstance():LinksContainer
		{
			if (LinksContainer.__instance == null)
			{
				LinksContainer.__instance=new LinksContainer(new SingletonEnforcer);
			}
			return LinksContainer.__instance;
		}
		public function addDisplayObject(displayObject:DisplayObject, xValue:Number, yValue:Number):void
		{
				//trace("ADDOBJECT")
				removeDisplayObject();
				_displayObject = displayObject;
				_displayObject.alpha = 0;
				_displayObject.x = xValue;
				_displayObject.y = yValue;
				addChild(_displayObject);
				FadeIn();
				
				
		}
		
		
		public function FadeIn():void
		{
			Tweener.addTween(_displayObject,{alpha:1,time:3.5,transition:"easeOutQuint"
										 
										  });
		}
		public function FadeOut():void
		{
			if ( numChildren > 0)
			{
				Tweener.addTween(getChildAt(0),{alpha:0,time:2.5,transition:"easeOutQuint",
										  onComplete:removeDisplayObject
										  });
			}
			
			
		}
		
		public function TweenBackward()
		{
			trace("Entered Tween BackWard");
			if( numChildren > 0)
			{
			   removeChildAt(0);
			}
		    _displayObject.x = _rightVal;
			addChild(_displayObject);
			//Tweener.addTween(_displayObject,{x:0,time:3,transition:"easeOutQuint"
										  //onCmplete: TweenForward();
										 
										// });
			
			
		}
		public function TweenForward()
		{
			if( numChildren > 0)
			{
			   removeChildAt(0);
			}
		    _displayObject.x = _leftVal;
			addChild(_displayObject);
			//Tweener.addTween(_displayObject,{x:0,time:3,transition:"easeOutQuint"
										  //onCmplete: TweenForward();
										 
										// });
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