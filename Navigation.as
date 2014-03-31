package  {
	
	public class Navigation extends Object {

		public function Navigation() {
			
		}
		public static function gotoMain():void {
			if (stage.contains(newCard) == true) {
				removeChild(newCard);
			}
			btnClear();
			makeMain();
			saveGame();
			displayTfSet(null, 5, 3);
		}

	}
	
}
