enum Action {
	Orc;
	Food;
	Slave;
	Demon;
}

typedef Event = {
	img : h2d.Bitmap,
	req : Int,
	text : hxd.UString,
	btnL : { text : hxd.UString, actions : Array<{action : Reg.Action, value : Int}>, },
	btnR : { text : hxd.UString, actions : Array<{action : Reg.Action, value : Int}>, },
};

class Reg {
	public static var WIDTH : Int = 135;
	public static var HEIGHT : Int = 135;
}
