﻿package src 
{
	//import caurina.transitions.*;
	
	import flash.display.*;
	import flash.events.MouseEvent;
	
	
	
	public class VolumeControl extends MovieClip
	{
		private var _email:Email;
		private var _panelOpen:Boolean = false;
		
		public function VolumeControl() {
			trace("Entered Features");
			rollOverBtn.alpha = 0;
			rollOverBtn.buttonMode = false;
			
			this.addEventListener(MouseEvent.MOUSE_OVER, onOver)
			//this.addEventListener(MouseEvent.CLICK, onClick);
			this.addEventListener(MouseEvent.MOUSE_OUT, onOut);
			
		}
		
		private function handleOver(str:String) {
			
			switch(str) {
				case "rollOverBtn":
				this.gotoAndPlay("out");
				break;
				
			}

		}
		
		private function handleOut(str:String) {
			switch(str) {
				
			}
		}
		
		
		
		private function onClick(e:MouseEvent) {
			trace("Object Clicked" + e.target.name);
			if (e.target.name == "mcEmail")
			onEmailClick();
			else
			trace("Do nothing")
			
		}
		
		private function onEmailClick() {
			//var email:Email = new Email;
			/*email.x = 187.5;
			email.y = 110;*/
			
			
			
			
		}
		
	
		
		private function onOver(e:MouseEvent) {
			trace("The object over is: " + e.target.name)
			//e.target.gotoAndStop(2);
			handleOver(e.target.name);

		}
		private function onOut(e:MouseEvent) {
			
			
			handleOut(e.target.name);
		}
		
					public function closePanel()
			{
				this.gotoAndStop(1);
		//		_panelOpen = false;
				
			}
			
	    
		

		
    }
	
	
}
