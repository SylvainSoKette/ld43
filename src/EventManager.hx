package;

typedef Event = {
	img : h2d.Bitmap,
	req : Int,
	text : hxd.UString,
	btnL : { text : hxd.UString, actions : Array<{action : Reg.Action, value : Int}>, },
	btnR : { text : hxd.UString, actions : Array<{action : Reg.Action, value : Int}>, },
};

class EventManager {

	private static function getEvents() : Array<Event> {
		var events : Array<Event> = [
			{
				img : null,
				req : 0,
				text : "Grog-Tak leader !
					Winter is coming, we need more
					food, what shall we do ?
					Are the slaves juicy enough
					or should we go on a hunt ?",
				btnL : {
					text : "Let's hunt",
					actions : [
						{action : Reg.Action.Food, value : 2},
						{action : Reg.Action.Orc, value : -1}
					],
				},
				btnR : {
					text : "ROAST A SLAVE !",
					actions : [
						{action : Reg.Action.Food, value : 5},
						{action : Reg.Action.Slave, value : -1},
					],
				},
			},
			{
				img : null,
				req : 0,
				text : "Grog-Tak leader !
					Summer is coming, we need to
					prepare for battle !
					Shall we train on the slaves ?",
				btnL : {
					text : "Great idea !",
					actions : [
						{action : Reg.Action.Slave, value : -2},
						{action : Reg.Action.Demon, value : 1},
					],
				},
				btnR : {
					text : "No ! On you !",
					actions : [
						{action : Reg.Action.Orc, value : -1},
						{action : Reg.Action.Demon, value : 5},
					],
				},
			},
			{
				img : null,
				req : 0,
				text : "Oh great one,
					We need more soldiers,
					or we'll appear feeble
					to the other clan.
					What shall we do ?!",
				btnL : {
					text : "BABIES",
					actions : [
						{action : Reg.Action.Orc, value : 10},
					],
				},
				btnR : {
					text : "Mitosis ?",
					actions : [
						{action : Reg.Action.Demon, value : 1},
					],
				},
			},
			{
				img : null,
				req : 0,
				text : "Goz goz great one !
					The demons say we need
					to build a great monumemt,
					or they shall destroy our
					camp.
					What we do ?",
				btnL : {
					text : "Lies...",
					actions : [
						{action : Reg.Action.Demon, value : 20},
					],
				},
				btnR : {
					text : "Use slaves",
					actions : [
						{action : Reg.Action.Slave, value : -5},
						{action : Reg.Action.Demon, value : -5},
					],
				},
			},
			{
				img : null,
				req : 0,
				text : "Goz goz great one !
					The demons say we need
					to build a great monumemt,
					or they shall destroy us.
					What we do ?",
				btnL : {
					text : "A big one then.",
					actions : [
						{action : Reg.Action.Orc, value : -2},
						{action : Reg.Action.Slave, value : -5},
						{action : Reg.Action.Demon, value : -50},
					],
					
				},
				btnR : {
					text : "They lie.",
					actions : [
						{action : Reg.Action.Demon, value : 15},
					],
				},
			},
			{
				img : null,
				req : 0,
				text : "Hear me leader !
					Your clan is weak, we will
					defeat you in battle.
					Or you can give us food...",
				btnL : {
					text : "Attaaack !",
					actions : [
						{action : Reg.Action.Orc, value : -5},
						{action : Reg.Action.Demon, value : 5},
					],
					
				},
				btnR : {
					text : "We share food.",
					actions : [
						{action : Reg.Action.Food, value : -10},
					],
				},
			},
			{
				img : null,
				req : 0,
				text : "I DON'T WANT TO BE
				YOUR SOLDIER ANYMORE,
				I QUIT !",
				btnL : {
					text : "Can you ?",
					actions : [
						{action : Reg.Action.Orc, value : -1},
					],
					
				},
				btnR : {
					text : "Cook him.",
					actions : [
						{action : Reg.Action.Food, value : 2},
						{action : Reg.Action.Orc, value : -1},
						{action : Reg.Action.Demon, value : 10},
					],
				},
			},
			{
				img : null,
				req : 0,
				text : "Whispers in your head :
				I
				can
				make
				you
				strooong.",
				btnL : {
					text : "Watizdis ?",
					actions : [
						{action : Reg.Action.Demon, value : 1},
					],
					
				},
				btnR : {
					text : "Tell me.",
					actions : [
						{action : Reg.Action.Orc, value : -1},
						{action : Reg.Action.Demon, value : 10},
					],
				},
			},
			{
				img : null,
				req : 0,
				text : "Goz Goz great One !
				We want to train,
				we want battle,
				we want blood !",
				btnL : {
					text : "To war !",
					actions : [
						{action : Reg.Action.Orc, value : -1},
						{action : Reg.Action.Demon, value : -10},
					],
					
				},
				btnR : {
					text : "Go recruit !",
					actions : [
						{action : Reg.Action.Orc, value : 5},
					],
				},
			},
			{
				img : null,
				req : 10,
				text : "I am the bard named Glenn,
				I shall serve you.
				Take me to battle, and I shall
				play for your troops, granting
				them even more power and courage !",
				btnL : {
					text : "Continue...",
					actions : [
						{action : Reg.Action.Orc, value : 1},
						{action : Reg.Action.Demon, value : -5},
					],
					
				},
				btnR : {
					text : "You shall be slave.",
					actions : [
						{action : Reg.Action.Slave, value : 1},
					],
				},
			},
			{
				img : null,
				req : 10,
				text : "I am Morhaine...
				I will make your enemies weak,
				I will make you rich.",
				btnL : {
					text : "How ? NEXT !",
					actions : [],
					
				},
				btnR : {
					text : "Go on recruit !",
					actions : [
						{action : Reg.Action.Orc, value : 1},
					],
				},
			},
			{
				img : null,
				req : 20,
				text : "Great Leader !
				The neighbouring clan is invoking
				a great demon, on a mobile device !
				We are doomed !
				
				Goz goz goz goz !",
				btnL : {
					text : "We crush mobile !",
					actions : [
						{action : Reg.Action.Orc, value : -1},
						{action : Reg.Action.Demon, value : -5},
					],
					
				},
				btnR : {
					text : "Don't you have mobile ?",
					actions : [
						{action : Reg.Action.Demon, value : 25},
					],
				},
			},
			{
				img : null,
				req : 0,
				text : "Goz goz, biggest one !
				We are pretty bored...",
				btnL : {
					text : "Feast !",
					actions : [
						{action : Reg.Action.Food, value : -5},
					],
					
				},
				btnR : {
					text : "Fight !",
					actions : [
						{action : Reg.Action.Orc, value : -1},
					],
				},
			},
			{
				img : null,
				req : 0,
				text : "Goz goz, biggest one !
				We are pretty bored...",
				btnL : {
					text : "Kill a pig then.",
					actions : [
						{action : Reg.Action.Food, value : 5},
					],
					
				},
				btnR : {
					text : "Fight !",
					actions : [
						{action : Reg.Action.Orc, value : -1},
					],
				},
			},
			{
				img : null,
				req : 0,
				text : "Goz goz, biggest one !
				We are pretty bored...",
				btnL : {
					text : "Big fight !",
					actions : [
						{action : Reg.Action.Orc, value : -2},
					],
					
				},
				btnR : {
					text : "Fight  a slave ?",
					actions : [
						{action : Reg.Action.Slave, value : -1},
					],
				},
			},
			{
				img : null,
				req : 0,
				text : "A comet has been sighted",
				btnL : {
					text : "It's a sign.",
					actions : [
						{action : Reg.Action.Orc, value : -5},
					],
				},
				btnR : {
					text : "It's a sign.",
					actions : [
						{action : Reg.Action.Demon, value : 15},
					],
				},
			},
			{
				img : null,
				req : 0,
				text : "Oh no !
				It's a meteor !!!!",
				btnL : {
					text : "We are doomed.",
					actions : [
						{action : Reg.Action.Demon, value : 15},
					],
					
				},
				btnR : {
					text : "Panic !",
					actions : [
						{action : Reg.Action.Orc, value : -5},
					],
				},
			},
		];
		return events;
	}

	public static function getTutorialEvent() : Event {
		return {
			img : null,
			req : 0,
			text : "Goz goz !
				Trog-Dhur was killed in glorious battle !
				Please take the command of our clan
				and lead us !
				Keep our ranks high,
				Keep us strong and fed,
				Bring us many slaves
				and keep the demons away !
				TO VICTORY !",
			btnL : {
				text : "You're annoying.",
				actions : [{action : Reg.Action.Orc, value : -1}],
			},
			btnR : {
				text : "Order a feast !",
				actions : [{action : Reg.Action.Food, value : -5}],
			},
		};
	}


	public static function getRandomEvent(eventsDone) : Event {
		var events : Array<Event> = EventManager.getEvents();
		var filteredEvents : Array<Event> = [];
		for (event in events) {
			if (event.req <= eventsDone) {
				filteredEvents.push(event);
			}
		}
		var i : Int = Math.floor(filteredEvents.length * Math.random());
		return filteredEvents[i];
	}
}
