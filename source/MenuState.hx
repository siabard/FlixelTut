package;

import flixel.FlxG;
import flixel.ui.FlxButton;
import flixel.FlxState;

class MenuState extends FlxState {
    var _btnPlay: FlxButton;

    override public function create():Void {
        super.create();
        _btnPlay = new FlxButton(0, 0, "Play", clickPlay);
        _btnPlay.screenCenter();
        add(_btnPlay);
    }

    override public function update(elapsed: Float): Void {
        super.update(elapsed);
    }

    private function clickPlay(): Void {
        FlxG.switchState(new PlayState());
    }
}