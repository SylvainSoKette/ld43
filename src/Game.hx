package;

class SinusDeform extends hxsl.Shader {

	static var SRC = {
		@global var time : Float;
		@param var speed : Float;
		@param var frequency : Float;
		@param var amplitude : Float;

		var calculatedUV : Vec2;
		var absolutePosition : Vec4;

		function fragment() {
			calculatedUV.x += sin(absolutePosition.y * frequency + time * speed + absolutePosition.x * 0.1) * amplitude;
		}
	};

	public function new( frequency = 10., amplitude = 0.01, speed = 1. ) {
		super();
		this.frequency = frequency;
		this.amplitude = amplitude;
		this.speed = speed;
	}
}

class ColorShader extends hxsl.Shader {

	static var SRC = {
		@:import h3d.shader.Base2d;

		@param var speed : Float;
		@param var frequency : Float;
		@param var amplitude : Float;

		function fragment() {
			pixelColor.r = sin(pixelColor.r * amplitude * time);
			pixelColor.g = sin(pixelColor.g * amplitude * time);
			pixelColor.b = sin(pixelColor.b * amplitude * time);
			pixelColor.a = pixelColor.a;
		}
	};

	public function new( amplitude = 0.1 ) {
		super();
		this.amplitude = amplitude;
	}
}

enum Defeat {
	NoMoreOrc;
	NoMoreFood;
	NoMoreSlave;
	SlaveRising;
	DemonTookOver;
}

class Game extends hxd.App {
	/**
	 * If you read this code : yeah I had no idea what I was doing,
	 * but I only had 48 hours to do it.
	 * Don't try to learn to much from this, but who knows, maybe I did
	 * something amazing !
	 */

	public var scene : h2d.Scene;

	var lost : Bool = false;

	var eventsDone : Int = 0;

	var backgroundTile : h2d.Tile;
	var backgroundFilter : h2d.filter.Filter;
	var background : h2d.Bitmap;
	var mainTheme : hxd.res.Sound;

	var hud : HUD;

	var eventText : EventText;
	// var lastEvent : Reg.Event;

	var btnL : ChoiceButton;
	var btnR : ChoiceButton;

	var stats : {
		orcs : Int,
		food : Int,
		slaves : Int,
		demon : Int
	};

	var gameShader : hxsl.Shader;
	var defeatShader : hxsl.Shader;

	/*
		ENGINE FUNCTION
	*/

	override private function init() {
		scene = s2d;

		scene.setFixedSize(Reg.WIDTH, Reg.HEIGHT);

		backgroundTile = hxd.Res.background.toTile();
		background = new h2d.Bitmap(backgroundTile, scene);
		background.filter = new h2d.filter.Bloom(1.0, .3, 2, 2);
		gameShader = new ColorShader();
		defeatShader = new SinusDeform();
		// background.addShader(gameShader);

		mainTheme = hxd.Res.sfx.main;
		mainTheme.play(true);

		hud = new HUD(scene);

		eventText = new EventText(scene);
		eventText.alpha = 1.0;
		eventText.textAlign = Center;
		eventText.setPosition(Reg.WIDTH / 2, 32);

		btnL = new ChoiceButton(1, Reg.HEIGHT - 17, scene);
		btnR = new ChoiceButton(70, Reg.HEIGHT - 17, scene);
		showEvent(false);

		stats = {
			orcs : 20,
			food : 50,
			slaves : 10,
			demon : 0
		}

		getEvent();
	}

	override private function update(dt : Float) {
		if (!lost) {
			if (stats.orcs <= 0) {
				stats.orcs = 0;
				defeat(Defeat.NoMoreOrc);
			}
			if (stats.food <= 0) {
				stats.food = 0;
				defeat(Defeat.NoMoreFood);
			}
			if (stats.slaves <= 0) {
				stats.food = 0;
				defeat(Defeat.NoMoreSlave);
			}
			if (stats.slaves > stats.orcs) {
				defeat(Defeat.SlaveRising);
			}
			if (stats.demon <= 0) {
				stats.demon = 0;
			}
			if (stats.demon > 99) {
				defeat(Defeat.DemonTookOver);
			}
		}


		updateHUD();
	}

	/*
		PRIVATE FUNCTION
	*/

	private function updateHUD() {
		hud.updateHUD(stats.orcs, stats.food, stats.slaves, stats.demon);
	}

	private function showEvent(b : Bool) {
		eventText.visible = b;
		for (btn in [ btnL, btnR]) {
			btn.show(b);
		}
	}

	private function getEvent() {
		var event = EventManager.getRandomEvent(eventsDone);
		// lastEvent = event;
		eventText.setText(new hxd.UString(event.text));
		if (event.img != null) {
			scene.addChild(event.img);
			event.img.setPosition(Reg.WIDTH / 2 - 32, Reg.HEIGHT / 2 - 32);
		}
		btnL.updateText(new hxd.UString(event.btnL.text));
		btnL.setAction(event.btnL.actions);
		btnR.updateText(new hxd.UString(event.btnR.text));
		btnR.setAction(event.btnR.actions);
		showEvent(true);
	}

	private function defeat(reason : Defeat ) {
		lost = true;

		mainTheme.stop();

		background.addShader(defeatShader);
		background.addShader(gameShader);
		hud.show(false);
		showEvent(false);

		var defeatText = new h2d.Text(hxd.res.DefaultFont.get(), scene);
		defeatText.textAlign = Center;
		defeatText.scale(0.5);
		defeatText.text = "Survived " + eventsDone + " days.\n\n";
		switch (reason) {
			case NoMoreOrc: defeatText.text += "Your clan is no more...";
			case NoMoreFood: defeatText.text += "Your clan died of hunger...";
			case NoMoreSlave: defeatText.text += "Your clan could'nt live\nwithout slaves...";
			case SlaveRising: defeatText.text += "The slave rose and took\nover !";
			case DemonTookOver: defeatText.text += "The demon came and claimed \nyour clan. They are not dead,\nbut they have a new\nmaster now...";
			default: defeatText.text += "Yeah I have no idea what\nyou did there...";
		}
		defeatText.dropShadow = { dx: 1, dy: 1, color: 1, alpha : 1.0 };
		defeatText.setPosition(Reg.WIDTH / 2, 32);

		var txt = new h2d.Text(hxd.res.DefaultFont.get(), scene);
		txt.textAlign = Center;
		txt.scale(0.5);
		txt.text = "Click anywhere...";
		txt.dropShadow = { dx: 1, dy: 1, color: 1, alpha : 1.0 };
		txt.setPosition(Reg.WIDTH / 2, Reg.HEIGHT - 16);

		var music = hxd.Res.sfx.wardrums;
		music.play(true);

		var i = new h2d.Interactive(Reg.WIDTH, Reg.HEIGHT, scene);
		i.onRelease = function(_) {
			music.stop();
			i.remove();
			new Title();
		};
	}

	/*
		GAME ACTIONS
	*/

	private function doOrc(value) {
		if (value > 0) {
			hxd.Res.sfx.plus_orc.play(false);
		} else {
			hxd.Res.sfx.minus_orc.play(false);
		}
		stats.orcs += value;
	}

	private function doFood(value) {
		if (value > 0) {
			hxd.Res.sfx.plus_food.play(false);
		} else {
			hxd.Res.sfx.minus_food.play(false);
		}
		stats.food += value;
	}

	private function doSlave(value) {
		if (value > 0) {
			hxd.Res.sfx.plus_slave.play(false);
		} else {
			hxd.Res.sfx.minus_slave.play(false);
		}
		stats.slaves += value;
	}

	private function doDemon(value) {
		if (value > 0) {
			hxd.Res.sfx.plus_demon.play(false);
		} else {
			hxd.Res.sfx.minus_demon.play(false);
		}
		stats.demon += value;
	}

	public function resolveAction(actions : Array<{action : Reg.Action, value : Int}>) {
		showEvent(false);

		for (a in actions) {
			switch(a.action) {
				case Orc: doOrc(a.value);
				case Food: doFood(a.value);
				case Slave: doSlave(a.value);
				case Demon: doDemon(a.value);
				default: trace("WAT in Game.hx resolveAction()");
			}
		}

		eventsDone += 1;

		getEvent();
	}

	/*
		main entrypoint
	*/

	public static var inst : Game;
	static function main() {
		hxd.Res.initEmbed();
		new Title();
	}
}
