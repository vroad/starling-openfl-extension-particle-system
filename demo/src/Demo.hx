package;
//{
    import flash.display.BitmapData;
    import flash.ui.Keyboard;
    import openfl.Assets;

    import starling.core.Starling;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.events.KeyboardEvent;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
    import starling.extensions.PDParticleSystem;
    import starling.extensions.ParticleSystem;
    import starling.textures.Texture;

    class Demo extends Sprite
    {
        // particle designer configurations
        
        #if 0
        [Embed(source="../media/drugs.pex", mimeType="application/octet-stream")]
        private static const DrugsConfig:Class;
        
        [Embed(source="../media/fire.pex", mimeType="application/octet-stream")]
        private static const FireConfig:Class;
        
        [Embed(source="../media/sun.pex", mimeType="application/octet-stream")]
        private static const SunConfig:Class;

        [Embed(source="../media/jellyfish.pex", mimeType="application/octet-stream")]
        private static const JellyfishConfig:Class;
        #end

        // particle textures
        
        #if 0
        [Embed(source="../media/drugs_particle.png")]
        private static const DrugsParticle:Class;
        
        [Embed(source="../media/fire_particle.png")]
        private static const FireParticle:Class;
        
        [Embed(source="../media/sun_particle.png")]
        private static const SunParticle:Class;
        
        [Embed(source="../media/jellyfish_particle.png")]
        private static const JellyfishParticle:Class;
        #end

        // member variables
        
        private var _particleSystems:Array<ParticleSystem>;
        private var _particleSystem:ParticleSystem;
        
        public function new()
        {
            super();
            var DrugsConfig:String = Assets.getText("media/drugs.pex");
            var FireConfig:String = Assets.getText("media/fire.pex");
            var SunConfig:String = Assets.getText("media/sun.pex");
            var JellyfishConfig:String = Assets.getText("media/jellyfish.pex");
            
            var DrugsParticle:BitmapData = Assets.getBitmapData("media/drugs_particle.png");
            var FireParticle:BitmapData = Assets.getBitmapData("media/fire_particle.png");
            var SunParticle:BitmapData = Assets.getBitmapData("media/sun_particle.png");
            var JellyfishParticle:BitmapData = Assets.getBitmapData("media/jellyfish_particle.png");
            
            var drugsConfig:Xml = Xml.parse(DrugsConfig);
            var drugsTexture:Texture = Texture.fromBitmapData(DrugsParticle);

            var fireConfig:Xml = Xml.parse(FireConfig);
            var fireTexture:Texture = Texture.fromBitmapData(FireParticle);

            var sunConfig:Xml = Xml.parse(SunConfig);
            var sunTexture:Texture = Texture.fromBitmapData(SunParticle);

            var jellyConfig:Xml = Xml.parse(JellyfishConfig);
            var jellyTexture:Texture = Texture.fromBitmapData(JellyfishParticle);

            _particleSystems = [
                new PDParticleSystem(drugsConfig, drugsTexture),
                new PDParticleSystem(fireConfig, fireTexture),
                new PDParticleSystem(sunConfig, sunTexture),
                new PDParticleSystem(jellyConfig, jellyTexture)
            ];
            
            // add event handlers for touch and keyboard
            
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
        }
        
        private function startNextParticleSystem():Void
        {
            if (_particleSystem != null)
            {
                _particleSystem.stop();
                _particleSystem.removeFromParent();
                Starling.sJuggler.remove(_particleSystem);
            }
            
            _particleSystem = _particleSystems.shift();
            _particleSystems.push(_particleSystem);

            _particleSystem.emitterX = 320;
            _particleSystem.emitterY = 240;
            _particleSystem.start();
            
            addChild(_particleSystem);
            Starling.sJuggler.add(_particleSystem);
        }
        
        private function onAddedToStage(event:Event):Void
        {
            stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey);
            stage.addEventListener(TouchEvent.TOUCH, onTouch);
            
            startNextParticleSystem();
        }
        
        private function onRemovedFromStage(event:Event):Void
        {
            stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKey);
            stage.removeEventListener(TouchEvent.TOUCH, onTouch);
        }
        
        private function onKey(event:Event, keyCode:UInt):Void
        {
            if (keyCode == Keyboard.SPACE)
                startNextParticleSystem();
        }
        
        private override function onTouch(event:TouchEvent):Void
        {
            var touch:Touch = event.getTouch(stage);
            if (touch != null && touch.phase != TouchPhase.HOVER)
            {
                _particleSystem.emitterX = touch.globalX;
                _particleSystem.emitterY = touch.globalY;
            }
        }
    }
//}