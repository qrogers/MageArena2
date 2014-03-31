package {
	import flash.text.*;
	import flash.display.*;
	import flash.events.*;
	public class FlashTf extends TextField {
		
		private var alphaCng:Number;
		public function FlashTf(ac:Number) {
			alphaCng = ac;
			addEventListener(Event.ENTER_FRAME, eFrame);
		}
		private function eFrame(e:Event):void {
			if (alpha <= 0) {
				removeEventListener(Event.ENTER_FRAME, eFrame);
				parent.removeChild(this);
			} else {
				alpha -=  alphaCng;
			}
		}

	}

}