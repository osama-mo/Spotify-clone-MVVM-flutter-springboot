package com.osamamo.spotifyclone.dto;

public class LoginResponse {
    private Long id;
    private String name;
    private String username;
    private String token;

    public LoginResponse(String token , Long id, String name, String username) {
        this.id = id;
        this.name = name;
        this.username = username;
        this.token = token;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public Long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
}

