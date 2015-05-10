namespace :flickr do

  desc "turncate albums"
  task :truncate => [:environment] do
    ActiveRecord::Base.connection.execute("TRUNCATE portfolios RESTART IDENTITY")
    ActiveRecord::Base.connection.execute("TRUNCATE photos RESTART IDENTITY")
  end

  desc "import albums from flickr"
  task :import_albums => [:environment] do

    albums = flickr.photosets.getList
    for album in albums
      if Portfolio.where(:flickr_id => album.id).first.nil?
        Portfolio.create(
          :primary_photo_id => album.primary,
          :flickr_id => album.id,
          :secret => album.secret,
          :title  => album.title,
          :medium_url => FlickRaw.url_c(flickr.photos.getInfo(:photo_id => album.primary))
        )
      end

    end
  end

  desc "import photos from flickr for album"
  task :import_photos => [:environment] do

    albums = Portfolio.all
    for album in albums
      photos = flickr.photosets.getPhotos(:photoset_id => album.flickr_id)['photo']
      for photo in photos
        if Photo.where(:flickr_id => photo.id, :portfolio_id => album.id).first.nil?
          Photo.create(
            :flickr_id => photo.id,
            :secret => photo.secret,
            :title  => photo.title,
            :portfolio_id => album.id,
            :medium_url => FlickRaw.url_c(flickr.photos.getInfo(:photo_id => photo.id)),
            :large_url => FlickRaw.url_o(flickr.photos.getInfo(:photo_id => photo.id))

          )
        end

      end

    end
  end
end
