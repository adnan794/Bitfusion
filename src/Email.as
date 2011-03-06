package src 
{
	//import caurina.transitions.*;
	
	import flash.display.*;
	import flash.events.MouseEvent;
	
	
	
	public class Email extends MovieClip
	{
		private var _panelOpen:Boolean = false;
		
		public function Email() {
			trace("Email Created");
			btnSubmit.addEventListener(MouseEvent.CLICK, onSubmit);
			btnSubmit.txtSubmit.mouseEnabled = false;
		}
		
		private function onSubmit(e:MouseEvent) {
			Application(this.root.loaderInfo.content).enableInterface();
			
		}
		
		
		
    }
	
	
}
