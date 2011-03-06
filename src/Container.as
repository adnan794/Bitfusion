package src 
{
	//import caurina.transitions.*;
	
	import flash.display.*;
	import flash.events.MouseEvent;
	
	public class Container extends Sprite
	{

		static private  var _instance:Container;
		private var _showing:Boolean = true;
		private var _mc:MovieClip = new MovieClip;

		
		
		public function Container(singletonEnforcer:SingletonEnforcer)
		{
        //addChild(_mc);
		}
		
		public static function getInstance():Container
		{
			if (Container._instance == null)
			{
				Container._instance=new Container(new SingletonEnforcer  );
			}
			return Container._instance;
		}
		public function showHide(val:Boolean = false) {
			_showing = val;
		    if (_showing)
			Application(this.root.loaderInfo.content).checkImage();
			
			this.visible = val;
			
		}
		
		public function addImage(obj:LoaderInfo)
		{
			//_mc.addChild(obj.content);
		}
		
		public function isShowing():Boolean {
			return _showing;
		}
		
		public function resize(x:Number, y:Number,w:Number, h:Number) {
			this.getChildAt(0).x = x;
		    this.getChildAt(0).y = y;
			this.getChildAt(0).width = w;
			this.getChildAt(0).height = h;
		}
	
		
		
	
}
	
	
}
class SingletonEnforcer
{
}