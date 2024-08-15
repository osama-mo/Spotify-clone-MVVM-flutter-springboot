package com.osamamo.spotifyclone.services;




import com.osamamo.spotifyclone.model.Song;
import com.osamamo.spotifyclone.model.User;
import com.osamamo.spotifyclone.repository.SongRepository;
import com.osamamo.spotifyclone.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class FavoriteSongService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private SongRepository songRepository;

    public void addFavoriteSong(String username, String songId) {
        Optional<User> userOptional = userRepository.findByUsername(username);
        if (userOptional.isPresent()) {
            User user = userOptional.get();
            user.getFavoriteSongIds().add(songId);
            userRepository.save(user);
        }
    }

    public void removeFavoriteSong(String username, String songId) {
        Optional<User> userOptional = userRepository.findByUsername(username);
        if (userOptional.isPresent()) {
            User user = userOptional.get();
            user.getFavoriteSongIds().remove(songId);
            userRepository.save(user);
        }
    }

    public List<Song> getFavoriteSongs(String username) {
        Optional<User> userOptional = userRepository.findByUsername(username);
        if (userOptional.isPresent()) {
            User user = userOptional.get();
            return user.getFavoriteSongIds().stream()
                    .map(songId -> songRepository.findById(songId))
                    .filter(Optional::isPresent)
                    .map(Optional::get)
                    .collect(Collectors.toList());
        }
        return List.of();
    }
}
