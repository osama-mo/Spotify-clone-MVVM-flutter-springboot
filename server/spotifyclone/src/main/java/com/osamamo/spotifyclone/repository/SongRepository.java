package com.osamamo.spotifyclone.repository;

import com.osamamo.spotifyclone.model.Song;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SongRepository extends JpaRepository<Song, Long> {
}
