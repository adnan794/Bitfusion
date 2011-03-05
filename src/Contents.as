////////////////////////////////////////////////////////////////////////////////
//
//  Adnan Babar, www.odeon.co.uk/MicroSite
//  
//  NOTICE: Adnan Babar permits you to use, modify, and distribute this file
//
////////////////////////////////////////////////////////////////////////////////

package co.uk.odeon.microsite
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

	public class Contents 
	{
		//----------------------------------------------------------------------
		
		 /**
        *  @private static
        *  Array to hold all movies Soundtrack objects 										  
        */
		private static  var __children:Array = new Array();
															   
		private var _id:int;                // To hold the Id 
		private var _isNew:String;         // If new sound track or not
		private var _isRecommended:String; // Odeon Recommended or not
		private var _name:String;
		private var _description:String;
		private var _thumbnailURL:String;
		private var _imageURL:String;
		private var _genre:String;
		private var _releaseDate:String;
		private var _price:String;
		private var _itunesLink:String;
		private var _amazonLink:String;
		private var _trackList:Array; // Array to hold track list for movie
		private var _videoList:Array; // Array to hold vidoe links
		
		//--------------------------------------------------------------------------
       
	    /**
        *  Constructor
		*  constructor is used to initialize the main containers and backgrounds 
        *  after doing that it adds them to the display list as children of the
		*  the current project detail object
        */
		
	    //--------------------------------------------------------------------------
		
		public function Contents(id:int, isNew:String, isRecommended:String,
										  name:String, description:String, thumbnailURL:String, 
										  imageURL:String, genre:String, releaseDate:String,
										  price:String, itunesLink:String, amazonLink:String, 
										  trackList:Array)
		{
			_id = id;
			_isNew = isNew;
			_isRecommended = isRecommended;
			_name = name;
			_description = description;
			_thumbnailURL = thumbnailURL;
			_imageURL = imageURL;
			_genre = genre;
			_releaseDate = releaseDate;
			_price = price;
			_itunesLink = itunesLink;
			_amazonLink = amazonLink;
			_trackList = trackList;

			SoundtrackContent.__children.push(this);
			
		}
		
		public static function getChildren():Array
		{
			return __children;
		}
		
		public function get id():int
		{
			return _id;
		}
		
		public function get isNew():String
		{
			return _isNew;
		}
		
		public function get isRecommended():String
		{
			return _isRecommended;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function get description():String
		{
			return _description;
		}
		
		public function get thumbnailURL():String
		{
			return _thumbnailURL;
		}
		
		public function get imageURL():String
		{
			return _imageURL;
		}
		
		public function get genre():String
		{
			return _genre;
		}
		
		public function get releaseDate():String
		{
			return _releaseDate;
		}
	
	    public function get price():String
		{
			return _price;
		}
		
		public function get itunesLink():String
		{
			return _itunesLink;
		}
		
		public function get amazonLink():String
		{
			return _amazonLink;
		}
		
		public function get trackList():Array
		{
			return _trackList;
		}
		
		
		
	}
}