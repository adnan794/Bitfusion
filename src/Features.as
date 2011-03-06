package src 
{
	//import caurina.transitions.*;
	
	import flash.display.*;
	import flash.events.MouseEvent;
	
	
	
	public class Features extends MovieClip
	{
		private var _panelOpen:Boolean = false;
		
		public function Features() {
			trace("Entered Features");
			
			//this.addEventListener(MouseEvent.MOUSE_OVER, onOver)
			//this.addEventListener(MouseEvent.MOUSE_OVER, onOut);
			
			openFeatures.addEventListener(MouseEvent.CLICK, onOpenFeaturesClick);
			mcFullScreen.addEventListener(MouseEvent.CLICK, onFullScreenClicked);
			this.mcFullScreen.addEventListener(MouseEvent.MOUSE_OVER, onOver )
			this.mcFullScreen.addEventListener(MouseEvent.MOUSE_OUT, onOut )
			
		}
		
		private function onOver(e:MouseEvent) {
			trace("MouseOver")
			trace("The target is given as " + e.target);
			mcFullScreen.gotoAndStop(2);
			//e.target.gotoAndStop(2);
			//e.currentTarget.gotoAndStop(2);
		}
		private function onOut(e:MouseEvent) {
			
			trace("MouseOut")
			trace("The target is given as " + e.target);
			//e.currentTarget.gotoAndStop(1);
			//e.target.gotoAndStop(1);
			mcFullScreen.gotoAndStop(1);
		}
		private function onOpenFeaturesClick(e:MouseEvent) {
			checkPanel();
			trace("Panel Clicked");
			mcFullScreen.addEventListener(MouseEvent.CLICK, onFullScreenClicked);
		}
		
		public function checkPanel(){
			if(_panelOpen){
				_panelOpen = false;
				this.gotoAndStop(1);
				
			}else{
				_panelOpen = true;
				this.gotoAndPlay(2);
			}
		}
		
					public function closePanel()
			{
				this.gotoAndStop(1);
				_panelOpen = false;
				
			}
		private function onFullScreenClicked(e:MouseEvent)
		{
			//trace("FullScreenClicked");
			Application(root.loaderInfo.content).onFullScreenClicked();
		}

		
    }
	
	
}
