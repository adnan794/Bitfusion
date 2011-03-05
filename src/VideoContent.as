////////////////////////////////////////////////////////////////////////////////
//
//  Adnan Babar, www.odeon.co.uk/MicroSite
//  
//  NOTICE: Adnan Babar permits you to use, modify, and distribute this file
//
////////////////////////////////////////////////////////////////////////////////

package videoplayer
{
	//--------------------------------------------------------------------------
	
	    /**
        *  ActionScript 3.0 ProjectDetail
        *  Sept 2008
        *
        *  This class loads project details which includes project name, 
		*  description and an image gallery containing the screen shots
        *  of the specific project
        */

    //--------------------------------------------------------------------------

	public class VideoContent 
	{
		//----------------------------------------------------------------------
		
		 /**
        *  @private static
        *  Array to hold all movies Soundtrack objects 										  
        */
		private static  var __children:Array = new Array();
															   
		private var _id:int;                // To hold the Id 
		private var _videoURL:String;
		private var _title:String;
		private var _description:String;
		private var _thumbnailURL:String;
		private var _detailURL:String;
		private var _imageURL:String;
		
		//--------------------------------------------------------------------------
       
	    /**
        *  Constructor
		*  constructor is used to initialize the main containers and backgrounds 
        *  after doing that it adds them to the display list as children of the
		*  the current project detail object
        */
		
	    //--------------------------------------------------------------------------
		
		public function VideoContent(id:int, videoURL:String, title:String, 
									 description:String, thumbnailURL:String,
									 detailURL, imageURL:String)
		{
			_id = id;
			_title = title;
			_description = description;
			_imageURL = imageURL;
			_detailURL = detailURL;
			_videoURL = videoURL;
			_thumbnailURL = thumbnailURL;
		
			__children.push(this);
			
		}
		
		public static function getChildren():Array
		{
			return __children;
		}
		
		public function get id():int
		{
			return _id;
		}
		
		public function get title():String
		{
			return _title;
		}
		
		public function get description():String
		{
			return _description;
		}
		
		public function get thumbnailURL():String
		{
			return _thumbnailURL;
		}
		
		public function get detailURL():String
		{
			return _detailURL;
		}
		
		public function get imageURL():String
		{
			return _imageURL;
		}
		
		public function get videoURL():String
		{
			return _videoURL;
		}
	} // end of class
} // end of package