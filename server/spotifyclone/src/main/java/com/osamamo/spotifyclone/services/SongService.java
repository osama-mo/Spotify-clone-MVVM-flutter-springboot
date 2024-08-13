package com.osamamo.spotifyclone.services;

import com.osamamo.spotifyclone.dto.UploadSongRequest;
import com.osamamo.spotifyclone.model.Song;
import com.osamamo.spotifyclone.repository.SongRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.mongodb.gridfs.GridFsOperations;
import org.springframework.data.mongodb.gridfs.GridFsTemplate;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Objects;

@Service
public class SongService {

    private final Path rootLocation;

    private final SongRepository songRepository;

    @Autowired
    public SongService(@Value("${file.upload-dir}") String uploadDir, SongRepository songRepository) {
        this.rootLocation = Paths.get(uploadDir);
        this.songRepository = songRepository;
    }
    @Autowired
    private GridFsOperations operations;

    @Autowired
    private GridFsTemplate gridFsTemplate;

    public Song saveSong(UploadSongRequest request) throws IOException {
        // Save the cover art in GridFS
        String coverArtFileId = saveFileToGridFS(request.getCoverArt(), "coverArt");

        // Save the song file in GridFS
        String songFileId = saveFileToGridFS(request.getSongFile(), "songFile");

        // Create and save the Song entity
        Song song = new Song();
        song.setTitle(request.getTitle());
        song.setArtist(request.getArtist());
        song.setHexCode(request.getHexCode());
        song.setUploadedBy(request.getUploadedBy());
        song.setCoverArtPath(coverArtFileId);
        song.setSongFilePath(songFileId);

        return songRepository.save(song);
    }

    private String saveFileToGridFS(MultipartFile file, String fileType) throws IOException {
        return Objects.requireNonNull(gridFsTemplate.store(file.getInputStream(), file.getOriginalFilename(), file.getContentType())).toString();
    }

    public List<Song> getAllSongs() {
        return songRepository.findAll();
    }
}