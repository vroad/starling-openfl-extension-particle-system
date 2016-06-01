package; 
//{
    import flash.display.Sprite;

    import starling.core.Starling;

    #if 0
    [SWF(width="640", height="480", frameRate="60", backgroundColor="#222222")]
    #end
    class Startup extends Sprite
    {
        private var _starling:Starling;
        
        public function new()
        {
            super();
            _starling = new Starling(Demo, stage);
            _starling.showStats = true;
            _starling.start();
        }
    }
//}