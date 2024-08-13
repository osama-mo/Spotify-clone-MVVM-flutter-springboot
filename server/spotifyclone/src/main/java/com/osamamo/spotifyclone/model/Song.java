package com.osamamo.spotifyclone.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import org.springframework.data.mongodb.core.mapping.Document;


@Document(collection = "songs")
public class Song {

    @Id
    private String id;

    @NotBlank
    private String title;

    @NotBlank
    private String artist;

    @NotBlank
    private String hexCode;

    @NotBlank
    private String uploadedBy;

    @NotBlank
    private String coverArtPath;

    @NotBlank
    private String songFilePath;

    // Getters and Setters


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public @NotBlank String getTitle() {
        return title;
    }

    public void setTitle(@NotBlank String title) {
        this.title = title;
    }

    public @NotBlank String getArtist() {
        return artist;
    }

    public void setArtist(@NotBlank String artist) {
        this.artist = artist;
    }

    public @NotBlank String getHexCode() {
        return hexCode;
    }

    public void setHexCode(@NotBlank String hexCode) {
        this.hexCode = hexCode;
    }

    public @NotBlank String getUploadedBy() {
        return uploadedBy;
    }

    public void setUploadedBy(@NotBlank String uploadedBy) {
        this.uploadedBy = uploadedBy;
    }

    public @NotBlank String getCoverArtPath() {
        return coverArtPath;
    }

    public void setCoverArtPath(@NotBlank String coverArtPath) {
        this.coverArtPath = coverArtPath;
    }

    public @NotBlank String getSongFilePath() {
        return songFilePath;
    }

    public void setSongFilePath(@NotBlank String songFilePath) {
        this.songFilePath = songFilePath;
    }
}
