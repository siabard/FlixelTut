package;

import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

using flixel.util.FlxSpriteUtil;

class HUD extends FlxTypedGroup<FlxSprite> {
	var _sprBack:FlxSprite;
	var _txtHealth:FlxText;
	var _txtMoney:FlxText;
	var _sprHealth:FlxSprite;
	var _sprMoney:FlxSprite;

	public function new() {
		super();
		_sprBack = new FlxSprite().makeGraphic(FlxG.width, 20, FlxColor.BLACK);
		_sprBack.drawRect(0, 19, FlxG.width, 1, FlxColor.WHITE);
		_txtHealth = new FlxText(16, 2, 0, "3 / 3", 8);
		_txtHealth.setBorderStyle(SHADOW, FlxColor.GRAY, 1, 1);
		_txtMoney = new FlxText(0, 2, 0, "0", 8);
		_txtMoney.setBorderStyle(SHADOW, FlxColor.GRAY, 1, 1);
		_sprHealth = new FlxSprite(4, _txtHealth.y + (_txtHealth.height / 2) - 4, AssetPaths.health__png);
		_sprMoney = new FlxSprite(FlxG.width - 12, _txtMoney.y + (_txtMoney.height / 2) - 4, AssetPaths.coin__png);
		_txtMoney.alignment = RIGHT;
		_txtMoney.x = _sprMoney.x - _txtMoney.width - 4;
		add(_sprBack);
		add(_sprHealth);
		add(_sprMoney);
		add(_txtHealth);
		add(_txtMoney);
		forEach(function(spr:FlxSprite) {
			spr.scrollFactor.set(0, 0);
		});
	}

	public function updateHUD(Health:Int = 0, Money:Int = 0):Void {
		_txtHealth.text = Std.string(Health) + " / 3";
		_txtMoney.text = Std.string(Money);
		_txtMoney.x = _sprMoney.x - _txtMoney.width - 4;
	}
}
