XBMCResponse = {
  audio_player: {
    status: 200,
    responseText: {
      "id" : 1,
      "jsonrpc" : "2.0",
      "result" : {
        "audio" : true,
        "picture" : false,
        "video" : false
      }
    }    
  },
  audio_playlist: {
    status: 200,
    responseText: {
      "id" : 1,
      "jsonrpc" : "2.0",
      "result" : {
        "current" : 1,
        "end" : 1,
        "items" : [
        {
          "album" : "Remain In Light",
          "artist" : "Talking Heads",
          "fanart" : "special://masterprofile/Thumbnails/Music/Fanart/d5e84e8a.tbn",
          "file" : "/Users/pixelblend/Music/iTunes/iTunes Media/Music/Talking Heads/Remain In Light/01 Born Under Punches (The Heat Goes On).mp3",
          "label" : "01. Talking Heads - Born Under Punches (The Heat Goes On)",
          "title" : "Born Under Punches (The Heat Goes On)"
        },
        {
          "album" : "Remain In Light",
          "artist" : "Talking Heads",
          "fanart" : "special://masterprofile/Thumbnails/Music/Fanart/d5e84e8a.tbn",
          "file" : "/Users/pixelblend/Music/iTunes/iTunes Media/Music/Talking Heads/Remain In Light/02 Crosseyed And Painless.mp3",
          "label" : "02. Talking Heads - Crosseyed And Painless",
          "thumbnail" : "DefaultAlbumCover.png",
          "title" : "Crosseyed And Painless"
        }
        ],
        "paused" : false,
        "playing" : true,
        "start" : 0,
        "total" : 2
      }
    }
  }
}