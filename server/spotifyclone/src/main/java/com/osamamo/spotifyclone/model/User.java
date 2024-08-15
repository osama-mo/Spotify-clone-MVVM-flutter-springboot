package com.osamamo.spotifyclone.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.HashSet;
import java.util.Set;


@Document(collection = "users")
public class User {
    @Id
    private String id;

    @NotBlank
    @Size(max = 50)
    @Column
    private String name;

    @NotBlank
    @Size(max = 50)
    @Column(unique = true)
    private String username;

    @NotBlank
    @Size(max = 100)
    private String password;


    private Set<String> favoriteSongIds = new HashSet<>();

    public @NotBlank @Size(max = 50) String getUsername() {
        return username;
    }

    public void setUsername(@NotBlank @Size(max = 50) String username) {
        this.username = username;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public @NotBlank @Size(max = 100) String getPassword() {
        return password;
    }

    public void setPassword(@NotBlank @Size(max = 100) String password) {
        this.password = password;
    }

    public @NotBlank @Size(max = 50) String getName() {
        return name;
    }

    public void setName(@NotBlank @Size(max = 50) String name) {
        this.name = name;
    }

    public Set<String> getFavoriteSongIds() {
        return favoriteSongIds;
    }

    public void setFavoriteSongIds(Set<String> favoriteSongIds) {
        this.favoriteSongIds = favoriteSongIds;
    }
}
