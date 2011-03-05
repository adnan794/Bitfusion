package siemensdm
{
	import flash.display.Sprite;
	import flash.display.DisplayObject;
    import caurina.transitions.*;

	  
	public class Animation extends Sprite
	{
		static private  var __instance:Animation;
		public function Animation(singletonEnforcer:SingletonEnforcer)
		{

		}
		public static function getInstance():Animation
		{
			if (Animation.__instance == null)
			{
				Animation.__instance = new Animation(new SingletonEnforcer);
			}
			return Animation.__instance;
		}
		public function addDisplayObject(displayObject:DisplayObject):void
		{
			if (numChildren > 0)
			{
				removeDisplayObject();
				addChild(displayObject);
			}
			else
			{
				addChild(displayObject);
			}
		}
		public function removeDisplayObject():void
		{
			if (numChildren > 0)
			{
				removeChildAt(0);
				
			}
		}
		
	public function TweenMovement(tweenObject:DisplayObject, fromValue:Number, toValue:Number,
								  duration:Number)
	{
		tweenObject.y = fromValue;
	    Tweener.addTween(tweenObject,{y:toValue, time:duration, transition:"easeOutQuint"});
										// onComplete: TweenForward
			
										 
	}
		
		
		
	
	
	
	}
}
class SingletonEnforcer
{
}