package com.osamamo.spotifyclone.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import org.springframework.web.multipart.MultipartFile;



public class UploadSongRequest {

    @NotBlank
    private String title;

    @NotBlank
    private String artist;

    @NotBlank
    private String hexCode;

    @NotBlank
    private String uploadedBy;

    @NotNull
    private MultipartFile coverArt;

    @NotNull
    private MultipartFile songFile;

    // Getters and Setters


    public @NotBlank String getArtist() {
        return artist;
    }

    public void setArtist(@NotBlank String artist) {
        this.artist = artist;
    }

    public @NotBlank String getTitle() {
        return title;
    }

    public void setTitle(@NotBlank String title) {
        this.title = title;
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

    public @NotNull MultipartFile getCoverArt() {
        return coverArt;
    }

    public void setCoverArt(@NotNull MultipartFile coverArt) {
        this.coverArt = coverArt;
    }

    public @NotNull MultipartFile getSongFile() {
        return songFile;
    }

    public void setSongFile(@NotNull MultipartFile songFile) {
        this.songFile = songFile;
    }
}
