package com.osamamo.spotifyclone.repository;

import com.osamamo.spotifyclone.model.Song;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;

import java.util.List;

public interface SongRepository extends MongoRepository<Song, String> {

    // Advanced search for both title and artist (case-insensitive)
    @Query("{ '$or' : [ {'title': { '$regex': ?0, '$options': 'i' }}, {'artist': { '$regex': ?0, '$options': 'i' }} ] }")
    List<Song> searchByTitleOrArtist(String query);
}
