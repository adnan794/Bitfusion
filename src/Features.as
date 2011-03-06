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
			rollOverBtn.alpha = 0;
			
			this.addEventListener(MouseEvent.MOUSE_OVER, onRolloverBtn)
			//this.addEventListener(MouseEvent.MOUSE_OVER, onOut);
			
			openFeatures.addEventListener(MouseEvent.CLICK, onOpenFeaturesClick);
			mcFullScreen.addEventListener(MouseEvent.CLICK, onFullScreenClicked);
			mcFullScreen.addEventListener(MouseEvent.MOUSE_OVER, onOver );
			mcFullScreen.addEventListener(MouseEvent.MOUSE_OUT, onOut );
			
		}
		
		private function onRolloverBtn(e:MouseEvent) {
			trace("MouseOver")
			if (e.target.name == "rollOverBtn"){
			_panelOpen = false;
			this.gotoAndPlay("out");
			}
		}
		
		private function onOver(e:MouseEvent) {
			trace("MouseOver")
			trace("The target is given as " + e.target);
			//mcFullScreen.gotoAndStop(2);
			trace("The name is given as  " + e.target.name);

		}
		private function onOut(e:MouseEvent) {
			
			trace("MouseOut")
			trace("The target is given as " + e.target);
			//e.currentTarget.gotoAndStop(1);
			//e.target.gotoAndStop(1);
			//testOver.gotoAndStop(1);
			mcFullScreen.gotoAndStop(1);
			
			//e.target.alpha = 1
		}
		private function onOpenFeaturesClick(e:MouseEvent) {
			checkPanel();
			trace("Panel Clicked");
			mcFullScreen.addEventListener(MouseEvent.CLICK, onFullScreenClicked);
		}
		
		public function checkPanel(){
			if(_panelOpen){
				_panelOpen = false;
				this.gotoAndPlay("out");
				
				
			}else{
				_panelOpen = true;
				this.gotoAndPlay("over");
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
