package com.osamamo.spotifyclone.repository;

import com.osamamo.spotifyclone.model.Song;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface SongRepository extends MongoRepository<Song, Long> {
}
