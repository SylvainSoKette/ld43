package;

class ChoiceButton extends h2d.Bitmap {

	var btnText : h2d.Text;
	var interaction : h2d.Interactive;

	public function new(x : Int, y : Int, parent : h2d.Object) {
		var width : Int = 64;
		var height : Int = 16;

		super(hxd.Res.button.toTile(), parent);

		var font : h2d.Font = hxd.res.DefaultFont.get();
		btnText = new h2d.Text(font, parent);
		btnText.text = "";
		btnText.setScale(0.5);
		btnText.dropShadow = { dx: 1, dy: 1, color: 1, alpha : 1.0 };
		interaction = new h2d.Interactive(width, height, this);

		setPosition(x, y);
		btnText.setPosition(x + 5, y + 4);

		this.alpha = 0.7;
		this.btnText.alpha = 0.7;

		interaction.onOver = function(_) {
			this.alpha = 1.0;
			this.btnText.alpha = 1.0;
		};
		interaction.onOut = function(_) {
			this.alpha = 0.7;
			this.btnText.alpha = 0.7;
		};
	}

	public function show(b : Bool) {
		this.visible = b;
		this.btnText.visible = b;
	}

	public function updateText(text : hxd.UString) {
		this.btnText.text = text;
	}

	public function onClick(fc : hxd.Event -> Void) {
		this.interaction.onClick = fc;
	}

	public function setAction(actions) {
		this.interaction.onClick = function(_ : hxd.Event) {
			Game.inst.resolveAction(actions);
		};
	}
}
