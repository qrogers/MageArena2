package {

	/*Mage Arena 2
	Programmed by:
	Quin Rogers
	Snailboy Games
	*-*-*-*-*-*-*-*-*-*-*-*-*
	*/
	//fixes/bugs:
	
	//updates:
	
	//balence:
	
	
	import flash.display.MovieClip;
	import flash.display.LoaderInfo;
	import flash.display.Loader;
	import flash.ui.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.text.*;
	import flashx.textLayout.formats.FormatValue;
	import flash.net.SharedObject;
	import flash.net.URLRequest;
	import flash.system.Security;
	import flashx.textLayout.elements.InlineGraphicElement;
	

	public class Core extends MovieClip {

		private var turn:int;
		private var countDown:int;
		private var enCountDown:int;
		private var atkCount:int;
		private var enAtkCount:int;
		private var exp:int;
		private var expTN:int;
		private var plrLvl:int;
		private var enLvl:int;
		private var reps:int;
		private var gold:int;
		private var bounty:int;
		private var health:int;
		private var healthStat:int;
		private var enHealth:int;
		private var enHealthStat:int;
		private var mana:int;
		private var manaRgn:int;
		private var attack:int;
		private var atkStat:int;
		private var enMana:int;
		private var enManaRgn:int;
		private var retry:Number;
		private var enAttack:int;
		private var curFoeNum:int;
		private var enAttackStat:int;
		private var turnStage:int;
		private var cardPlay:int;
		private var deckMax:int;
		private var deckMin:int;
		private var cardMax:int;
		private var enTrnCur:int;
		private var plrTrnCur:int;
		private var enTrnStn:int;
		private var plrTrnStn:int;
		private var plrHid:int;
		private var plrTrnHid:int;
		private var plrTrnSil:int;
		private var enHid:int;
		private var enTrnHid:int;
		private var enTrnSil:int;
		private var classNum:int;
		private var classLvl:int;
		private var plrDmgBoost:int;
		private var enDmgBoost:int;
		private var plrDmgMod:Number;
		private var enDmgMod:Number;
		private var plrSil:Boolean;
		private var dropChance:Number;
		private var enSil:Boolean;
		private var enCursed:Boolean;
		private var plrCursed:Boolean;
		private var enStuned:Boolean;
		private var plrStuned:Boolean;
		private var seenCred:Boolean = false;
		private var costs:Array;
		private var price:Array;
		private var deck:Array;
		private var side:Array;
		private var enDeck:Array;
		private var enSet:Array;
		private var deckGame:Array;
		private var inPlay:Array = new Array();
		private var btnHolder:Array = new Array();
		private var tfHold:Array = new Array();
		private var aUnlock:Array = new Array();
		private var main:Main;
		private var mainEn:Main;
		private var mage:Mage;
		private var warr:Warr;
		private var roge:Roge;
		private var newCard:Card;
		private var newAtkBtn:MainBtn;
		private var newMainBtn:MainBtn;
		private var expBar:Bar;
		private var animating:Object;
		private var rotating:Object;
		private var flashing:Object;
		private var curFoeCls:String;
		private var plrClass:String;
		private var displayTf:TextField;
		private var storeTf:TextField;
		private var saveGame1:SharedObject = SharedObject.getLocal("csb14ma2183");//sb14ma2183
		private var saveGame2:SharedObject = SharedObject.getLocal("csb14ma2184");//sb14ma2183
		private var saveGame3:SharedObject = SharedObject.getLocal("csb14ma2185");//sb14ma2183
		private var saveGame4:SharedObject = SharedObject.getLocal("csb14ma2186");//sb14ma2183
		private var saveGame5:SharedObject = SharedObject.getLocal("csb14ma2187");//sb14ma2183
		private var saveGameA:SharedObject = SharedObject.getLocal("csb14ma2188");//sb14ma2183
		var paramObj:Object = LoaderInfo(root.loaderInfo).parameters;
		var apiPath:String = paramObj.kongregate_api_path || 
  		"http://www.kongregate.com/flash/API_AS3_Local.swf";
		var request:URLRequest = new URLRequest(apiPath);
		var loader:Loader = new Loader();
		var kongregate:*;

		public function Core() {
			loaderInfo.addEventListener( Event.COMPLETE, onCompletelyDownloaded );
			loaderInfo.addEventListener( ProgressEvent.PROGRESS, onProgressMade );
			Security.allowDomain(apiPath);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete);
			loader.load(request);
			this.addChild(loader);
		}
		private function loadComplete(e:Event):void {
			kongregate = e.target.content;
   		kongregate.services.connect();
		}
		private function onCompletelyDownloaded(e:Event):void {
			gotoAndStop(2);
			var clrBar1:ClrBar1 = new ClrBar1();
			clrBar1.x = 362.5;
			clrBar1.y = 50;
			addChild(clrBar1);
			displayCreator();
			btnMake(280,250,9,"charSelect");
			btnMake(420,250,10,"charSelect");
		}
		/*private function saveWarn(m:MouseEvent){
			btnClear();
			if(saveGame1.size == 0){
				charSelect();
			} else {
				displayTfSet(null, 20, 3);
				btnMake(200,300,14,"charSelect");
			}
		}*/
		private function backUp(e:Event):void {
			btnClear();
			btnMake(280,250,9,"charSelect");
			btnMake(420,250,10,"charSelect");
			removeChild(mage);
			removeChild(warr);
			removeChild(roge);
			displayTfSet(null, 5, 3);
		}
		private function charSelect(m:MouseEvent):void {
			btnClear();
			displayTfSet(null, 18, 3);
			mage = new Mage();
			mage.x = 150;
			mage.y = 300;
			mage.addEventListener(MouseEvent.MOUSE_OVER, classInfo);
			addChild(mage);
			warr = new Warr();
			warr.x = 350;
			warr.y = 300;
			warr.addEventListener(MouseEvent.MOUSE_OVER, classInfo);
			addChild(warr);
			roge = new Roge();
			roge.x = 550;
			roge.y = 300;
			roge.addEventListener(MouseEvent.MOUSE_OVER, classInfo);
			addChild(roge);
			if(m.target.currentFrame == 10 || m.target.currentFrame == 15){
				mage.addEventListener(MouseEvent.MOUSE_UP, confirm);
				warr.addEventListener(MouseEvent.MOUSE_UP, confirm);
				roge.addEventListener(MouseEvent.MOUSE_UP, confirm);
			} else {
				mage.addEventListener(MouseEvent.MOUSE_UP, loadGame);
				warr.addEventListener(MouseEvent.MOUSE_UP, loadGame);
				roge.addEventListener(MouseEvent.MOUSE_UP, loadGame);
			}
			btnMake(600,450,15,"backUp");
		}
		private function confirm(m:MouseEvent):void {
			removeChild(mage);
			removeChild(warr);
			removeChild(roge);
			btnClear();
			if(m.target == mage){
				plrClass = "MAGE";
				displayTfSet(null, 23, 3);
			} else if(m.target == warr){
				plrClass = "WARR";
				displayTfSet(null, 24, 3);
			} else if(m.target == roge){
				plrClass = "ROGE";
				displayTfSet(null, 25, 3);
			}
			btnMake(500,300,15,"charSelect");
			btnMake(200,300,14,"newGame");
		}
		private function loadGame(e:Event) {
			mage.removeEventListener(MouseEvent.MOUSE_UP, loadGame);
			warr.removeEventListener(MouseEvent.MOUSE_UP, loadGame);
			roge.removeEventListener(MouseEvent.MOUSE_UP, loadGame);
			removeChild(mage);
			removeChild(warr);
			removeChild(roge);
			if(saveGameA.size > 0){
				aUnlock = saveGameA.data.ao;
			}
			if(e.target == mage){
				if(saveGame1.size > 0){
					exp = saveGame1.data.xp;
					deck = saveGame1.data.deck;
					side = saveGame1.data.side;
					plrLvl = saveGame1.data.lvl;
					gold = saveGame1.data.money;
					atkStat = saveGame1.data.attack;
					healthStat = saveGame1.data.health;
					plrDmgMod = saveGame1.data.dmgMod;
					manaRgn = saveGame1.data.mana;
					deckMax = saveGame1.data.deckMax;
					deckMin = saveGame1.data.deckMin;
					cardMax = saveGame1.data.cardMax;
					cardPlay = saveGame1.data.cardPlay;
					classNum = saveGame1.data.avatar;
					classLvl = saveGame1.data.classLvl;
					seenCred = true;
				} else {
					plrClass = "MAGE";
					newGame();
				}
			} else if(e.target == warr){
				if(saveGame2.size > 0){
					exp = saveGame2.data.xp;
					deck = saveGame2.data.deck;
					side = saveGame2.data.side;
					plrLvl = saveGame2.data.lvl;
					gold = saveGame2.data.money;
					atkStat = saveGame2.data.attack;
					healthStat = saveGame2.data.health;
					plrDmgMod = saveGame2.data.dmgMod;
					manaRgn = saveGame2.data.mana;
					deckMax = saveGame2.data.deckMax;
					deckMin = saveGame2.data.deckMin;
					cardMax = saveGame2.data.cardMax;
					cardPlay = saveGame2.data.cardPlay;
					classNum = saveGame2.data.avatar;
					classLvl = saveGame2.data.classLvl;
					seenCred = true;
				} else {
					plrClass = "WARR";
					newGame();
				}
			} else if(e.target == roge){
				if(saveGame3.size > 0){
					exp = saveGame3.data.xp;
					deck = saveGame3.data.deck;
					side = saveGame3.data.side;
					plrLvl = saveGame3.data.lvl;
					gold = saveGame3.data.money;
					atkStat = saveGame3.data.attack;
					healthStat = saveGame3.data.health;
					plrDmgMod = saveGame3.data.dmgMod;
					manaRgn = saveGame3.data.mana;
					deckMax = saveGame3.data.deckMax;
					deckMin = saveGame3.data.deckMin;
					cardMax = saveGame3.data.cardMax;
					cardPlay = saveGame3.data.cardPlay;
					classNum = saveGame3.data.avatar;
					classLvl = saveGame3.data.classLvl;
					seenCred = true;
				} else {
					plrClass = "ROGE";
					newGame();
				}
				
			}
			gameStart();
		}
		private function newGame(e:Event=null) {
			plrLvl = 1;
			exp = 0;
			mage.removeEventListener(MouseEvent.MOUSE_UP, confirm);
			warr.removeEventListener(MouseEvent.MOUSE_UP, confirm);
			roge.removeEventListener(MouseEvent.MOUSE_UP, confirm);
			if(saveGameA.size > 0){
				aUnlock = saveGameA.data.ao;
			}
			gameStart();
			deck = new Array();
			if(plrClass == "MAGE"){
				deck = [5,5,6,6,7,7,8,8,9,11,12,13,14,16,16,17,17,20,20,22];//4,4,5,5,6,6,7,7,8,8,10,11,12,13,15,15,16,16,19,19,21
				manaRgn = 12;
				healthStat = 80;
				atkStat = 8;
				cardPlay = 4;
				classNum = 1;
				saveGame1.data.avatar = classNum;
			} else if (plrClass == "WARR"){
				deck = [3,3,3,4,4,4,6,6,6,10,12,13,13,14,14,18,18,19,19,21];//[3,3,3,7,7,7,5,11,11,18,18,21,14,5,13];
				manaRgn = 8;
				healthStat = 120
				atkStat = 12;
				cardPlay = 4;
				classNum = 2;
				saveGame2.data.avatar = classNum;
			} else if (plrClass == "ROGE"){
				//deck = [2,3,10,10,21,21,21,18,18,18,11,11,7,7,3];
				deck = [3,3,4,4,8,8,10,10,10,12,12,13,13,13,14,15,15,15,20,22];
				manaRgn = 10;
				healthStat = 100;
				atkStat = 10;
				cardPlay = 4;
				classNum = 3;
				saveGame3.data.avatar = classNum;
			}
			classLvl = 1;
			gold = 0;
			plrDmgMod = 1;
			deckMax = 25;
			deckMin = 20;
			cardMax = 60;
			side = new Array();
			side = [];
		}
		private function gameStart():void {
			btnClear();
			if(plrLvl == 1){
				expTN = 80;
			} else {
				expTN = ((plrLvl - 1) * 20) + 70;
			}
			costs = new Array();
			costs = [100,5,10,10,10,10,10,15,20,15,20,20,15,20,10,0,0,5,5,0,20,25,30,25,25,20,15,20,20,20,30,20,10,10,35,30,30,30,30,20,40,35,35,40,35,40,40,50,50,50,150];
			price = new Array();
			price = [100,0,100,100,100,100,120,120,120,150,150,180,180,180,180,180,190,190,190,190,200,200,200,220,230,250,250,250,300,320,320,320,320,350,350,370,370,380,380,380,400,400,400,400,400,400,400,500,500,500,500,600];
			newAtkBtn = new MainBtn();
			newAtkBtn.x = 200;
			newAtkBtn.gotoAndStop(16);
			newAtkBtn.tf.mouseEnabled = false;
			newAtkBtn.addEventListener(MouseEvent.MOUSE_UP,atkBtnPress);
			addChild(newAtkBtn);
			main = new Main();
			main.x = 200;
			newAtkBtn.y = 300;
			main.y = 190;
			mainEn = new Main();
			mainEn.x = 500;
			mainEn.y = 190;
			mainEn.gotoAndStop(2);
			addEventListener(Event.ENTER_FRAME, eFrame);
			saveGame();
			gotoMain();
		}
		public function onProgressMade( progressEvent:ProgressEvent ):void {
			loadedTf.text =  Math.floor(100 *(loaderInfo.bytesLoaded/loaderInfo.bytesTotal)) + "%";
			preloader.width = (loaderInfo.bytesLoaded/loaderInfo.bytesTotal) * 300;
		}
		private function eFrame(e:Event):void {
			if (flashing != null) {
				reps++;
				if (flashing.alpha == 0) {
					flashing.alpha = 1;
				} else {
					flashing.alpha = 0;
				}
				if (reps >= 10) {
					flashing.alpha = 1;
					flashing = null;
					reps = 0;
					deathCheck();
				}
			}

			if (animating != null) {
				if (animating.type != 1) {
					animating.alpha -=  .1;
					animating.width +=  1;
					animating.height +=  1;
				}
				if (animating.alpha <= 0) {
					animating.gotoAndStop(1);
					animating.type = 1;
					animating.alpha = 1;
					animating.width = 50;
					animating.height = 50;
					animating = null;
				}
			}
			if (rotating != null) {
				if(rotating.type == 1){
					rotating.alpha -=  .1;
					rotating.width +=  1;
					rotating.height +=  1;
					if (rotating.alpha <= 0) {
						rotating = null;
						drawCard();
					}
				}
			}
		}
		private function displayCreator():void {
			displayTf = new TextField();
			var format:TextFormat = new TextFormat();
			format.size = 26;
			format.color = 0x443E8C;
			format.font = "Copperplate Gothic Bold";
			displayTf.setTextFormat(format);
			displayTf.defaultTextFormat = format;
			displayTf.mouseEnabled = false;
			displayTf.selectable = false;
			displayTf.border = false;
			displayTf.x = 50;
			displayTf.y = 0;
			displayTf.height = 100;
			displayTf.width = 650;
			addChild(displayTf);
			displayTfSet(null, 5, 3);
		}
		private function tfCreator(xL:int, yL:int, val:String):void {
			var subTf:TextField;
			subTf = new TextField();
			var format:TextFormat = new TextFormat();
			format.size = 12;
			format.color = 0x443E8C;
			format.font = "Copperplate Gothic Bold";
			subTf.setTextFormat(format);
			subTf.defaultTextFormat = format;
			subTf.selectable = false;
			subTf.x = xL;
			subTf.y = yL;
			subTf.text = val;
			subTf.height = 30;
			subTf.width = 500;
			tfHold.push(subTf);
			addChild(subTf);
		}
		private function enSelect(m:MouseEvent):void {
			removeChild(expBar);
			tfClear();
			btnClear();
			mage.addEventListener(MouseEvent.MOUSE_UP, battleStart);
			mage.gotoAndStop(2);
			addChild(mage);
			warr.addEventListener(MouseEvent.MOUSE_UP, battleStart);
			warr.gotoAndStop(2);
			addChild(warr);
			roge.addEventListener(MouseEvent.MOUSE_UP, battleStart);
			roge.gotoAndStop(2);
			addChild(roge);
			btnMake(350,200,17,"battleStart");
			displayTfSet(null, 19, 3);
		}
		private function bSelect(m:MouseEvent):void {
			removeChild(expBar);
			tfClear();
			btnClear();
			btnMake(450,200,20,"enSelect");
			//btnMake(200,200,19,"tSelect");
			displayTfSet(null, 28, 3);
		}
		private function battleStart(m:MouseEvent=null):void {
			btnClear();
			if (stage.contains(mage) == true) {
				removeChild(mage);
				removeChild(warr);
				removeChild(roge);
			}
			btnMake(650,460,11,"forfit");
			if(newAtkBtn.visible == false){
				newAtkBtn.visible = true;
			}
			newAtkBtn.x = 200;
			newAtkBtn.y = 320;
			newAtkBtn.gotoAndStop(16);
			if(m == null){
				curFoeNum++;
				//kongregate.stats.submit("Kill Streak",curFoeNum);
			} else if(m.target == mage){
				curFoeCls = "MAGE";
				curFoeNum = 0;
			} else if(m.target == warr){
				curFoeCls = "WARR";
				curFoeNum = 0;
			} else if(m.target == roge){
				curFoeCls = "ROGE";
				curFoeNum = 0;
			} else {
				var rnd = Math.ceil(Math.random() * 3);
				if(rnd == 1){
					curFoeCls = "MAGE";
				} else if(rnd == 2){
					curFoeCls = "WARR";
				} else if(rnd == 3){
					curFoeCls = "ROGE";
				}
				curFoeNum = 0;
			}
			enLvl = Math.ceil(((Math.random() * 2)) + plrLvl);
			var numCom1:int = (enLvl + (curFoeNum / 4));
			var i:int = 0;
			//base = ((Math.random() * numCom1) + (enLvl * (mod1 + (curFoeNum * mod2))) - (numCom1 / 2) + mod3);
			if(curFoeCls == "MAGE"){
				if(curFoeNum == 0) {
					enSet = [5,5,6,6,7,7,8,8,9,11,12,13,14,16,16,17,17,20,20,22];
				} else if(curFoeNum == 1){
					enSet = [5,5,6,6,7,7,8,8,9,11,12,13,14,16,16,17,17,20,20,22,22,33,36,42,43];
				} else if(curFoeNum == 2){
					enSet = [5,5,6,6,7,7,8,8,9,11,12,13,14,16,16,17,17,20,20,22,22,28,33,36,42,43,43,45,48];
				} else if(curFoeNum == 3){
					enSet = [5,6,7,8,9,11,12,13,14,16,16,17,17,20,20,22,22,28,33,36,36,40,41,42,42,43,43,45,48,49,((Math.random() * 25) + 25)];
				} else if(curFoeNum == 4){
					enSet = [5,6,7,8,9,11,12,13,14,16,16,17,17,20,20,22,22,28,30,33,36,36,40,41,42,42,43,43,44,45,48,49,((Math.random() * 25) + 25)];
				} else {
					enSet = [5,6,7,8,9,11,12,13,14,16,16,17,17,20,20,22,22,28,30,33,36,36,40,41,42,42,43,43,44,45,48,49,((Math.random() * 25) + 25)];
				}
					enAttack = ((Math.random() * (numCom1 / 2.0)) + (enLvl * (2.0 + (curFoeNum / 2.0))) - (numCom1 / 2) + 6);
					enManaRgn = ((Math.random() * (numCom1 / 5.5)) + (enLvl * (1.6 + (curFoeNum / 5.5))) - (numCom1 / 2) + 6);
					enHealthStat = ((Math.random() * (numCom1 / 1.0)) + (enLvl * (8.0 + (curFoeNum / 1.0))) - (numCom1 / 2) + 85);
					enDmgMod = ((Math.random() * (numCom1 / 15)) + (enLvl * (.02 + (curFoeNum / 15))));// - (numCom1 / 0) + 0);
					retry = .85 + (curFoeNum / 10);
					mainEn.enClassPic.gotoAndStop(4);
			} else if(curFoeCls == "WARR"){
				if(curFoeNum == 0){
					enSet = [3,3,3,4,4,4,6,6,6,10,12,13,13,14,14,18,18,19,19,21];
				} else if(curFoeNum == 1){
					enSet = [3,3,3,4,4,4,6,6,6,10,12,13,13,14,14,18,18,19,19,21,25,29,34];
				} else if(curFoeNum == 2){
					enSet = [3,3,3,4,4,4,6,6,6,10,12,13,13,14,14,18,18,19,19,21,25,29,29,30,33,34,34];
				} else if(curFoeNum == 3){
					enSet = [3,3,4,4,6,6,10,12,13,14,18,19,19,21,25,29,29,29,30,30,33,34,34,37,38,46,((Math.random() * 25) + 25)];
				} else if(curFoeNum == 4){
					enSet = [3,3,4,4,6,6,10,12,13,14,18,19,19,21,25,29,29,29,30,30,31,33,34,34,37,38,38,39,46,((Math.random() * 25) + 25)];
				} else {
					enSet = [3,3,4,4,6,6,10,12,13,14,18,19,19,21,25,29,29,29,30,30,31,33,34,34,37,38,38,39,46,((Math.random() * 25) + 25)];
				}
					enAttack = ((Math.random() * (numCom1 / 1.4)) + (enLvl * (3 + (curFoeNum / 1.4))) - (numCom1 / 2) + 10);
					enManaRgn = ((Math.random() * (numCom1 / 8)) + (enLvl * (.3 + (curFoeNum / 8))) - (numCom1 / 2) + 4);
					enHealthStat = ((Math.random() * numCom1 / 1.0) + (enLvl * (12 + (curFoeNum / 1.0))) - (numCom1 / 2) + 100);
					enDmgMod = ((Math.random() * (numCom1 / 20)) + (enLvl * (.01 + (curFoeNum / 20))));// - (numCom1 / 2) + 0);;
					retry = .6 + (curFoeNum / 50);
					mainEn.enClassPic.gotoAndStop(5);
			} else if(curFoeCls == "ROGE"){
				if(curFoeNum == 0){
					enSet = [3,3,4,4,8,8,10,10,10,12,12,13,13,13,14,15,15,15,20,22];
				} else if(curFoeNum >= 1){
					enSet = [3,3,4,4,8,8,10,10,10,12,12,13,13,13,14,15,15,15,20,22];
					var j:int;
					var k:int;
					for(j = 0; j < enSet.length; j++){
						k = ((Math.random() * 49) + 1);
						enSet[j] = k;
					}
				} else {
					enSet = [3,3,4,4,8,8,10,10,10,12,12,13,13,13,14,15,15,15,20,22];
				}
					enAttack = ((Math.random() * (numCom1 / 1.6)) + (enLvl * (2.6 + (curFoeNum / 1.6))) - (numCom1 / 2) + 8);
					enManaRgn = ((Math.random() * (numCom1 / 5.5)) + (enLvl * (1.2 + (curFoeNum / 5.5))) - (numCom1 / 2) + 4.5);
					enHealthStat = ((Math.random() * (numCom1 / 1)) + (enLvl * (10.5 + (curFoeNum / 1))) - (numCom1 / 2) + 90);
					enDmgMod = ((Math.random() * (numCom1 / 16.5)) + (enLvl * (.015 + (curFoeNum / 16.5))));// - (numCom1 / 2) + 0);;
					retry = .5 + (curFoeNum / 30);
					mainEn.enClassPic.gotoAndStop(6);
			}
			enDeck = new Array(enSet.length);
			i = 0;
			while (i < enSet.length) {
				var ind:int = Math.floor(Math.random() * (enSet.length));
				if (enDeck[ind] == undefined) {
					enDeck[ind] = enSet[i];
					i++;
				}
			}
			if(retry >= 1){
				retry = .99;
			}
			enHealth = enHealthStat;
			bounty = (enLvl * 7) + 50;
			attack = atkStat;
			atkCount = 1;
			plrDmgBoost = 0;
			enDmgBoost = 0;
			enAtkCount = 1;
			countDown = -1;
			enCountDown = -1;
			mana = manaRgn + 10;
			/*for (i = 0; i <= 30; i++) {
				plrLvl = i;
				enLvl = Math.ceil((Math.random() * plrLvl) + ((plrLvl/2) + (curFoeNum/2)));
				trace("Lvl "+enLvl);
				trace("Attack " + (Math.floor((enAttack = 1 + (enLvl / 4)))));
				trace("Health " + (Math.floor((enHealth = (enLvl * 2) + 8))));
				trace("Mana " + (enManaRgn = 1 + (.1 * (enLvl / 3))));
				trace("----");
			}*/
			enAttackStat = enAttack;
			enMana = enManaRgn + 10;
			health = healthStat;
			enStuned = false;
			enCursed = false;
			enSil = false;
			plrStuned = false;
			plrCursed = false;
			plrSil = false;
			plrTrnHid = 0;
			plrHid = 0;
			plrTrnSil = 0;
			enTrnHid = 0;
			enTrnSil = 0;
			enHid = 0;
			deckMake();
			inPlayCards(cardPlay);
			updateCardDisp();
			addChild(main);
			addChild(mainEn);
			mainEn.enStnIcn.visible = false;
			main.plrStnIcn.visible = false;
			mainEn.enPsnIcn.visible = false;
			main.plrPsnIcn.visible = false;
			main.plrHidIcn.visible = false;
			mainEn.enHidIcn.visible = false;
			main.plrSilIcn.visible = false;
			mainEn.enSilIcn.visible = false;
			main.classPic.gotoAndStop(classNum);
			turnStage = 0;
			turn = 0;
			displayTfSet(null, 3, 3);
		}
		private function forfit(e:Event):void {
			turnStage = 6;
			newAtkBtn.gotoAndStop(14);
			btnClear();
			displayTfSet(null, 17, 3);
			removeChild(main);
			removeChild(mainEn);
			clearCards();
		}
		private function deckMake():void {
			deckGame = new Array(deck.length);
			var i:int = 0;
			while (i < deckGame.length) {
				var ind:int = Math.floor(Math.random() * (deck.length));
				if (deckGame[ind] == undefined) {
					deckGame[ind] = deck[i];
					i++;
				}
			}
		}
		private function inPlayCards(reps:int):void {
			var i:int = 0;
			while (i < reps) {
				newCard = new Card();
				newCard.x = i * 80 + 100;
				newCard.y = 390;
				newCard.type = deckGame[0];
				deckGame.splice(0, 1);
				newCard.gotoAndStop(newCard.type);
				newCard.addEventListener(MouseEvent.MOUSE_UP, cardUse);
				newCard.addEventListener(MouseEvent.ROLL_OVER, displayTfSet);
				newCard.addEventListener(MouseEvent.ROLL_OUT, displayClear);
				inPlay.push(newCard);
				addChild(newCard);
				i++;
			}
		}
		private function deckView(m:MouseEvent):void {
			removeChild(expBar);
			tfClear();
			newAtkBtn.visible = true;
			newAtkBtn.gotoAndStop(15);
			newAtkBtn.x = 600;
			newAtkBtn.y = 470;
			btnClear();
			tfCreator(45, 100, "Deck:");
			tfCreator(45, 480, "Click a spell to transfer it, shift-click to sell");
			tfCreator(45, (Math.floor(((deck.length - 1) / 10)) * 55 + 178), "Storage:");
			deck.sort(Array.NUMERIC);
			side.sort(Array.NUMERIC);
			var i:int = 0;
			var row:int = 0;
			var rank:int = 0;
			while (i < (deck.length)) {
				if (rank > 9) {
					row++;
					rank = 0;
				}
				newCard = new Card();
				newCard.x = (rank * 60) + 60;
				newCard.y = (55 * row) + 150;
				newCard.type = deck[i];
				newCard.gotoAndStop(newCard.type);
				newCard.addEventListener(MouseEvent.MOUSE_UP, cardPick);
				newCard.addEventListener(MouseEvent.ROLL_OVER, displayTfSet);
				newCard.addEventListener(MouseEvent.ROLL_OUT, displayClear);
				inPlay.push(newCard);
				addChild(newCard);
				i++;
				rank++;
			}
			i = 0;
			rank = 0;
			while (i < (side.length)) {
				if (rank > 9) {
					row++;
					rank = 0;
				}
				newCard = new Card();
				newCard.x = (rank * 60) + 60;
				newCard.y = (55 * row) + 220;
				newCard.type = side[i];
				newCard.gotoAndStop(newCard.type);
				newCard.addEventListener(MouseEvent.MOUSE_UP, cardPick);
				newCard.addEventListener(MouseEvent.ROLL_OVER, displayTfSet);
				newCard.addEventListener(MouseEvent.ROLL_OUT, displayClear);
				inPlay.push(newCard);
				addChild(newCard);
				i++;
				rank++;
			}
			turnStage = 7;
		}
		private function cardPick(m:MouseEvent) {
			var picked:Object;
			picked = m.target;
			picked.removeEventListener(MouseEvent.ROLL_OUT, displayClear);
			if (m.shiftKey == false) {
				if (inPlay.indexOf(picked) < deck.length && deck.length > deckMin) {
					deck.splice(inPlay.indexOf(picked), 1);
					side.push(picked.type);
					atkBtnPress(null);
					deck.sort(Array.NUMERIC);
					side.sort(Array.NUMERIC);
					deckView(null);
				} else {
					var seatyp:int = side[(inPlay.indexOf(picked) - deck.length)];
					var i:int;
					for (i=0; i<deck.length-1; i++) {
						if (deck[i] == seatyp) {
							if (deck[i + 5] != seatyp) {
								if (inPlay.indexOf(picked) > deck.length - 1 && deck.length < deckMax) {
									side.splice((inPlay.indexOf(picked) - deck.length), 1);
									deck.push(picked.type);
									atkBtnPress(null);
									deck.sort(Array.NUMERIC);
									side.sort(Array.NUMERIC);
									deckView(null);
								} else {
									if (deck.length >= deckMax) {
										displayTfSet(null, 13, 3);
									} else {
										displayTfSet(null, 14, 3);
									}
								}
								break;
							} else {
								displayTfSet(null, 15, 3);
								break;
							}
						} else if (i>=deck.length-2) {
							if (inPlay.indexOf(picked) > deck.length - 1 && deck.length < deckMax) {
								side.splice((inPlay.indexOf(picked) - deck.length), 1);
								deck.push(picked.type);
								atkBtnPress(null);
								deck.sort(Array.NUMERIC);
								side.sort(Array.NUMERIC);
								deckView(null);
							} else {
								if (deck.length >= deckMax) {
									displayTfSet(null, 13, 3);
								} else {
									displayTfSet(null, 14, 3);
								}
							}
						}
					}
				}
			} else {
				if (inPlay.indexOf(picked) > deck.length - 1) {
					giveGold((((price[side[(inPlay.indexOf(picked) - deck.length)]])/ 2) + 5));
					side.splice((inPlay.indexOf(picked) - deck.length), 1);
					atkBtnPress(null);
					deck.sort(Array.NUMERIC);
					deckView(null);
				} else if (inPlay.indexOf(picked) < deck.length && deck.length > deckMin) {
					giveGold((((price[deck[(inPlay.indexOf(picked))]])/ 2) + 5));
					deck.splice(inPlay.indexOf(picked), 1);
					atkBtnPress(null);
					side.sort(Array.NUMERIC);
					deckView(null);
				} else {
					displayTfSet(null, 14, 3);
				}
			}

		}
		private function store(m:MouseEvent):void {
			removeChild(expBar);
			enHealth = 1;
			tfClear();
			newAtkBtn.visible = true;
			newAtkBtn.gotoAndStop(15);
			newAtkBtn.x = 600;
			newAtkBtn.y = 470;
			btnClear();
			var i:int;
			var row:int = 0;
			var rank:int = 0;
			i = 2;
			while (i <= (price.length - 1)) {
				if (rank > 9) {
					row++;
					rank = 0;
				}
				newCard = new Card();
				newCard.x = (rank * 60) + 60;
				newCard.y = (70 * row) + 127;
				newCard.type = i;
				newCard.gotoAndStop(newCard.type);
				newCard.addEventListener(MouseEvent.ROLL_OVER, displayTfSet);
				newCard.addEventListener(MouseEvent.ROLL_OVER, buldge);
				newCard.addEventListener(MouseEvent.ROLL_OUT, displayClear);
				newCard.addEventListener(MouseEvent.ROLL_OUT, buldge);
				newCard.addEventListener(MouseEvent.MOUSE_UP, buy);
				inPlay.push(newCard);
				addChild(newCard);
				i++;
				rank++;
			}
			turnStage = 7;
		}
		private function cardFade():void {
			var i:int;
			for (i=0; i<inPlay.length; i++) {
				if (inPlay[i].alpha == 1) {
					inPlay[i].alpha = .45;
				} else {
					inPlay[i].alpha = 1;
				}
			}
		}
		private function classInfo(m:MouseEvent):void {
			if(m.target == mage){
				displayTf.text = (["Mage: Powerful wielder of magic.",
								  "Strong spells and high mana",
								  "regenaration, low health and attack",
								  ]).join("\n");
			} else if(m.target == warr){
				displayTf.text = (["Warrior: Master of the blade.",
								  "Strong Attack and high health,",
								  "Weak spells and low mana regeration",
								  ]).join("\n");
			} else if(m.target == roge){
				displayTf.text = (["Rogue: Stealthy assassin of the night.",
								  "Varied spells and medium mana",
								  "regenaration, moderate health and attack.",
								  ]).join("\n");
			}
		}
		private function displayTfSet(m:MouseEvent = null, card:int = 0, group:int = 1):void {
			if (group == 1) {
				if (m != null) {
					displayTf.text = cardEffectText(m.target.type);
				} else {
					displayTf.text = enemyUseDisplayText(card);
				}
			} else if (group == 2) {
				displayTf.text = cardText(card);
			} else if (group == 3) {
				if (card == 0) {
					displayTf.text = (["You Won!",
					   "You Got " + bounty + " Gold!",
					   ]).join("\n");
				} else if (card == 1) {
					displayTf.text = (["You Lost!",
					    "You Got " + Math.floor(((bounty/2) - 3)) + " Gold",
					   ]).join("\n");
				} else if (card == 2) {
					displayTf.text = "You got a spell!";
				} else if (card == 3) {
					displayTf.text = "BATTLE!";
				} else if (card == 4) {
					displayTf.text = "Proceed?";
				} else if (card == 5) {
					displayTf.text = "Welcome to Mage Arena!";
				} else if (card == 6) {
					displayTf.text = "Spell bought!";
				} else if (card == 7) {
					displayTf.text = "Not enought gold!";
				} else if (card == 8) {
					displayTf.text = "You cannnot hold more spells!";
				} else if (card == 9) {
					displayTf.text = "Foe was hurt by curse!";
				} else if (card == 10) {
					displayTf.text = "You were hurt by curse!";
				} else if (card == 11) {
					displayTf.text = "Foe is stunned!";
				} else if (card == 12) {
					displayTf.text = "You are stunned!";
				} else if (card == 13) {
					displayTf.text = (["Your deck is full, more spaces",
					"avaliable at higher levels",
					]).join("\n");
				} else if (card == 14) {
					displayTf.text = (["You can not have fewer spells",
					"in your deck",
					]).join("\n");
				} else if (card == 15) {
					displayTf.text = (["You can not have more than six of",
					"the same spell in your deck",
					]).join("\n");
				} else if (card == 16) {
					displayTf.text = (["LEVEL UP!",
					"Select what to increase",
					]).join("\n");
				} else if (card == 17) {
					displayTf.text = (["You forfited...",
					]).join("\n");
				} else if (card == 18) {
					displayTf.text = (["Select your class",
					]).join("\n");
				} else if (card == 19) {
					displayTf.text = (["Select your foe",
					]).join("\n");
				} else if (card == 20) {
					displayTf.text = (["WARNING! Will Erase Your Old Save!",
					]).join("\n");
				} else if (card == 21) {
					displayTf.text = (["Foe missed!",
					]).join("\n");
				} else if (card == 22) {
					displayTf.text = (["You missed!",
					]).join("\n");
				} else if (card == 23) {
					displayTf.text = (["Confirm class: Mage",
					"Will override any old Mage save",
					]).join("\n");
				} else if (card == 24) {
					displayTf.text = (["Confirm class: Warrior",
					"Will override any old Warrior save",
					]).join("\n");
				} else if (card == 25) {
					displayTf.text = (["Confirm class: Rogue",
					"Will override any old Rogue save",
					]).join("\n");
				} else if (card == 26) {
					displayTf.text = (["You are silenced",
					]).join("\n");
				} else if (card == 27) {
					displayTf.text = (["Foe is silenced",
					]).join("\n");
				} else if (card == 28) {
					displayTf.text = (["Select your battle type",
					]).join("\n");
				}
			}
		}
		private function displayClear(m:MouseEvent=null):void {
			if (enHealth > 0) {
				displayTf.text = "";
			}
		}
		private function cardText(type:int):String {
			switch (type - 1) {
				case 0 :
					return ("YOU WIN!");
					break;
				case 1 :
					return ("Treasure");
					break;
				case 2 :
					return ("Great Strength");
					break;
				case 3 :
					return ("Weaken");
					break;
				case 4 :
					return ("Cure");
					break;
				case 5 :
					return ("Heal");
					break;
				case 6 :
					return ("Freeze");
					break;
				case 7 :
					return ("Thunderbolt");
					break;
				case 8 :
					return ("Aqua Blast");
					break;
				case 9 :
					return ("Speed");
					break;
				case 10 :
					return ("Acid");
					break;
				case 11 :
					return ("Forbidden Ritual");
					break;
				case 12 :
					return ("Stun");
					break;
				case 13 :
					return ("Silence");
					break;
				case 14 :
					return ("Stealth");
					break;
				case 15 :
					return ("Health Rush");
					break;
				case 16 :
					return ("Mana Blast");
					break;
				case 17 :
					return ("Enchant");
					break;
				case 18 :
					return ("Resist");
					break;
				case 19 :
					return ("Mana Surge");
					break;
				case 20 :
					return ("Rush");
					break;
				case 21 :
					return ("Fireball");
					break;
				case 22 :
					return ("Life Drain");
					break;
				case 23 :
					return ("Mage Beam");
					break;
				case 24 :
					return ("Great Heal");
					break;
				case 25 :
					return ("Antidote");
					break;
				case 26 :
					return ("Darkness");
					break;
				case 27 :
					return ("Purge");
					break;
				case 28 :
					return ("Mystic Might");
					break;
				case 29 :
					return ("Mind Crush");
					break;
				case 30 :
					return ("Ninja");
					break;
				case 31 :
					return ("Replenish");
					break;
				case 32 :
					return ("Bless");
					break;
				case 33 :
					return ("Endure");
					break;
				case 34 :
					return ("Extremesped");
					break;
				case 35 :
					return ("Blizzard");
					break;
				case 36 :
					return ("Doom");
					break;
				case 37 :
					return ("Comatose");
					break;
				case 38 :
					return ("Mute");
					break;
				case 39 :
					return ("Great Mana Surge");
					break;
				case 40 :
					return ("Larinek");
					break;
				case 41 :
					return ("Inferno");
					break;
				case 42 :
					return ("Electrocute");
					break;
				case 43 :
					return ("Time Bomb");
					break;
				case 44 :
					return ("Ultra Heal");
					break;
				case 45 :
					return ("Explosion");
					break;
				case 46 :
					return ("Countdown");
					break;
				case 47 :
					return ("Savior");
					break;
				case 48 :
					return ("Destroyer")
					break;
				case 49 :
					return ("Rexlarinek");
					break;
				case 50 :
					return ("Etru");
					break;//
				default :
					return ("?????");
			}
		}
		private function cardEffectText(type:int):String {
			switch (type - 1) {
				case -1 :
					return ("Cast a spell or attack");
					break;
				case 0 :
					return ("Spell used");
					break;
				case 1 :
					return ([cardText(type),
					"Gives 50 gold",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
					break;
				case 2 :
					return ([cardText(type),
					"Increases attack",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
					break;
				case 3 :
					return ([cardText(type),
					"Reduces foes attack",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
					break;
				case 4 :
					return ([cardText(type),
					"Cures effects and heals a little",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
					break;
				case 5 :
					return ([cardText(type),
					"Restores health",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
					break;
				case 6 :
					return ([cardText(type),
					"Hurts foe and makes them visible",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
					break;
				case 7 :
					return ([cardText(type),
					"Blast foe for " + (Math.floor(20 * plrDmgMod)) + " damage",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
					break;
				case 8 :
					return ([cardText(type),
					"Can deal " + (Math.floor(50 * plrDmgMod)) + " damage, but might miss",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
					break;
				case 9 :
					return ([cardText(type),
					"Attack twice",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
					break;
				case 10 :
					return ([cardText(type),
					"Hurts and weakens foe",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
					break;
				case 11 :
					return ([cardText(type),
					"Curses foe",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
					break;
				case 12 :
					return ([cardText(type),
					"Stuns foe",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
					break;
				case 13 :
					return ([cardText(type),
					"Prevents foe from casting",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
					break;
				case 14 :
					return ([cardText(type),
					"Makes you 30% stealthy for 3 turns",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
					break;
				case 15 :
					return ([cardText(type),
					"Heals equal to mana, drains all mana",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
					break;
				case 16 :
					return ([cardText(type),
					"Converts mana to damage",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
					break;
				case 17 :
					return ([cardText(type),
					"Increases all dmage dealt this turn by 5",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
					break;
				case 18 :
					return ([cardText(type),
					"Reduces all dmage taken this turn by 5",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
					break;
				case 19 :
					return ([cardText(type),
					"Increases mana",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
					break;
				case 20 :
					return ([cardText(type),
					"Gain an additional attack",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
					break;
				case 21 :
					return ([cardText(type),
					"Burns foe, weaking and wounding them",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
					break;
				case 22 :
					return ([cardText(type),
					"Steals health",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
					break;
				case 23 :
					return ([cardText(type),
					"Can grealty hurt foe, but might miss",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
					break;
				case 24 :
					return ([cardText(type),
					"Restores lots of health",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
					break;
				case 25 :
					return ([cardText(type),
					"Cures effects and heals",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
					break;
				case 26 :
					return ([cardText(type),
					"Makes you 50% stealthy for 5 turns",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
					break;
				case 27 :
					return ([cardText(type),
					"Destroyes 20 of foes mana",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
					break;
				case 28 :
					return ([cardText(type),
					"Greatly raises your attack",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
					break;
				case 29 :
					return ([cardText(type),
					"Greatly lowers foes attack",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
					break;
				case 30 :
					return ([cardText(type),
					"Makes you 75% stealthy for 3 turns",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
					break;
				case 31 :
					return ([cardText(type),
					"Recharges 2 spells",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
					break;
				case 32 :
					return ([cardText(type),
					"Increases all dmage dealt this turn by 10",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
					break;
				case 33 :
					return ([cardText(type),
					"Reduces all dmage taken this turn by 10",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
					break;
				case 34 :
					return ([cardText(type),
					"Attack thrice",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
					break;
				case 35 :
					return ([cardText(type),
					"Hurts and stuns foe, makes them visible",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
					break;
				case 36 :
					return ([cardText(type),
					"Dooms foe",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
					break;
				case 37 :
					return ([cardText(type),
					"Stuns for a while",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
					break;
				case 38 :
					return ([cardText(type),
					"Stops foe casting for a while",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
					break;
				case 39 :
					return ([cardText(type),
					"Increases mana by 40",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
				case 40 :
					return ([cardText(type),
					"Stuns and curses foe",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
					break;
				case 41 :
					return ([cardText(type),
					"Deals lots of damge, and weakens foe",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
					break;
				case 42 :
					return ([cardText(type),
					"Deals " + (Math.floor(65 * plrDmgMod)) + " damage",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
					break;
				case 43 :
					return ([cardText(type),
					"Deals damge equal to the turn number x10",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
					break;
				case 44 :
					return ([cardText(type),
					"Heals equal to the turn number x10",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
					break;
				case 45 :
					return ([cardText(type),
					"Deals 80 damage to everyone",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
					break;
				case 46 :
					return ([cardText(type),
					"Curses foe forever",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
					break;
				case 47 :
					return ([cardText(type),
					"Bestoes tremendous power",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
					break;
				case 48 :
					return ([cardText(type),
					"Ruins foe",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
					break;
				case 49 :
					return ([cardText(type),
					"Stuns, curses, and silences",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
					break;
				case 50 :
					return ([cardText(type),
					"Etru nom ikalri sel don minsiu",
					"Cost: " + costs[type - 1] + " Mana",
					]).join("\n");
					break;
				default :
					return (["??????",
					]).join("\n");
			}
		}
		private function enemyUseDisplayText(type:int):String {
			switch (type - 1) {
				case -1 :
					return ("Cast a spell or attack");
					break;
				case 0 :
					return ("Foe did not cast!");
					break;
				case 1 :
					return ("Foe did not cast!");
					break;
				case 2 :
					return ("Foe rasied attack!");
					break;
				case 3 :
					return ("You were weakend!");
					break;
				case 4 :
					return ("Foe was restored!");
					break;
				case 5 :
					return ("Foe healed!");
					break;
				case 6 :
					return ("You were frozen!");
					break;
				case 7 :
					return ("You were stuck by a thunderbolt!");
					break;
				case 8 :
					return ("Foe blasted water!");
					break;
				case 9 :
					return ("Foe will attack twice!");
					break;
				case 10 :
					return ("You were burned by acid!");
					break;
				case 11 :
					return ("You were cursed!");
					break;
				case 12:
					return ("You were stuned!");
					break;
				case 13 :
					return ("You were silenced!");
					break;
				case 14 :
					return ("Foe hid!");
					break;
				case 15 :
					return ("Foe converted mana to health!");
					break;
				case 16 :
					return ("Foe blasted mana!");
					break;
				case 17 :
					return ("Foe became enchanted!");
					break;
				case 18 :
					return ("Foe became resistant!");
					break;
				case 19 :
					return ("Foe boosted mana!");
					break;
				case 20 :
					return ("Foe is speeding up!");
					break;
				case 21 :
					return ("You got flamed!");
					break;
				case 22 :
					return ("Enemy stole health!");
					break;
				case 23 :
					return ("You were hit by mystic power!");
					break;
				case 24 :
					return ("Foe regained health!");
					break;
				case 25 :
					return ("Foe was regenerated!");
					break;
				case 26 :
					return ("Foe was shrouded in darkness!");
					break;
				case 27 :
					return ("You were purged!");
					break;
				case 28 :
					return ("Foe was greatly strengthened!");
					break;
				case 29 :
					return ("You were greatly weskened!");
					break;
				case 30 :
					return ("Foe cloaked!");
					break;
				case 31 :
					return ("Foe did not cast!");
					break;
				case 32 :
					return ("Foe was blessed!");
					break;
				case 33 :
					return ("Foe will endure!");
					break;
				case 34:
					return ("Foe became very fast!");
					break;
				case 35 :
					return ("Foe caused a blizzard!");
					break;
				case 36 :
					return ("You are doomed!");
					break;
				case 37:
					return ("Foe put you in a comatose!");
					break;
				case 38 :
					return ("You were muted!");
					break;
				case 39 :
					return ("Foe gatherd lots of power!");
					break;
				case 40 :
					return ("You have been stuned and cursed!");
					break;
				case 41 :
					return ("You were incinerated!");
					break;
				case 42:
					return ("You were electrocuted!");
					break;
				case 43 :
					return ("Foe used a time bomb!");
					break;
				case 44:
					return ("Foe regained " + (turn * 10) + " health!");
					break;
				case 45:
					return ("Foe caused a huge explosion!");
					break;
				case 46:
					return ("There is a countdown!");
					break;
				case 47:
					return ("Foe was saved!");
					break;
				case 48:
					return ("You were ruined!");
					break;
				case 49:
					return ("You have been stuned, cursed, and silenced!");
					break;
				case 50:
					return ("Etru...");
					break;
				default :
					return ("??????");
			}
		}
		private function cardUse(m:MouseEvent):void {
			if (animating == null && turnStage == 0) {
				if(plrSil == false){
					var card:Object = m.target;
					if (mana >= costs[card.type - 1]) {
						animating = card;
						var eff:int = card.type - 1;
						if (eff == 1) {
							giveGold(50);
						} else if (eff == 2) {
							attack +=  10
						} else if (eff == 3){
							enAttack -= 10;
						} else if (eff == 4) {
							if(plrCursed == true || plrStuned == true || plrSil == true){
								achivementGet(4);
							} else {
								achivementGet(25);
							}
							plrCursed = false;
							plrTrnCur = 0;
							main.plrPsnIcn.visible = false;
							plrStuned = false;
							plrTrnStn = 0;
							main.plrStnIcn.visible = false;
							plrSil = false;
							plrTrnSil = 0;
							main.plrSilIcn.visible = false;
							dmgDeal(-12, main, "S");
						} else if (eff == 5) {
							dmgDeal(-20, main, "S");
						} else if (eff == 6) {
							if(enHid > 0){
								achivementGet(6);
							}
							enHid = 0;
							enTrnHid = 0;
							mainEn.enHidIcn.visible = false;
							dmgDeal(15, mainEn, "S");
						} else if (eff == 7) {
							dmgDeal(20, mainEn, "S");
							if(enHealth <= 0){
								achivementGet(7);
							}
						} else if (eff == 8) {
							var hit:Number = Math.random();
							if (hit < .65) {
								achivementGet(8);
								dmgDeal(50, mainEn, "S");
							}
						} else if (eff == 9) {
							atkCount = 2;
						} else if (eff == 10) {
							dmgDeal(20, mainEn, "S");
							enAttack -=  5;
							enMana -=  5;
						} else if (eff == 11) {
							statusEffect("CURSE", 3, mainEn);
						} else if (eff == 12) {
							statusEffect("STUN", 1, mainEn);
						} else if (eff == 13) {
							statusEffect("SILENCE", 1, mainEn);
						} else if (eff == 14) {
							statusEffect("HIDE30", 3, main);
						} else if (eff == 15) {
							dmgDeal((mana * -1), main, "P");
							mana = 0;
						} else if (eff == 16) {
							dmgDeal(mana, mainEn, "P");
							if(mana >= 50){
								achivementGet(16);
							}
							mana = 0;
						} else if (eff == 17) {
							plrDmgBoost += (5 * plrDmgMod);
						} else if (eff == 18) {
							enDmgBoost += (-5 * plrDmgMod);
						} else if (eff == 19) {
							mana += 10;
						} else if (eff == 20) {
							atkCount += 1;
						} else if (eff == 21) {
							dmgDeal(20, mainEn, "S");
							enAttack -= 10;
						} else if (eff == 22) {
							dmgDeal(20, mainEn, "S");
							dmgDeal(-20, main, "S");
						} else if (eff == 23) {
							hit = Math.random();
							if (hit < .55) {
								dmgDeal(60, mainEn, "S");
								enMana -=  15;
								statusEffect("STUN", 1, mainEn);
								statusEffect("CURSE", 2, mainEn);
							}
						} else if (eff == 24) {
							dmgDeal(-50, main, "S");
						} else if (eff == 25) {
							if(plrCursed == true || plrStuned == true || plrSil == true){
								achivementGet(4);
							} else {
								achivementGet(25);
							}
							plrCursed = false;
							plrTrnCur = 0;
							main.plrPsnIcn.visible = false;
							plrStuned = false;
							plrTrnStn = 0;
							main.plrStnIcn.visible = false;
							plrSil = false;
							plrTrnSil = 0;
							main.plrSilIcn.visible = false;
							dmgDeal(-30, main, "S");
						} else if (eff == 26) {
							statusEffect("HIDE50", 5, main);
						} else if (eff == 27) {
							enMana -= 20;
						} else if (eff == 28) {
							attack += 35;
						} else if (eff == 29) {
							enAttack -= 35;
						} else if (eff == 30) {
							statusEffect("HIDE75", 3, main);
						} else if (eff == 31) {
							drawCard();
							drawCard();
						} else if (eff == 32) {
							plrDmgBoost += (10 * plrDmgMod);
						} else if (eff == 33) {
							enDmgBoost += (-10 * plrDmgMod);
						} else if (eff == 34) {
							atkCount = 3;
						} else if (eff == 35) {
							if(enHid > 0){
								achivementGet(6);
							}
							enHid = 0;
							enTrnHid = 0;
							mainEn.enHidIcn.visible = false;
							dmgDeal(30, mainEn, "S");
						} else if (eff == 36) {
							statusEffect("CURSE", 6, mainEn);
						} else if (eff == 37) {
							statusEffect("STUN", 3, mainEn);
						} else if (eff == 38) {
							statusEffect("SILENCE", 3, mainEn);
						} else if (eff == 39) {
							mana += 40;
						} else if (eff == 40) {
							statusEffect("CURSE", 4, mainEn);
							statusEffect("STUN", 2, mainEn);
						} else if (eff == 41) {
							dmgDeal(40, mainEn, "S");
							enAttack -= 20;
						} else if (eff == 42) {
							dmgDeal(65, mainEn, "S");
							if(enHealth <= 0){
								achivementGet(7);
							}
						} else if (eff == 43) {
							if(turn >= 5){
								achivementGet(43);
							}
							dmgDeal((turn * 10), mainEn, "S");
						} else if (eff == 44) {
							if(health < 10 && (health + (turn * 10)) > healthStat){
								achivementGet(44);
							}
							dmgDeal((turn * -10), main, "S");
						} else if (eff == 45) {
							if(health <= 80 && enHealth <= 80){
								achivementGet(45);
							}
							dmgDeal(80, main, "P");
							dmgDeal(80, mainEn, "S");
						} else if (eff == 46) {
							statusEffect("CURSE", 100, mainEn);
						} else if (eff == 47) {
							statusEffect("HIDE30", 2, main);
							plrCursed = false;
							plrTrnCur = 0;
							main.plrPsnIcn.visible = false;
							plrStuned = false;
							plrTrnStn = 0;
							main.plrStnIcn.visible = false;
							plrSil = false;
							plrTrnSil = 0;
							main.plrSilIcn.visible = false;
							if(health <= enAttack && (health + 35) > enAttack){
								achivementGet(47);
							}
							dmgDeal(-35, main, "S");
							attack += 15;
							plrDmgBoost += 3;
							
						} else if (eff == 48) {
							statusEffect("CURSE", 2, mainEn);
							statusEffect("STUN", 1, mainEn);
							if(enHealth > attack && (enHealth - 35) < attack){
								achivementGet(48);
							}
							dmgDeal(35, mainEn, "S");
							enAttack -= 10;
						} else if (eff == 49) {
							if(mana == 50){
								achivementGet(49);
							}
							statusEffect("CURSE", 6, mainEn);
							statusEffect("STUN", 2, mainEn);
							statusEffect("SILENCE", 1, mainEn);
						} else if (eff == 50) {
							if(enHealth <= (100 + enMana) * plrDmgMod){
								achivementGet(50);
							}
							dmgDeal(-100 - enMana, main, "S");
							dmgDeal(100 + enMana, mainEn, "S");
							enMana = 0;
						}
					if(enAttack < 0){
						enAttack = 0;
					}
					if((attack - atkStat) >= 40){
						achivementGet(32);
					}
					if(enMana < 0){
						enMana = 0;
						achivementGet(27);
					}
					if(enSil == true){
						if(enMana > 30){
							achivementGet(13);
						}
						if(enStuned == true){
							achivementGet(38);
						}
					}
					if(enCursed == true && enStuned == true){
						achivementGet(40);
					}
					if(health > healthStat){
						achivementGet(15);
					}
					if(turn == 10 && health >= 100){
						achivementGet(33);
					}
						mana -= ((costs[card.type - 1]));
						card.removeEventListener(MouseEvent.MOUSE_UP, cardUse);
						if (enHealth > 0) {
							displayTfSet(null, 0, 1);
						}
						updateCardDisp();
					}
				} else {
					displayTfSet(null, 26, 3);
				}
			}
		}
		private function updateCardDisp():void {
			mainEn.stats.text = (["Health: " + enHealth,
			"Attack: " + enAttack,
			"Mana: " + enMana,
			]).join("\n");
			main.stats.text = (["Health: " + health,
			"Attack: " + attack,
			"Mana: " + mana,
			]).join("\n");

		}
		private function turnStart():void {
			turnStage = 0;
			turnFX();
			turn++;
			enAttack = enAttackStat;
			cardFade();
			mana += manaRgn;
			if(mana > 50){
				achivementGet(19);
			}
			enMana += enManaRgn;
			displayTf.text = "It's your turn!";
			newAtkBtn.gotoAndStop(16);
			updateCardDisp();
			if(countDown > 0){
				countDown -= 1;
			} else if(countDown == 0){
				battleWin();
			}
			if(enCountDown > 0){
				enCountDown -= 1;
			} else if(enCountDown == 0){
				battleLose();
			}
		}
		private function turnFX():void {
			if (deckGame.length > 0) {
				for (var i:int = 0; i < (inPlay.length); i++) {
					if (inPlay[i].type == 1) {
						inPlay[i].mouseEnabled = false;
						rotating = inPlay[i];
						break;
					}
				}
			} else {
				achivementGet(31);
			}
		}
		private function drawCard():void {
			if (deckGame.length >= 0) {
				for (var i:int = 0; i < (inPlay.length); i++) {
					if (inPlay[i].type == 1) {
						newCard = new Card();
						newCard.x = inPlay[i].x;
						newCard.y = 390;
						newCard.type = deckGame[0];
						newCard.gotoAndStop(newCard.type);
						newCard.addEventListener(MouseEvent.MOUSE_UP, cardUse);
						newCard.addEventListener(MouseEvent.ROLL_OVER, displayTfSet);
						newCard.addEventListener(MouseEvent.ROLL_OUT, displayClear);
						deckGame.splice(0, 1);
						removeChild(inPlay[i]);
						inPlay.splice(i, 1);
						inPlay.push(newCard);
						addChild(newCard);
						break;
					}
				}
			} else {
				achivementGet(31);
			}
		}
		private function atkBtnPress(m:MouseEvent=null):void {
			if(flashing != null){
				mainEn.alpha = 1;
				main.alpha = 1;
				flashing = null;
				deathCheck();
			}
			if (turnStage == 0 && rotating == null) {
				newAtkBtn.gotoAndStop(14);
				if(attack > 20){
					achivementGet(2);
					if(attack > 100){
						achivementGet(28);
					}
					if((attack - enAttack) >= 50){
						achivementGet(29);
					}
				}
				if(health > 200){
					achivementGet(5);
					if(health > 350){
						achivementGet(24);
						if(health > 500){
							achivementGet(44);
						}
					}
				}
				if((health - enHealth) > 100){
					achivementGet(22);
				}
				if(plrSil == true){
					plrTrnSil -= 1;
					if(plrTrnSil <= 0){
						plrSil = false;
						main.plrSilIcn.visible = false;
					}
				}
				if (plrStuned == false) {
					if(enHid > 0){
						var hideCheck:Number;
						hideCheck = Math.random() * 100;
						if(enHid > hideCheck){
							displayTfSet(null, 22, 3);
						} else {
							displayTf.text = "You dealt " + (attack + plrDmgBoost) + " Damage";
							dmgDeal(attack, mainEn, "P");
							updateCardDisp();
						}
						enTrnHid -= 1;
						if (enTrnHid <= 0) {
							enHid = 0;
							mainEn.enHidIcn.visible = false;
						}
					} else {
						displayTf.text = "You dealt " + (attack + plrDmgBoost) + " Damage";
						dmgDeal(attack, mainEn, "P");
						updateCardDisp();
					}
					if (atkCount <= 1) {
					cardFade();
					attack = atkStat;
					turnStage = 1;
					plrDmgBoost = 0;
					} else {
						achivementGet(9);
						if(atkCount >= 3){
							achivementGet(20);
						}
						atkCount -=  1;
					}
				} else {
					displayTfSet(null, 12, 3);
					attack = atkStat;
					cardFade();
					plrTrnStn -=  1;
					if (plrTrnStn <= 0) {
						plrStuned = false;
						main.plrStnIcn.visible = false;
					}
					turnStage = 1;
					plrDmgBoost = 0;
				}
			} else if (turnStage == 1) {
				endOfTurn();
			} else if (turnStage == 2) {
				enAI();
			} else if (turnStage == 3) {
				eneAttack();
			} else if (turnStage == 4) {
				turnStart();
			} else if (turnStage == 5) {
				endBattleWin();
			} else if (turnStage == 6) {
				if (stage.contains(newCard) == true) {
					removeChild(newCard);
				}
				gotoMain();
			} else if (turnStage == 7) {
				for (var i:int = 0; i < (inPlay.length); i++) {
					removeChild(inPlay[i]);
					inPlay.splice(i, 1);
					i--;
				}
				btnClear();
				gotoMain();
			} else if (turnStage == 8) {
				if (enCursed == true) {
					if(flashing == null){
						displayTfSet(null, 9, 3);
						if(enHealth - (enHealthStat / 10) <= 0){
							achivementGet(11);
						}
						dmgDeal((enHealthStat / 10), mainEn, "P");
						if((((enHealthStat / 10) * plrDmgMod) + plrDmgBoost) >= 30){
							achivementGet(36);
						}
						enTrnCur--;
						if (enTrnCur <= 0) {
							enCursed = false;
							mainEn.enPsnIcn.visible = false;
						}
						turnStage = 3;
					}
				} else {
					eneAttack();
				}
				updateCardDisp();
			} else if (turnStage == 9) {
				if (plrCursed == true) {
					displayTfSet(null, 10, 3);
					dmgDeal((healthStat / 10), main, "P");
					plrTrnCur--;
					if (plrTrnCur <= 0) {
						plrCursed = false;
						main.plrPsnIcn.visible = false;
					}
					turnStage = 4;
				} else {
					turnStart();
				}
				enDmgBoost = 0;
				updateCardDisp();
			} else if (turnStage == 10) {
				if (stage.contains(newCard) == true) {
					removeChild(newCard);
				}
				gotoLvl();
			} else if (turnStage == 11) {
				btnClear();
				gotoMain();
			} else if (turnStage == 12) {
				if (stage.contains(newCard) == true) {
					removeChild(newCard);
				}
				saveGame();
				battleStart();
			}
		}
		private function endOfTurn():void {
			enTurn();
		}
		private function enTurn():void {
			enAI();
			updateCardDisp();
		}
		private function eneAttack():void {
			if (flashing == null) {
				if(enAttack <= 0){
					achivementGet(3);
				}
				if (enStuned == false) {
					if (enAtkCount <= 1) {
						turnStage = 9;
					} else {
						enAtkCount -=  1;
					}
					if(plrHid > 0){
						var hideCheck:Number;
						hideCheck = Math.random() * 100;
						if(plrHid > hideCheck){
							displayTfSet(null, 21, 3);
							achivementGet(14);
							if(enAttack >= health){
								achivementGet(26);
							}
							if(enAttack >= 50){
								achivementGet(30);
							}
						} else {
							displayTf.text = "You took " + (enAttack + enDmgBoost) + " Damage";
							dmgDeal(enAttack, main, "P");
							updateCardDisp();
						}
						plrTrnHid -= 1;
						if (plrTrnHid <= 0) {
							plrHid = 0;
							main.plrHidIcn.visible = false;
						}
					} else {
						displayTf.text = "You took " + (enAttack + enDmgBoost)+ " Damage";
						dmgDeal(enAttack, main, "P");
						updateCardDisp();
					}
				} else {
					displayTfSet(null, 11, 3);
					enTrnStn -=  1;
					enDmgBoost = 0;
					if (enTrnStn <= 0) {
						enStuned = false;
						mainEn.enStnIcn.visible = false;
					}
					if (enAtkCount <= 1) {
						turnStage = 9;
						enDmgBoost = 0;
					} else {
						enAtkCount -=  1;
					}
				}
			}
		}
		private function enAI():void {
			var cardRnd = Math.ceil(Math.random() * enDeck.length - 1);
			var cardUse = enDeck[cardRnd];
			turnStage = 8;
			if(enSil == false){
				if (enMana >= costs[cardUse - 1]) {
						var eff:int = cardUse - 1;
							if (eff == 1) {
								enAI();
							} else if (eff == 2) {
								enAttack +=  10
							} else if (eff == 3){
								attack -= 10;
							} else if (eff == 4) {
								enCursed = false;
								enTrnCur = 0;
								mainEn.enPsnIcn.visible = false;
								enStuned = false;
								enTrnStn = 0;
								mainEn.enStnIcn.visible = false;
								enSil = false;
								enTrnSil = 0;
								mainEn.enSilIcn.visible = false;
								dmgDeal(-12, mainEn, "S");
							} else if (eff == 5) {
								dmgDeal(-20, mainEn, "S");
							} else if (eff == 6) {
								plrHid = 0;
								plrTrnHid = 0;
								main.plrHidIcn.visible = false;
								dmgDeal(15, main, "S");
							} else if (eff == 7) {
								dmgDeal(20, main, "S");
							} else if (eff == 8) {
								var hit:Number = Math.random();
								if (hit < .65) {
									dmgDeal(50, main, "S");
								}
							} else if (eff == 9) {
								enAtkCount = 2;
							} else if (eff == 10) {
								dmgDeal(20, main, "S");
								attack -=  5;
								mana -=  5;
							} else if (eff == 11) {
								statusEffect("CURSE", 3, main);
							} else if (eff == 12) {
								statusEffect("STUN", 1, main);
							} else if (eff == 13) {
								statusEffect("SILENCE", 1, main);
							} else if (eff == 14) {
								statusEffect("HIDE30", 3, mainEn);
							} else if (eff == 15) {
								dmgDeal((enMana * -1), mainEn, "P");
								enMana = 0;
							} else if (eff == 16) {
								dmgDeal(enMana, main, "P");
								enMana = 0;
							} else if (eff == 17) {
								enDmgBoost += (5 * enDmgMod);
							} else if (eff == 18) {
								plrDmgBoost += (-5 * enDmgMod);
							} else if (eff == 19) {
								enMana += 10;
							} else if (eff == 20) {
								enAtkCount += 1;
							} else if (eff == 21) {
								dmgDeal(20, main, "S");
								attack -= 10;
							} else if (eff == 22) {
								dmgDeal(-20, mainEn, "S");
								dmgDeal(20, main, "S");
							} else if (eff == 23) {
								hit = Math.random();
								if (hit < .55) {
									dmgDeal(60, main, "S");
									mana -=  15;
									statusEffect("STUN", 1, main);
									statusEffect("CURSE", 2, main);
								}
							} else if (eff == 24) {
								dmgDeal(-50, mainEn, "S");
							} else if (eff == 25) {
								enCursed = false;
								enTrnCur = 0;
								mainEn.enPsnIcn.visible = false;
								enStuned = false;
								enTrnStn = 0;
								mainEn.enStnIcn.visible = false;
								enSil = false;
								enTrnSil = 0;
								mainEn.enSilIcn.visible = false;
								dmgDeal(-30, mainEn, "S");
							} else if (eff == 26) {
								statusEffect("HIDE50", 5, mainEn);
							} else if (eff == 27) {
								mana -= 20;
							} else if (eff == 28) {
								enAttack += 35;
							} else if (eff == 29) {
								attack -= 35;
							} else if (eff == 30) {
								statusEffect("HIDE75", 3, mainEn);
							} else if (eff == 31) {
								enAI();
							} else if (eff == 32) {
								enDmgBoost += (10 * enDmgMod);
							} else if (eff == 33) {
								plrDmgBoost += (-10 * enDmgMod);
							} else if (eff == 34) {
								enAtkCount = 3;
							} else if (eff == 35) {
								plrHid = 0;
								plrTrnHid = 0;
								main.plrHidIcn.visible = false;
								dmgDeal(30, main, "S");
							} else if (eff == 36) {
								statusEffect("CURSE", 6, main);
							} else if (eff == 37) {
								statusEffect("STUN", 3, main);
							} else if (eff == 38) {
								statusEffect("SILENCE", 3, main);
							} else if (eff == 39) {
								enMana += 40;
							} else if (eff == 40) {
								statusEffect("CURSE", 4, main);
								statusEffect("STUN", 2, main);
							} else if (eff == 41) {
								dmgDeal(40, main, "S");
								attack -= 20;
							} else if (eff == 42) {
								dmgDeal(65, main, "S");
							} else if (eff == 43) {
								dmgDeal((turn * 10), main, "S");
							} else if (eff == 44) {
								dmgDeal((turn * -10), mainEn, "S");
							} else if (eff == 45) {
								dmgDeal(80, mainEn, "P");
								dmgDeal(80, main, "S");
							} else if (eff == 46) {
								statusEffect("CURSE", 100, main);
							} else if (eff == 47) {
								statusEffect("HIDE30", 2, mainEn);
								enCursed = false;
								enTrnCur = 0;
								mainEn.enPsnIcn.visible = false;
								enStuned = false;
								enTrnStn = 0;
								mainEn.enStnIcn.visible = false;
								enSil = false;
								enTrnSil = 0;
								mainEn.enSilIcn.visible = false;
								dmgDeal(-35, mainEn, "S");
								enAttack += 15;
								enDmgBoost += 3;
							} else if (eff == 48) {
								statusEffect("CURSE", 3, main);
								statusEffect("STUN", 1, main);
								dmgDeal(35, main, "S");
								attack -= 10;
							} else if (eff == 49) {
								statusEffect("CURSE", 6, main);
								statusEffect("STUN", 2, main);
								statusEffect("SILENCE", 1, main);
							} else if (eff == 50) {
								dmgDeal(100 + mana, main, "S");
								dmgDeal(-100 - mana, mainEn, "S");
								mana = 0;
							}
					if(attack < 0){
						attack = 0;
					}
					if(mana < 0){
						mana = 0;
					} else if(mana > 50){
						achivementGet(19);
					}
					if(enStuned == true){
						if(enAttack > enAttackStat){
							achivementGet(12);
						}
					}
					displayTfSet(null, cardUse, 1);
					enMana -= (costs[cardUse - 1]);
					enDeck.splice(cardRnd, 1);
					updateCardDisp();
					if(mana > 20){
						if (Math.random() < (retry / 2)) {
							turnStage = 2;
						}
					} else {
						turnStage = 8;
					}
				} else {
					if (Math.random() < retry) {
						enAI();
					} else {
						//displayTfSet(null, 1, 1);
						atkBtnPress(null);
					}
					
				}
			} else {
					displayTfSet(null, 27, 3);
					enTrnSil -= 1;
					if(enTrnSil <= 0){
						enSil = false;
						mainEn.enSilIcn.visible = false;
					}
				}
		}
		private function buldge(m:MouseEvent):void {
			var card:Object = m.target;
			if (card.scaleX == 1) {
				card.scaleX = 1.2;
				card.scaleY = 1.2;
				var format:TextFormat = new TextFormat();
				storeTf = new TextField();
				format.size = 14;
				format.color = 0x000000//0x443E8C;
				format.font = "Copperplate Gothic Bold";
				storeTf.defaultTextFormat = format;
				storeTf.selectable = false;
				storeTf.text = (["Price: " + price[card.type],
				"Gold: " + gold,
				"Owned: " + owned(card),
				]).join("\n");
				storeTf.width = 300;
				storeTf.x = 627;
				storeTf.y = 100;
				storeTf.setTextFormat(format);
				storeTf.mouseEnabled = false;
				addChild(storeTf);
			} else if (card.scaleX == 1.2) {
				card.scaleX = 1;
				card.scaleY = 1;
				removeChild(storeTf);
			}

		}
		private function owned(card:Object):int {
			var toRet:int = 0;
			var seatyp:int = card.type;
			var i:int;
			var k:int;
			for (i=0; i<deck.length; i++) {
				if(deck[i] == seatyp){
					for(k=0; k<deck.length; k++){
						if (deck[i + k] == seatyp) {
							toRet++;
						} else {
							break;
						}
					}
					break;
				}
			}
			for (i=0; i<side.length; i++) {
				if(side[i] == seatyp){
					for(k=0; k<side.length; k++){
						if(side[i + k] == seatyp) {
							toRet++;
						} else {
							break;
						}
					}
					break;
				}
			}
			return(toRet);
		}
		private function buy(m:MouseEvent):void {
			var card:Object = m.target;
			if (price[card.type] <= gold && (side.length + deck.length) < cardMax) {
				side.push(card.type);
				if(card.type == 40){
					achivementGet(39);
				}
				side.sort(Array.NUMERIC);
				displayTfSet(null, 6, 3);
				gold -=  price[card.type];
				storeTf.text = (["Price: " + price[card.type],
				"Gold: " + gold,
				"Owned: " + owned(card),
				]).join("\n");
			} else if (price[card.type] >= gold) {
				displayTfSet(null, 7, 3);
			} else {
				displayTfSet(null, 13, 3);
			}
		}
		private function dmgDeal(dmg:int, target:Object, type:String):void {
			//var sendTxt:String;
			if (target == main) {
				if (dmg >= 0) {
					flashing = main;
					if(type == "S"){
						health -= ((dmg * enDmgMod) + enDmgBoost);
						if(health > 0 && ((dmg * enDmgMod) + enDmgBoost) >= 50){
							achivementGet(42);
						}
						if(((dmg * enDmgMod) + enDmgBoost) <= 0){
							achivementGet(18);
						}
					} else if(type == "P"){
						health -= (dmg + enDmgBoost);
						if((dmg + enDmgBoost) <= 0){
							achivementGet(18);
						}
					}
				} else if(dmg < 0){
					health -= (dmg * plrDmgMod);
				}
				if(health < 0){
					health = 0;
				}
					//sendTxt = "-" + dmg.toString();
				//} else {
//					//dmg = Math.abs(dmg);
//					//sendTxt = "+" + dmg.toString();
//				}
				//flashTxt(220, 203, sendTxt);
			} else if (target == mainEn) {
				if (dmg >= 0) {
					//sendTxt = "-" + dmg.toString();
					flashing = mainEn;
					if(type == "S"){
						if(enStuned == true){
							achivementGet(10);
						}
						enHealth -= ((dmg * plrDmgMod) + plrDmgBoost);
						if(((dmg * plrDmgMod) + plrDmgBoost) >= 100){
							achivementGet(23);
						}
					} else if(type == "P"){
						enHealth -= (dmg + plrDmgBoost);
						if((dmg + plrDmgBoost) >= 100){
							achivementGet(17);
						}
					}
				} else if(dmg < 0){
					enHealth -= (dmg * enDmgMod);
				}
				if(enHealth < 0){
					enHealth = 0;
				}
				//} else {
//					dmg = Math.abs(dmg);
//					sendTxt = "+" + dmg.toString();
//				}
				//flashTxt(50, 50, sendTxt);
			}
			updateCardDisp();
		}
		private function deathCheck():void {
			if (enHealth <= 0) {
				battleWin();
			} else if (health <= 0) {
				battleLose();
			}
		}
		private function battleWin():void {
			saveGame();
			btnClear();
			displayTfSet(null, 0, 3);
			newAtkBtn.gotoAndStop(14);
			removeChild(main);
			removeChild(mainEn);
			clearCards();
			if(health < 20){
				achivementGet(21);
				if(health < 5){
					achivementGet(41);
				}
			}
			if(turn < 4){
				achivementGet(34);
			}
			if(mana > 40){
				achivementGet(35);
			}
			turnStage = 5;
		}
		private function endBattleWin():void {
			btnMake(650,460,12,"levelSplit");
			dropChance = (2.0 - (curFoeNum / 2.5) + (gold / 1000));
			if(dropChance < 1){
				dropChance = 1;
			}
			if ((deck.length + side.length) < cardMax) {
				var cardGet:int = Math.ceil(Math.random() * dropChance);
				if (cardGet == 1) {
					displayTfSet(null, 2, 3);
					newCard = new Card();
					newCard.x = 350;
					newCard.y = 250;
					newCard.scaleX = 2;
					newCard.scaleY = 2;
					newCard.addEventListener(MouseEvent.ROLL_OVER, displayTfSet);
					newCard.type = Math.floor(Math.random() * (price.length - 3) + 2);
					newCard.gotoAndStop(newCard.type);
					side.push(newCard.type);
					addChild(newCard);
				} else {
					displayTfSet(null, 4, 3);
				}
			} else {
				displayTfSet(null, 8, 3);
			}
			bounty += (curFoeNum * 5) + 30;
			giveGold(bounty);
			if(((1 + ((enLvl - plrLvl)) * 10) + 10) + turn + (health / 12) > 0)
			{
				exp += ((1 + ((enLvl - plrLvl)) * 10) + 10) + turn + (health / 12) + (curFoeNum * 7.5);
			} else  if((30 - (plrLvl - enLvl)) > 0){
				exp += (30 - (plrLvl - enLvl));
			} else {
				exp += 10;
			}
			turnStage = 12;
			if (exp >= expTN) {
				lvlUp();
			}
		}
		private function battleLose():void {
			btnClear();
			turnStage = 6;
			displayTfSet(null, 1, 3);
			removeChild(main);
			removeChild(mainEn);
			clearCards();
			giveGold(Math.floor(bounty / 2) - 3);
			if(enLvl - plrLvl > 0) {
				exp += (enLvl - plrLvl);
			}
			if (exp >= expTN) {
				lvlUp();
			}
		}
		private function clearCards():void {
			for (var i:int = 0; i < (inPlay.length); i++) {
				removeChild(inPlay[i]);
				inPlay.splice(i, 1);
				i--;
			}
		}
		private function gotoMain(m:MouseEvent=null):void {
			if(m != null) {
				if (stage.contains(newCard) == true) {
					removeChild(newCard);
				}
				btnClear();
			}
			makeMain();
			saveGame();
			displayTfSet(null, 5, 3);
		}
		private function gotoMainFC(m:MouseEvent=null):void {
			btnClear();
			gotoAndStop(2);
			if(seenCred == false){
				giveGold(1000);
				seenCred = true;
			}
			makeMain();
			saveGame();
		}
		private function makeMain():void {
			tfClear();
			Math.ceil(exp);
			tfCreator(50, 420, "Lvl: " + plrLvl + "    Exp: " + exp + "/" + expTN);
			expBar = new Bar();
			expBar.x = 50;
			expBar.y = 450;
			expBar.width = ((exp / expTN) * 400);
			addChild(expBar);
			newAtkBtn.visible = false;
			btnMake(550,130,3,"store");
			btnMake(550,210,1,"bSelect");
			btnMake(550,290,2,"deckView");
			btnMake(550,370,21,"aView");
			btnMake(640,470,13,"credits");
		}
		private function credits(m:MouseEvent):void {
			btnClear();
			tfClear();
			removeChild(expBar);
			gotoAndStop(3);
			btnMake(640,470,12,"gotoMainFC");
		}
		private function flashTxt(posx:int, posy:int, tf:String, ac:Number):void {
			var flashTf:FlashTf = new FlashTf(ac);
			var format:TextFormat = new TextFormat();
			format.color = 0xCCCCCC;
			format.font = "Copperplate Gothic Light";
			format.size = 12;
			flashTf.setTextFormat(format);
			flashTf.defaultTextFormat = format;
			flashTf.x = posx;
			flashTf.y = posy;
			flashTf.text = tf;
			addChild(flashTf);
		}
		private function lvlUpMainIntercept(m:MouseEvent):void {
			btnClear();
			if (stage.contains(newCard) == true) {
				removeChild(newCard);
			}
			lvlUp();
			gotoLvl();
		}
		private function gotoLvl():void {
			turnStage = 11;
			btnClear();
			newAtkBtn.visible = false;
			btnMake(400, 200, 4, "statUp");
			btnMake(270, 200, 5, "statUp");
			btnMake(140, 200, 6, "statUp");
			displayTfSet(null, 16, 3);
		}
		private function statUp(m:MouseEvent):void {
			if (m.target.currentFrame == 4) {
				if(classNum == 1){
					atkStat += 5;
				} else if(classNum == 2){
					atkStat += 7;
				} else if(classNum == 3){
					atkStat += 6;
				}
			} else if (m.target.currentFrame == 5) {
				if(classNum == 1){
					healthStat += 32;
				} else if(classNum == 2){
					healthStat += 37;
				} else if(classNum == 3){
					healthStat += 35;
				}
			} else if (m.target.currentFrame == 6) {
				if(classNum == 1){
					manaRgn += 2;
					plrDmgMod += .1;
				} else if(classNum == 2){
					manaRgn += 1;
					plrDmgMod += .05;
				} else if(classNum == 3){
					manaRgn += 1;
					plrDmgMod += .07;
				}
			} else {
				
			}
			/*} else if (m.target.currentFrame == 18) {
				if(classNum == 1){
					plrDmgMod += .2;
				} else if(classNum == 2){
					plrDmgMod += .1;
				} else if(classNum == 3){
					plrDmgMod += .15;
				}
			}*/
			if(classNum == 1){
				plrDmgMod += .03;
				healthStat += 5;
				atkStat += 1;
			} else if(classNum == 2){
				plrDmgMod += .01;
				healthStat += 10;
				atkStat += 3;
			} else if(classNum == 3){
				plrDmgMod += .02;
				healthStat += 7;
				atkStat += 2;
			}
			btnClear();
			gotoMain();
		}
		private function lvlUp():void {
			plrLvl += 1;
			classLvl += 1;
			if(plrLvl == 5){
				deckMax = 30;
			} else if(plrLvl == 10){
				deckMax = 40;
			} else if(plrLvl == 15){
				cardPlay = 5;
			}
			//kongregate.stats.submit("Level",plrLvl);
			expTN = ((plrLvl - 1) * 20) + 70;
			exp = 0;
			turnStage = 10;
		}
		private function btnClear():void {
			for (var i:int = 0; i < (btnHolder.length); i++) {
				removeChild(btnHolder[i]);
				btnHolder.splice(i, 1);
				i--;
			}
		}
		private function btnMake(xPlc:int, yPlc:int, frame:int, funct:String):void {
			newMainBtn = new MainBtn();
			newMainBtn.x = xPlc;
			newMainBtn.y = yPlc;
			newMainBtn.gotoAndStop(frame);
			btnHolder.push(newMainBtn);
			newMainBtn.tf.mouseEnabled = false;
			if(funct == "statUp"){
				newMainBtn.addEventListener(MouseEvent.MOUSE_UP, statUp);
			} else if(funct == "enSelect"){
				newMainBtn.addEventListener(MouseEvent.MOUSE_UP, enSelect);
			} else if(funct == "store"){
				newMainBtn.addEventListener(MouseEvent.MOUSE_UP, store);
			} else if(funct == "credits"){
				newMainBtn.addEventListener(MouseEvent.MOUSE_UP, credits);
			} else if(funct == "deckView"){
				newMainBtn.addEventListener(MouseEvent.MOUSE_UP, deckView);
			} else if(funct == "loadGame"){
				newMainBtn.addEventListener(MouseEvent.MOUSE_UP, loadGame);
			} else if(funct == "backUp"){
				newMainBtn.addEventListener(MouseEvent.MOUSE_UP, backUp);
			} else if(funct == "charSelect"){
				newMainBtn.addEventListener(MouseEvent.MOUSE_UP, charSelect);
			} else if(funct == "forfit"){
				newMainBtn.addEventListener(MouseEvent.MOUSE_UP, forfit);
			} else if(funct == "gotoMainFC"){
				newMainBtn.addEventListener(MouseEvent.MOUSE_UP, gotoMainFC);
			} else if(funct == "levelSplit"){
				if (exp < expTN) {
					newMainBtn.addEventListener(MouseEvent.MOUSE_UP, gotoMain);
				} else {
					newMainBtn.addEventListener(MouseEvent.MOUSE_UP, lvlUpMainIntercept);
				}
			} else if(funct == "battleStart"){
				newMainBtn.addEventListener(MouseEvent.MOUSE_UP, battleStart);
			} else if(funct == "charSelect"){
				newMainBtn.addEventListener(MouseEvent.MOUSE_UP, charSelect);
			} else if(funct == "newGame"){
				newMainBtn.addEventListener(MouseEvent.MOUSE_UP, newGame);
			} else if(funct == "aView"){
				newMainBtn.addEventListener(MouseEvent.MOUSE_UP, aView);
			} else if(funct == "bSelect"){
				newMainBtn.addEventListener(MouseEvent.MOUSE_UP, enSelect);
			}
			addChild(newMainBtn);
		}
		private function tfClear():void {
			for (var i:int = 0; i < (tfHold.length); i++) {
				removeChild(tfHold[i]);
				tfHold.splice(i, 1);
				i--;
			}
		}
		private function statusEffect(cond:String, time:int, target:Object):void {
			if (target == mainEn) {
				if (cond == "STUN") {
					enStuned = true;
					enTrnStn = time;
					mainEn.enStnIcn.visible = true;
					if(plrStuned == true){
						achivementGet(37);
					}
				} else if (cond == "CURSE") {
					enCursed = true;
					if(plrTrnCur < enTrnCur && plrCursed == true){
						achivementGet(46);
					}
					enTrnCur = time;
					mainEn.enPsnIcn.visible = true;
				} else if (cond == "HIDE30") {
					enHid = 30;
					enTrnHid = time;
					mainEn.enHidIcn.visible = true;
				} else if (cond == "HIDE50") {
					enHid = 50;
					enTrnHid = time;
					mainEn.enHidIcn.visible = true;
				} else if (cond == "HIDE75") {
					enHid = 75;
					enTrnHid = time;
					mainEn.enHidIcn.visible = true;
				} else if (cond == "SILENCE"){
					enSil = true;
					enTrnSil = time;
					mainEn.enSilIcn.visible = true;
				}
			} else if (target == main) {
				if (cond == "STUN") {
					plrStuned = true;
					plrTrnStn = time;
					main.plrStnIcn.visible = true;
				} else if (cond == "CURSE") {
					plrCursed = true;
					plrTrnCur = time;
					main.plrPsnIcn.visible = true;
				} else if (cond == "HIDE30") {
					plrHid = 30;
					plrTrnHid = time;
					main.plrHidIcn.visible = true;
				} else if (cond == "HIDE50") {
					plrHid = 50;
					plrTrnHid = time;
					main.plrHidIcn.visible = true;
				} else if (cond == "HIDE75") {
					plrHid = 75;
					plrTrnHid = time;
					main.plrHidIcn.visible = true;
				} else if (cond == "SILENCE"){
					plrSil = true;
					plrTrnSil = time;
					main.plrSilIcn.visible = true;
				}
			}
		}
		private function achivementGet(num:int){
			var i:int;
			for(i=0;i<=aUnlock.length;i++){
				if(aUnlock[i] == num){
					break;
				} else if(i>=aUnlock.length){
					aGive(num);
					aUnlock.push(num);
					break;
				}
			}
		}
		private function aGive(num:int):void {
			var a:Achivement = new Achivement();
			a.x = 75;
			a.y = 550;
			a.aName.text = Achivement.Name(num);
			a.pic.gotoAndStop(num + 1);
			addChild(a);
			giveGold(12 * aUnlock.length);
		}
		private function aDesciption(m:MouseEvent):void {
			if(m.target.alpha == 1){
				displayTf.text = ([Achivement.Name(m.target.type - 1),
								Achivement.Reason(m.target.type - 1),
								]).join("\n");
			} else {
				displayTf.text = ([Achivement.Name(m.target.type - 1),
								]).join("\n");
			}
			
		}
		private function aView(m:MouseEvent):void {
			removeChild(expBar);
			enHealth = 1;
			tfClear();
			newAtkBtn.visible = true;
			newAtkBtn.gotoAndStop(15);
			newAtkBtn.x = 600;
			newAtkBtn.y = 470;
			btnClear();
			var i:int;
			var row:int = 0;
			var rank:int = 0;
			i = 2;
			while (i <= (price.length - 1)) {
				if (rank > 9) {
					row++;
					rank = 0;
				}
				newCard = new Card();
				newCard.x = (rank * 60) + 60;
				newCard.y = (70 * row) + 127;
				newCard.type = i;
				var j:int;
				for(j=0;j<=aUnlock.length;j++){
					if(aUnlock[j] == (newCard.type - 1)){
						break;
					} else if(j>=aUnlock.length){
						newCard.alpha = .3;
						break;
					}
				}
				newCard.gotoAndStop(newCard.type);
				newCard.addEventListener(MouseEvent.ROLL_OVER, aDesciption);
				newCard.addEventListener(MouseEvent.ROLL_OUT, displayClear);
				inPlay.push(newCard);
				addChild(newCard);
				i++;
				rank++;
			}
			turnStage = 7;
		}
		private function giveGold(amount:int){
			if(amount > 0){
				gold += amount;
			}
			if(gold > 500){
				achivementGet(1);
				if(gold > 9999){
					gold = 9999;
				}
			}
		}
		private function saveGame():void {
			flashTxt(0,475,"Game Saved", .03);
			saveGameA.data.ao = aUnlock;
			if(classNum == 1){
				saveGame1.data.xp = exp;
				saveGame1.data.deck = deck;
				saveGame1.data.side = side;
				saveGame1.data.lvl = plrLvl;
				saveGame1.data.money = gold;
				saveGame1.data.attack = atkStat;
				saveGame1.data.health = healthStat;
				saveGame1.data.dmgMod = plrDmgMod;
				saveGame1.data.mana = manaRgn;
				saveGame1.data.deckMax = deckMax;
				saveGame1.data.deckMin = deckMin;
				saveGame1.data.cardMax = cardMax;
				saveGame1.data.cardPlay = cardPlay;
				saveGame1.data.classLvl = classLvl;
				saveGame1.flush();
			} else if(classNum == 2){
				saveGame2.data.xp = exp;
				saveGame2.data.deck = deck;
				saveGame2.data.side = side;
				saveGame2.data.lvl = plrLvl;
				saveGame2.data.money = gold;
				saveGame2.data.attack = atkStat;
				saveGame2.data.health = healthStat;
				saveGame2.data.dmgMod = plrDmgMod;
				saveGame2.data.mana = manaRgn;
				saveGame2.data.deckMax = deckMax;
				saveGame2.data.deckMin = deckMin;
				saveGame2.data.cardMax = cardMax;
				saveGame2.data.cardPlay = cardPlay;
				saveGame2.data.classLvl = classLvl;
				saveGame2.flush();
			} else if(classNum == 3){
				saveGame3.data.xp = exp;
				saveGame3.data.deck = deck;
				saveGame3.data.side = side;
				saveGame3.data.lvl = plrLvl;
				saveGame3.data.money = gold;
				saveGame3.data.attack = atkStat;
				saveGame3.data.health = healthStat;
				saveGame3.data.dmgMod = plrDmgMod;
				saveGame3.data.mana = manaRgn;
				saveGame3.data.deckMax = deckMax;
				saveGame3.data.deckMin = deckMin;
				saveGame3.data.cardMax = cardMax;
				saveGame3.data.cardPlay = cardPlay;
				saveGame3.data.classLvl = classLvl;
				saveGame3.flush();
			} else if(classNum == 4){
				saveGame4.data.xp = exp;
				saveGame4.data.deck = deck;
				saveGame4.data.side = side;
				saveGame4.data.lvl = plrLvl;
				saveGame4.data.money = gold;
				saveGame4.data.attack = atkStat;
				saveGame4.data.health = healthStat;
				saveGame4.data.dmgMod = plrDmgMod;
				saveGame4.data.mana = manaRgn;
				saveGame4.data.deckMax = deckMax;
				saveGame4.data.deckMin = deckMin;
				saveGame4.data.cardMax = cardMax;
				saveGame4.data.cardPlay = cardPlay;
				saveGame4.data.classLvl = classLvl;
				saveGame4.flush();
			} else if(classNum == 5){
				saveGame5.data.xp = exp;
				saveGame5.data.deck = deck;
				saveGame5.data.side = side;
				saveGame5.data.lvl = plrLvl;
				saveGame5.data.money = gold;
				saveGame5.data.attack = atkStat;
				saveGame5.data.health = healthStat;
				saveGame5.data.dmgMod = plrDmgMod;
				saveGame5.data.mana = manaRgn;
				saveGame5.data.deckMax = deckMax;
				saveGame5.data.deckMin = deckMin;
				saveGame5.data.cardMax = cardMax;
				saveGame5.data.cardPlay = cardPlay;
				saveGame5.data.classLvl = classLvl;
				saveGame5.flush();
			}
		}
	}
}