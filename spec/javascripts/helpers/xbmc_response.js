XBMCResponse = {
  audioPlayer: {
    "id" : 1,
    "jsonrpc" : "2.0",
    "result" : {
      "audio" : true,
      "picture" : false,
      "video" : false
    }
  },
  videoPlayer: {
    "id" : 1,
    "jsonrpc" : "2.0",
    "result" : {
      "audio" : false,
      "picture" : false,
      "video" : true
    }
  },
  audioPlaylist: {
    "id" : 0,
    "jsonrpc" : "2.0",
    "result" : {
      "current" : 1,
      "end" : 1,
      "items" : [
      {
        "album" : "Who's Next",
        "artist" : "The Who",
        "fanart" : "special://masterprofile/Thumbnails/Music/Fanart/cf8685cd.tbn",
        "file" : "/Music/The Who/Who's Next/01 Baba O'Riley.mp3",
        "label" : "01. The Who - Baba O'Riley",
        "thumbnail" : "special://masterprofile/Thumbnails/Music/b/bba74b1e.tbn",
        "title" : "Baba O'Riley"
      },
      {
        "album" : "Who's Next",
        "artist" : "The Who",
        "fanart" : "special://masterprofile/Thumbnails/Music/Fanart/cf8685cd.tbn",
        "file" : "/Music/The Who/Who's Next/09 Won't Get Fooled Again.mp3",
        "label" : "09. The Who - Won't Get Fooled Again",
        "thumbnail" : "special://masterprofile/Thumbnails/Music/b/bba74b1e.tbn",
        "title" : "Won't Get Fooled Again"
      }
      ],
      "paused" : false,
      "playing" : true,
      "start" : 0,
      "total" : 1
    }
  },
  videoPlaylist: {
    "id" : 71,
    "jsonrpc" : "2.0",
    "result" : {
      "current" : 1,
      "end" : 2,
      "items" : [
      {
        "director" : "John Lasseter",
        "duration" : 5580,
        "fanart" : "special://masterprofile/Thumbnails/Video/Fanart/bf2ab336.tbn",
        "file" : "/Users/pixelblend/Movies/xbmc-test/Toy Story.mp4",
        "label" : "Toy Story",
        "plot" : "Woody the cowboy is young Andy’s favorite toy. Yet this changes when Andy get the new super toy Buzz Lightyear for his birthday. Now that Woody is no longer number one he plans his revenge on Buzz. Toy Story is a milestone in film history for being the first feature film to use entirely computer animation.",
        "thumbnail" : "special://masterprofile/Thumbnails/Video/b/bf2ab336.tbn",
        "title" : "Toy Story",
        "year" : 1995
      },
      {
        "director" : "Quentin Tarantino",
        "duration" : 7200,
        "fanart" : "special://masterprofile/Thumbnails/Video/Fanart/a379b384.tbn",
        "file" : "/Users/pixelblend/Movies/xbmc-test/Kill Bill.mp4",
        "label" : "Kill Bill Vol. 2",
        "plot" : "The Bride unwaveringly continues on her \"roaring rampage of revenge\" against the band of assassins who had tried to kill her and her unborn child. The woman visits each of her former associates one by one, checking off the victims on her Death List Five until there's nothing left to do … but kill Bill.",
        "thumbnail" : "special://masterprofile/Thumbnails/Video/a/a379b384.tbn",
        "title" : "Kill Bill Vol. 2",
        "year" : 2004
      }
      ],
      "paused" : false,
      "playing" : true,
      "start" : 1,
      "total" : 2
    }
  }
}