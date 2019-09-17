package;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxState;
import flixel.FlxObject;
import flixel.addons.editors.tiled.TiledMap;
import flixel.tile.FlxTilemap;
import flixel.tile.FlxBaseTilemap.FlxTilemapAutoTiling;
import flixel.addons.editors.tiled.TiledTileLayer;
import flixel.addons.editors.tiled.TiledObjectLayer;
import flixel.FlxG;

class PlayState extends FlxState {
	var _player:Player;
	var _map:TiledMap;
	var _mWalls:FlxTilemap;
	var _grpCoins:FlxTypedGroup<Coin>;
	var _grpEnemies:FlxTypedGroup<Enemy>;

	override public function create():Void {
		_map = new TiledMap(AssetPaths.room_001__tmx);
		_mWalls = new FlxTilemap();
		_mWalls.loadMapFromArray(cast(_map.getLayer("walls"), TiledTileLayer).tileArray, _map.width, _map.height, AssetPaths.tiles__png, _map.tileWidth,
			_map.tileHeight, FlxTilemapAutoTiling.OFF, 1, 1, 3);
		_mWalls.follow();
		_mWalls.setTileProperties(2, FlxObject.NONE);
		_mWalls.setTileProperties(3, FlxObject.ANY);
		add(_mWalls);

		_grpCoins = new FlxTypedGroup<Coin>();
		add(_grpCoins);

		_grpEnemies = new FlxTypedGroup<Enemy>();
		add(_grpEnemies);

		_player = new Player();

		var tmpMap:TiledObjectLayer = cast _map.getLayer("entities");
		for (e in tmpMap.objects) {
			placeEntities(e.name, e.xmlData.x);
		}
		add(_player);

		// Camera
		FlxG.camera.follow(_player, TOPDOWN, 1);

		super.create();
	}

	function placeEntities(entityName:String, entityData:Xml):Void {
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		if (entityName == "player") {
			_player.x = x;
			_player.y = y;
		} else if (entityName == "coin") {
			_grpCoins.add(new Coin(x + 4, y + 4));
		} else if (entityName == "enemy") {
			_grpEnemies.add(new Enemy(x + 4, y, Std.parseInt(entityData.get("etype"))));
		}
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		FlxG.collide(_player, _mWalls);
		FlxG.overlap(_player, _grpCoins, playerTouchCoin);
		FlxG.collide(_grpEnemies, _mWalls);
		_grpEnemies.forEachAlive(checkEnemyVision);
	}

	function playerTouchCoin(P:Player, C:Coin):Void {
		if (P.alive && P.exists && C.alive && C.exists) {
			C.kill();
		}
	}

	function checkEnemyVision(e:Enemy):Void {
		if (_mWalls.ray(e.getMidpoint(), _player.getMidpoint())) {
			e.seesPlayer = true;
			e.playerPos.copyFrom(_player.getMidpoint());
		} else {
			e.seesPlayer = false;
		}
	}
}
