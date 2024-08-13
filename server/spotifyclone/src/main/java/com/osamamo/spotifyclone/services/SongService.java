package com.osamamo.spotifyclone.services;

import com.osamamo.spotifyclone.dto.UploadSongRequest;
import com.osamamo.spotifyclone.model.Song;
import com.osamamo.spotifyclone.repository.SongRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@Service
public class SongService {

    private final Path rootLocation;

    private final SongRepository songRepository;

    @Autowired
    public SongService(@Value("${file.upload-dir}") String uploadDir, SongRepository songRepository) {
        this.rootLocation = Paths.get(uploadDir);
        this.songRepository = songRepository;
    }

    public Song saveSong(UploadSongRequest request) throws IOException {
        // Save the cover art
        String coverArtPath = saveFile(request.getCoverArt());

        // Save the song file
        String songFilePath = saveFile(request.getSongFile());

        // Create and save the Song entity
        Song song = new Song();
        song.setTitle(request.getTitle());
        song.setArtist(request.getArtist());
        song.setHexCode(request.getHexCode());
        song.setUploadedBy(request.getUploadedBy());
        song.setCoverArtPath(coverArtPath);
        song.setSongFilePath(songFilePath);

        return songRepository.save(song);
    }

    private String saveFile(MultipartFile file) throws IOException {
        if (file.isEmpty()) {
            throw new IOException("Failed to store empty file.");
        }
        String filename = System.currentTimeMillis() + "-" + file.getOriginalFilename();
        Path destinationFile = this.rootLocation.resolve(Paths.get(filename))
                .normalize().toAbsolutePath();

        Files.copy(file.getInputStream(), destinationFile);

        return destinationFile.toString();
    }
}
