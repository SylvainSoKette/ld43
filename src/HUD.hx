package;

class HUD {

	var elements : Array<h2d.Object>;

	var hudOrcsIcon : h2d.Bitmap;
	var hudOrcsTxt : h2d.Text;
	var hudFoodIcon : h2d.Bitmap;
	var hudFoodTxt : h2d.Text;
	var hudSlavesIcon : h2d.Bitmap;
	var hudSlavesTxt : h2d.Text;
	var hudDemonIcon : h2d.Bitmap;
	var hudDemonTxt : h2d.Text;

	public function new(parent : h2d.Object) {

		var hudTiles = hxd.Res.icons.toTile();
		var font : h2d.Font = hxd.res.DefaultFont.get();

		hudOrcsIcon = new h2d.Bitmap(hudTiles.sub(16, 0, 16, 16), parent);
		hudOrcsTxt = new h2d.Text(font, parent);
		hudFoodIcon = new h2d.Bitmap(hudTiles.sub(32, 0, 16, 16), parent);
		hudFoodTxt = new h2d.Text(font, parent);
		hudSlavesIcon = new h2d.Bitmap(hudTiles.sub(48, 0, 16, 16), parent);
		hudSlavesTxt = new h2d.Text(font, parent);
		hudDemonIcon = new h2d.Bitmap(hudTiles.sub(0, 16, 16, 16), parent);
		hudDemonTxt = new h2d.Text(font, parent);

		elements = [
			hudOrcsIcon, hudOrcsTxt,
			hudFoodIcon, hudFoodTxt,
			hudSlavesIcon, hudSlavesTxt,
			hudDemonIcon, hudDemonTxt,
		];

		var i = 0;
		for (e in elements) {
			e.setPosition(i * 16 + Std.int(i/2) + 1, 0);
			i++;
		}
	}

	public function show(b : Bool) {
		for (e in elements) {
			e.visible = b;
		}
	}

	public function updateHUD(orcs : Int, food : Int, slaves : Int, demon : Int) {
		hudOrcsTxt.text = Std.string(orcs);
		hudFoodTxt.text = Std.string(food);
		hudSlavesTxt.text = Std.string(slaves);
		hudDemonTxt.text = Std.string(demon);
	}
}