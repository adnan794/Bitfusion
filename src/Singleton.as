package 
{
	import flash.display.*;


	public class Singleton extends Sprite
	{

		static private  var _instance:Singleton;
		

		public function Singleton(singletonEnforcer:SingletonEnforcer)
		{

		}
		public static function getInstance():Singleton
		{
			if (Singleton._instance == null)
			{
				Singleton._instance=new Singleton(new SingletonEnforcer  );
			}
			return Singleton._instance;
		}
		public function addDisplayObject(displayObject:DisplayObject):void
		{
			
			if (numChildren > 0)
			{
				removeChildAt(0);
				addChild(displayObject);
			}
			else
			{
				addChild(displayObject);
			}
		}
		public function setAlpha(val:Number)
		{
			//this.displayObject.alpha = val;
		}
		
	}
}
class SingletonEnforcer
{
}