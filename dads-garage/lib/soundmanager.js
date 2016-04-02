if (Meteor.isClient) {
  this.SM = (function(){
    var musics = {};
    var volumes = {};
    /**
     * CreateJS Sound Manager
     * @returns {null}
     */
    function SM(){
        throw new Error("This class can't be instantiated");
        return null;
    }

    /**
     * Play music. This is only for playing musics. Use SM.playSound to play sound effects
     * @static
     * @param {String} id
     * @param {Number} repeat Number of times to repeat,0-once,-1-loop @default 0
     * @param {Number} fadeIn Number of milliseconds to fade in
     * @returns {void}
     */

    SM.setVolume = function(id, volume) {
        console.log('setVolume worked')
        volumes[id] = volume
    }

    SM.getVolume = function(id) {
        if (volumes[id])
            return volumes[id]
        return 1
    }

    SM.playMusic = function(id,repeat,fadeIn){
        if(musics[id] && musics[id].playing){
            SM.stopMusic(id, fadeIn)
            return
        }
        repeat = repeat||0;
        fadeIn = (!fadeIn)?0:fadeIn;
        var instance = createjs.Sound.play(id);
        instance.volume = (fadeIn!==0)?0:1;
        var o = {
            instance    : instance,
            playing     : true,
            repeat      : (repeat>=0)?repeat:0,
            loop        : (repeat===-1)?true:false,
            fadeStep    : 1000/(60*fadeIn*SM.getVolume(id)),
            fadeType    : "FADE_IN"
        };
        musics[id] = o;
        instance.addEventListener("complete",function(){
            SM.musicComplete(o);
        });
    };
    SM.update = function(){
        for(var id in musics){
            var o = musics[id];
            if(o.playing){
                if(o.fadeType === "FADE_IN"){
                    o.instance.volume += o.fadeStep;
                    if(o.instance.volume >= SM.getVolume(id)){
                        o.instance.volume = SM.getVolume(id);
                    }
                }else{
                    o.instance.volume -= o.fadeStep;
                    if(o.instance.volume <= 0){
                        o.instance.volume = 0;
                        SM.stopMusic(id);
                    }
                }
            }
        }
    };
   SM.musicComplete = function(o){
        o.playing = false;
        o.repeat -= 1;
        if(o.loop===true){
            o.instance.play();
            o.playing = true;
        }else if(o.repeat>0){
            o.instance.play();
            o.playing = true;
        }
    };
    /**
     * Stop a playing music
     * @static
     * @param {String} id
     * @param {Number}  fadeOut Number of milliseconds to fadeOut
     * @returns {void}
     */
    SM.stopMusic = function(id,fadeOut){
        var o = musics[id];
        fadeOut = (!fadeOut)?0:fadeOut;
        if(o && o.playing){
            o.fadeType = "FADE_OUT";
            o.fadeStep = (o.instance.volume*1000)/(60*fadeOut*SM.getVolume(id));
        }
        if (o.instance.volume == 0) {
            o.playing = false;
        }
    };
    /**
     * Play a sound. Use this only to play a sound effect. If it is music, use CSM.playMusic instead
     * @param {String} id
     * @returns {void}
     */
    SM.playSound = function(id){
        createjs.Sound.play(id);
    };
    /**
     * Stop a sound
     * @param {String} id
     * @returns {void}
     */
    SM.stopSound = function(id){
        createjs.Sound.stop(id);
    };
 /**
     * Stop playing all sounds
     * @param {type} fadeOut
     * @returns {void}
     */
    SM.stopAllMusics = function(fadeOut){
        for(var id in musics){
            SM.stopMusic(id,fadeOut);
        }
    };

    return SM;
  })();

  window.setInterval(function(){
    SM.update()
  }, 1000/60);
}
