package;

class Title extends hxd.App {

	var scene : h2d.Scene;
	var logo : h2d.Bitmap;
	var txt : h2d.Text;
	var music : hxd.res.Sound;

	override private function init() {
		scene = s2d;
		scene.setFixedSize(Reg.WIDTH, Reg.HEIGHT);
		logo = new h2d.Bitmap(hxd.Res.title.toTile(), scene);
		txt = new h2d.Text(hxd.res.DefaultFont.get(), scene);
		txt.textAlign = Center;
		txt.scale(0.5);
		txt.text = "Click anywhere to start a game";
		txt.dropShadow = { dx: 1, dy: 1, color: 1, alpha : 1.0 };
		txt.setPosition(Reg.WIDTH / 2, Reg.HEIGHT - 16);

		music = hxd.Res.sfx.wardrums;
		music.play(true);

		var i = new h2d.Interactive(Reg.WIDTH, Reg.HEIGHT, scene);
		i.onRelease = function(_) {
			music.stop();
			i.remove();
			Game.inst = new Game();
		};
	}
}
