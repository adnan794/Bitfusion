﻿package src{	import flash.display.*;	import flash.events.MouseEvent;	public class Features extends MovieClip	{		private var _email:Email;		private var _panelOpen:Boolean = false;		public function Features()		{			rollOverBtn.alpha = 0;			this.addEventListener(MouseEvent.MOUSE_OVER, onOver);			this.addEventListener(MouseEvent.CLICK, onClick);			this.addEventListener(MouseEvent.MOUSE_OUT, onOut);			openFeatures.addEventListener(MouseEvent.CLICK, onOpenFeaturesClick);			mcFullScreen.addEventListener(MouseEvent.CLICK, onFullScreenClicked);			_email = new Email  ;			_email.name = "email";		}		private function handleOver(str:String)		{			switch (str)			{				case "rollOverBtn" :					_panelOpen = false;					this.gotoAndPlay("out");					break;				case "mcFullScreen" :					mcFullScreen.gotoAndStop(2);					break;				case "mcEmail" :					mcEmail.gotoAndStop(2);					break;			}		}		private function handleOut(str:String)		{			switch (str)			{				case "mcFullScreen" :					mcFullScreen.gotoAndStop(1);					break;				case "mcEmail" :					mcEmail.gotoAndStop(1);					break;			}		}		private function onClick(e:MouseEvent)		{			trace("Object Clicked" + e.target.name);			if (e.target.name == "mcEmail")				onEmailClick();			else			trace("Do nothing");		}		private function onEmailClick()		{			Application(this.root.loaderInfo.content).addChild(_email);			Application(this.root.loaderInfo.content).disableInterface();			Application(this.root.loaderInfo.content).addEmailToStage();		}		private function onOver(e:MouseEvent)		{			handleOver(e.target.name);		}		private function onOut(e:MouseEvent)		{			handleOut(e.target.name);		}		private function onOpenFeaturesClick(e:MouseEvent)		{			checkPanel();			mcFullScreen.addEventListener(MouseEvent.CLICK, onFullScreenClicked);		}		public function checkPanel()		{			if (_panelOpen)			{				_panelOpen = false;				this.gotoAndPlay("out");			}			else			{				_panelOpen = true;				this.gotoAndPlay("over");			}		}		public function closePanel()		{			this.gotoAndStop(1);			_panelOpen = false;		}		private function onFullScreenClicked(e:MouseEvent)		{			Application(root.loaderInfo.content).onFullScreenClicked();		}	}}