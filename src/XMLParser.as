////////////////////////////////////////////////////////////////////////////////
//
//  Adnan Babar, www.odeon.co.uk/MicroSite
//  
//  NOTICE: Adnan Babar permits you to use, modify, and distribute this file
//
////////////////////////////////////////////////////////////////////////////////

package siemensdm
{
	import flash.xml.*;
	import flash.events.Event;
	import flash.events.EventDispatcher;

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

	public class XMLParser extends EventDispatcher
	{
		//----------------------------------------------------------------------

		//Class properties


		//----------------------------------------------------------------------

		/**
		*  Constructor
		*  constructor does nothing in this case and is used only to initialize 
		*  the object
		*/

		//----------------------------------------------------------------------
		public function XMLParser()
		{

		}// end constructor

		/**
		*  This function accepts an XML object parses it and creates new SoundtrackContent
		*  objects by passing values to the SoundtrackContent constructors
		*  This is static method and can be used from outside the class without 
		*  creating any objects
		*
		*  @param xml object which includes a list of movie soundtrack information w
		*
		*  @return void
		*/
		public function parseXml(xml:XML)
		{
			for (var i:int=0; i < upperLimit; i++)
			{
				_xml.*[i].@id, _xml.*[i].title,  _xml.*[i].@videoURL, _xml.*[i].color
				var id:int = xml.*[i].@id;
				var videoURL:String = xml.*[i].@videoURL;
				var cttcURL:String = xml.*[i].@cttcURL;
				var title:String = xml.*[i].title;
				var links:XML = xml.*[i].links;
			}
				dispatchEvent(new Event(Event.COMPLETE));
			
		}// end function

	}// end class
}// end package