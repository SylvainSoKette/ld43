package;

class EventText extends h2d.Text {

	public function new(parent : h2d.Object) {
		super(hxd.res.DefaultFont.get(), parent);

		this.text = "";
		this.setScale(0.5);
		this.setPosition(1, 1);
		this.dropShadow = { dx: 1, dy: 1, color: 1, alpha : 1.0 };
		this.lineSpacing = 0;

		this.alpha = 0.5;

		parent.addChild(this);
	}

	public function setText( text : hxd.UString ) {
		this.text = text;
	}
}
