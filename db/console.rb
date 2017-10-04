require("pry")
require_relative("../models/albums")
require_relative("../models/artists")

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({
  'artist_name' => 'Rollins Band',
  })

  artist1.save()
  artist1.update()
  #
  album1 = Album.new({
    'artist_id' => artist1.id,
    'title' => 'Weight',
    'genre' => 'Hard Rock'
    })

    album1.save()

    binding.pry
    nil
