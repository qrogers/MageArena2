package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	public class Achivement extends MovieClip {
		
		private var dir:int;
		private var delay:int;
		public function Achivement() {
			dir = 1;
			delay = 0;
			addEventListener(Event.ENTER_FRAME, eFrame);
		}
		private function eFrame(e:Event):void {
			if(y>475 && dir==1){
				y-=1.5;
			} else if(dir==2){
				if(delay>= 120){
					y+=1.5;
				} else {
					delay++;
				}
			} else if(y>551){
				removeEventListener(Event.ENTER_FRAME, eFrame);
				parent.removeChild(this);
			} else {
				dir = 2;
			}
		}
		public static function Name(num:int) {
			if(num == 1){
				return("Rags to riches");
			} else if (num == 2){
				return("The strong");
			} else if (num == 3){
				return("The weak");
			} else if (num == 4){
				return("Back on your feet");
			} else if (num == 5){
				return("Feeling good");
			} else if (num == 6){
				return("A chill");
			} else if (num == 7){
				return("1 in 7M");
			} else if (num == 8){
				return("Underwater");
			} else if (num == 9){
				return("Quickly now");
			} else if (num == 10){
				return("Insult to injury");
			} else if (num == 11){
				return("The forbidden one");
			} else if (num == 12){
				return("Bonk!");
			} else if (num == 13){
				return("Shhhh!");
			} else if (num == 14){
				return("Now you see me...");
			} else if (num == 15){
				return("Never beter");
			} else if (num == 16){
				return("Overwhealming");
			} else if (num == 17){
				return("Almighty");
			} else if (num == 18){
				return("The wall");
			} else if (num == 19){
				return("I will have power!");
			} else if (num == 20){
				return("Speed demon");
			} else if (num == 21){
				return("Through the fire");
			} else if (num == 22){
				return("All mine");
			} else if (num == 23){
				return("Truly magical");
			} else if (num == 24){
				return("Only a flesh wound");
			} else if (num == 25){
				return("Immuninty");
			} else if (num == 26){
				return("Scared of the dark");
			} else if (num == 27){
				return("Nothing left");
			} else if (num == 28){
				return("Godly");
			} else if (num == 29){
				return("The diffrence...");
			} else if (num == 30){
				return("Ninjitsu");
			} else if (num == 31){
				return("All gone");
			} else if (num == 32){
				return("Overbearing");
			} else if (num == 33){
				return("Impenetrable");
			} else if (num == 34){
				return("Motion blur");
			} else if (num == 35){
				return("Slow and steady");
			} else if (num == 36){
				return("Sealed fate");
			} else if (num == 37){
				return("Amnesia");
			} else if (num == 38){
				return("I can't hear you");
			} else if (num == 39){
				return("Endless power");
			} else if (num == 40){
				return("Bad enought");
			} else if (num == 41){
				return("And the flames");
			} else if (num == 42){
				return("Electrifying");
			} else if (num == 43){
				return("I've been waiting");
			} else if (num == 44){
				return("Not a scratch");
			} else if (num == 45){
				return("I hope this works");
			} else if (num == 46){
				return("Final countdown");
			} else if (num == 47){
				return("In the nick of time");
			} else if (num == 48){
				return("I'm ruined");
			} else if (num == 49){
				return("1 for 3");
			} else if (num == 50){
				return("Etru?");
			}
		}
		public static function Reason(num:int) {
			if(num == 1){
				return("Have over 500 gold");
			} else if (num == 2){
				return ("Have over 20 attack");
			} else if (num == 3){
				return("Reduce foes attack to 0");
			} else if (num == 4){
				return("Remove an effect");
			} else if (num == 5){
				return("Have over 200 health");
			} else if (num == 6){
				return("Reveal your foe");
			} else if (num == 7){
				return("Kill you foe with lighting");
			} else if (num == 8){
				return("Conect with Aqua Blast");
			} else if (num == 9){
				return("Hit your foe several times");
			} else if (num == 10){
				return("Deal spell damage to a stuned foe");
			} else if (num == 11){
				return("Kill a foes with curse damage");
			} else if (num == 12){
				return("Have a foe with boosted attack stuned");
			} else if (num == 13){
				return((["Silence a foe when they have 30 or more",
						"mana",
						  ]).join("\n"));
			} else if (num == 14){
				return("Dodge an attack");
			} else if (num == 15){
				return("Heal to over your starting health");
			} else if (num == 16){
				return("Mana blast 50 or more mana");
			} else if (num == 17){
				return("Deal over 100 damage in an attack");
			} else if (num == 18){
				return("Take no damage in an attack");
			} else if (num == 19){
				return("Have over 50 mana");
			} else if (num == 20){
				return("Attack 4 times");
			} else if (num == 21){
				return("Win with less than 20 health");
			} else if (num == 22){
				return("Have 100 or more health than your foe");
			} else if (num == 23){
				return("Deal 100 or more damage with a spell");
			} else if (num == 24){
				return("Have over 350 health");
			} else if (num == 25){
				return("Use a cure spell when you have no effects");
			} else if (num == 26){
				return("Dodge a would be fatal blow");
			} else if (num == 27){
				return("Reduce a foes mana to 0");
			} else if (num == 28){
				return("Have over 100 attack");
			} else if (num == 29){
				return((["Have at least 50 more attack than your",
						 "foe",
						  ]).join("\n"));
			} else if (num == 30){
				return("Dodge an attack of 50 or more power");
			} else if (num == 31){
				return("Use every spell in you deck");
			} else if (num == 32){
				return("Boost your attack by 40 or more");
			} else if (num == 33){
				return("Have at least 100 health at turn 10");
			} else if (num == 34){
				return("Win in less than 4 turns");
			} else if (num == 35){
				return("Win a battle with over 40 mana left");
			} else if (num == 36){
				return("Have a curse deal at least 30 damage");
			} else if (num == 37){
				return("Stun a foe while stuned");
			} else if (num == 38){
				return("Mute and stun a foe at the same time");
			} else if (num == 39){
				return("Purchase Great Mana Surge");
			} else if (num == 40){
				return("Stun and curse your foe");
			} else if (num == 41){
				return("Win a battle with less than 5 health");
			} else if (num == 42){
				return("Survive 50 points of damge from one spell");
			} else if (num == 43){
				return("Use a time bomb at or after turn 5");
			} else if (num == 44){
				return("Have over 500 health");
			} else if (num == 45){
				return((["Use Explosion when you have less than 80",
							 "health",
							 ]).join("\n"));
			} else if (num == 46){
				return((["Curse a foe while cursed, but for a longer", 
									 "duration",
									 ]).join("\n"));
			} else if (num == 47){
				return((["Use Savior to heal so will survive another",
							"attack",
							 ]).join("\n"));
			} else if (num == 48){
				return((["Use Destroyer to lower foes health into",
						 "killing range",
						  ]).join("\n"));
			} else if (num == 49){
				return((["Cast Rexlarinek when you have exactly 50",
						 "mana",
						  ]).join("\n"));
			} else if (num == 50){
				return("Cast Etru, and win");
			}
		}
	}
	
}
