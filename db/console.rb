require("pry")
require_relative("../models/albums")
require_relative("../models/artists")

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({
  'artist_name' => 'Rollins Band',
  })

  artist1.save()

  artist2 = Artist.new({
    'artist_name' => 'Future of the Left',
    })

    artist2.save()

  album1 = Album.new({
    'artist_id' => artist1.id,
    'title' => 'Weight',
    'genre' => 'Hard Rock'
    })

    album2 = Album.new({
      'artist_id' => artist1.id,
      'title' => 'Hard Volume',
      'genre' => 'Hard Rock'
      })

      album3 = Album.new({
        'artist_id' => artist2.id,
        'title' => 'How To Stop Your Brain In An Accident',
        'genre' => 'Alternative Rock'
        })

    album1.save()
    album2.save()
    album3.save()


    binding.pry
    nil
