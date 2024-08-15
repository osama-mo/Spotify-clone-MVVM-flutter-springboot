package com.osamamo.spotifyclone.controller;





import com.osamamo.spotifyclone.dto.UploadSongRequest;
import com.osamamo.spotifyclone.model.Song;
import com.osamamo.spotifyclone.security.JwtUtils;
import com.osamamo.spotifyclone.services.FavoriteSongService;
import com.osamamo.spotifyclone.services.SongService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.gridfs.GridFsOperations;
import org.springframework.data.mongodb.gridfs.GridFsTemplate;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.data.mongodb.core.query.Criteria;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

@RestController
@RequestMapping("/songs")
public class SongController {

    @Autowired
    private SongService songService;

    @Autowired
    private JwtUtils jwtUtils;

    @Autowired
    private FavoriteSongService favoriteSongService;

    @Autowired
    private GridFsOperations operations;

    @PostMapping("/upload")
    public ResponseEntity<?> uploadSong(@RequestHeader("Authorization") String token,
                                        @Validated @ModelAttribute UploadSongRequest uploadSongRequest) {
        if (token.startsWith("Bearer ")) {
            token = token.substring(7);
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid JWT token format");
        }

        if (!jwtUtils.validateJwtToken(token)) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid JWT token");
        }

        try {
            Song song = songService.saveSong(uploadSongRequest);
            return ResponseEntity.ok(song);
        } catch (IOException e) {
            return ResponseEntity.status(500).body("Failed to upload song: " + e.getMessage());
        }
    }

    @GetMapping("/coverArt/{id}")
    public ResponseEntity<?> getCoverArt(@PathVariable String id) throws IOException {
        return getFileResponseEntity(id);
    }

    @GetMapping("/songFile/{id}")
    public ResponseEntity<?> getSongFile(@PathVariable String id) throws IOException {
        return getFileResponseEntity(id);
    }

    private ResponseEntity<?> getFileResponseEntity(String id) throws IOException {
        var gridFsFile = operations.findOne(new Query(Criteria.where("_id").is(id)));

        if (gridFsFile != null) {
            InputStream inputStream = operations.getResource(gridFsFile).getInputStream();
            return ResponseEntity.ok()
                    .contentType(MediaType.parseMediaType(gridFsFile.getMetadata().getString("_contentType")))
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + gridFsFile.getFilename() + "\"")
                    .body(inputStream.readAllBytes());
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("File not found");
        }
    }
    @GetMapping("/getAll")
    public ResponseEntity<?> getSongs(@RequestHeader("Authorization") String token) {
        // Validate and extract user from token
        if (token.startsWith("Bearer ")) {
            token = token.substring(7);
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid JWT token format");
        }

        if (!jwtUtils.validateJwtToken(token)) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid JWT token");
        }


        List<Song> songs = songService.getAllSongs();
        return ResponseEntity.ok(songs);
    }


    @PostMapping("/favorite/{songId}")
    public ResponseEntity<?> addFavoriteSong(@RequestHeader("Authorization") String token, @PathVariable String songId) {
        if (token.startsWith("Bearer ")) {
            token = token.substring(7);
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid JWT token format");
        }

        if (!jwtUtils.validateJwtToken(token)) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid JWT token");
        }

        String username = jwtUtils.getUserNameFromJwtToken(token);
        favoriteSongService.addFavoriteSong(username, songId);

        return ResponseEntity.ok("Song added to favorites");
    }

    @DeleteMapping("/favorite/{songId}")
    public ResponseEntity<?> removeFavoriteSong(@RequestHeader("Authorization") String token, @PathVariable String songId) {
        if (token.startsWith("Bearer ")) {
            token = token.substring(7);
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid JWT token format");
        }

        if (!jwtUtils.validateJwtToken(token)) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid JWT token");
        }

        String username = jwtUtils.getUserNameFromJwtToken(token);
        favoriteSongService.removeFavoriteSong(username, songId);

        return ResponseEntity.ok("Song removed from favorites");
    }

    @GetMapping("/favorites")
    public ResponseEntity<List<Song>> getFavoriteSongs(@RequestHeader("Authorization") String token) {
        if (token.startsWith("Bearer ")) {
            token = token.substring(7);
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(null);
        }

        if (!jwtUtils.validateJwtToken(token)) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(null);
        }

        String username = jwtUtils.getUserNameFromJwtToken(token);
        List<Song> favoriteSongs = favoriteSongService.getFavoriteSongs(username);

        return ResponseEntity.ok(favoriteSongs);
    }
}


