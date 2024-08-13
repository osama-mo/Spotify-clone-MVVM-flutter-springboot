package com.osamamo.spotifyclone.controller;


import ch.qos.logback.core.util.StringUtil;
import com.osamamo.spotifyclone.dto.UploadSongRequest;
import com.osamamo.spotifyclone.model.Song;
import com.osamamo.spotifyclone.security.JwtUtils;
import com.osamamo.spotifyclone.services.SongService;
import io.micrometer.common.util.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;

@RestController
@RequestMapping("/songs")
public class SongController {

    @Autowired
    private SongService songService;

    @Autowired
    private JwtUtils jwtUtils;

    @PostMapping("/upload")
    public ResponseEntity<?> uploadSong(@RequestHeader("Authorization") String token,
                                        @Validated @ModelAttribute UploadSongRequest uploadSongRequest) {
        // Validate and extract user from token
        if (token.startsWith("Bearer ")) {
            token = token.substring(7);
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid JWT token format");
        }

        if (!jwtUtils.validateJwtToken(token)) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid JWT token");
        }
        if(StringUtils.isEmpty(uploadSongRequest.getArtist()) || StringUtils.isEmpty(uploadSongRequest.getTitle()) || StringUtils.isEmpty(uploadSongRequest.getHexCode()) || StringUtils.isEmpty(uploadSongRequest.getUploadedBy()) || uploadSongRequest.getCoverArt() == null || uploadSongRequest.getSongFile() == null){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Invalid request body");
        }

        try {
            Song song = songService.saveSong(uploadSongRequest);
            return ResponseEntity.ok(song);
        } catch (IOException e) {
            return ResponseEntity.status(500).body("Failed to upload song: " + e.getMessage());
        }
    }
}
