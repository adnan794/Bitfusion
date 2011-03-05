////////////////////////////////////////////////////////////////////////////////
//
//  Adnan Babar, Siemens Open Web video Player
//  
//  NOTICE: AMAZE PLC does not permits you to use, modify, and distribute this 
//          file
//
////////////////////////////////////////////////////////////////////////////////
package siemensdm
{
	public class CuePointsHandler
	{
		
		
		public function CuePointsHandler()
		{
			
		}
		public static function onCuePoints(infoObject:Object)
		{
			trace(infoObject.name);
			
			switch(infoObject.name)
			{
				case "introFinish":
				
				Global.getInstance().showNavigation();
				ButtonManager.getInstance().visible = true;
				ButtonManager.getInstance().startIntroTimer(10000);
				ButtonManager.getInstance().createCttcButtons();
				ButtonManager.getInstance().createLinks("streamline");
				ButtonManager.getInstance().createLinks("outsmart");
				ButtonManager.getInstance().createLinks("primed");
				ButtonManager.getInstance().createLinks("endscene");
				break;
				case "streamlineCttcButton":
				trace("Eneterd Streamline Switch")
				Container.getInstance().addDisplayObject(ButtonManager.getInstance().streamlineCttc);
				break;
				case "streamlineCttcFinish":
				trace("Eneterd Streamline CTTC FINIS");
				CttcEnd.getInstance().startEndTimer();
				break;
				case "streamlineNavShow":
				LinksContainer.getInstance().addDisplayObject(ButtonManager.getInstance().streamlineLinksContainer, 275, 180);
				Container.getInstance().removeDisplayObject();
				Global.getInstance().hideNavigation();
				break;
				case "streamlineNavHide":
				LinksContainer.getInstance().FadeOut();
				Global.getInstance().showNavigation();
				break;
				case "streamlineCttcNav":
				LinksContainer.getInstance().addDisplayObject(ButtonManager.getInstance().streamlineLinksContainer, 29, 96.5);
				break;
				case "outsmartNavShow":
				LinksContainer.getInstance().addDisplayObject(ButtonManager.getInstance().outsmartLinksContainer, 263.5, 167);
				Container.getInstance().removeDisplayObject();
				Global.getInstance().hideNavigation();
				break;
				case "outsmartNavHide":
				LinksContainer.getInstance().FadeOut();
				Global.getInstance().showNavigation();
				break;
				case "outsmartCttcButton":
				trace("Outsmart CTTC")
				Container.getInstance().addDisplayObject(ButtonManager.getInstance().outsmartCttc);
				break;
				case "outsmartCttcNavShow":
				LinksContainer.getInstance().addDisplayObject(ButtonManager.getInstance().outsmartLinksContainer, 28, 96.5);
				break;
				case "outsmartCttcFinish":
				CttcEnd.getInstance().startEndTimer();
				break;
				case "primedCttcButton":
				Container.getInstance().addDisplayObject(ButtonManager.getInstance().primedCttc);
				break;
				
				case "primedNavShow":
				trace("Entered Primed Nav Show")
				LinksContainer.getInstance().addDisplayObject(ButtonManager.getInstance().primedLinksContainer, 286, 174.5);
				Container.getInstance().removeDisplayObject();
				Global.getInstance().hideNavigation();
				break;
				case "primedNavHide":
				LinksContainer.getInstance().FadeOut();
				Global.getInstance().showNavigation();
				break;
				case "primedCttcNav":
				trace("Entered Primed Nav Show")
				LinksContainer.getInstance().addDisplayObject(ButtonManager.getInstance().primedLinksContainer, 28, 96.5);
				break;
				case "primedCttcFinish":
				trace("Eneterd outsmart CTTC FINIS");
				CttcEnd.getInstance().startEndTimer();
				break;
				case "primedFinish":
				Global.getInstance().startEndTimer();
				ButtonManager.getInstance().enableButtons();
				break;
				case "streamlineFinish":
				Global.getInstance().startEndTimer();
				ButtonManager.getInstance().enableButtons();
				break;
				case "outsmartFinish":
				Global.getInstance().startEndTimer();
				ButtonManager.getInstance().enableButtons();
				break;
				case "endNavShow":
				trace("Entered end Nav Show")
				LinksContainer.getInstance().addDisplayObject(ButtonManager.getInstance().endsceneContainer, 247, 170);
				Container.getInstance().removeDisplayObject();
				break;
			} //end switch
		}
	}
	
}