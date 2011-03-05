package src
{
	import flash.display.MovieClip;

	public class CuePointClip extends MovieClip
	{
		private var _name:String;
		private var _time:Number;
		private var _id:int;
		
		public function CuePointClip(id:int,nam:String, time:Number)
		{
			/*trace("CuePoints Created");
			_name = nam;
			_id = id;
		//	num.text = _name;
			this.mouseChildren = false;
			num.text = nam;
			trace(nam)
			_time = time;
			*/
		}
		
		public function get cuePointName():String{
			return _name;
		}
		public function get time():Number{
			return _time;
		}
		public function get id():int{
			return _id;
		}
	}
}