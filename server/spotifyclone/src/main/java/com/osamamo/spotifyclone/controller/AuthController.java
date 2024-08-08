package com.osamamo.spotifyclone.controller;

import com.osamamo.spotifyclone.dto.LoginResponse;
import com.osamamo.spotifyclone.dto.LoginRequest;
import com.osamamo.spotifyclone.dto.SignupRequest;
import com.osamamo.spotifyclone.model.User;
import com.osamamo.spotifyclone.repository.UserRepository;
import com.osamamo.spotifyclone.security.JwtUtils;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;

import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private JwtUtils jwtUtils;

    @PostMapping("/signup")
    public ResponseEntity<?> registerUser(@Valid @RequestBody  SignupRequest signupRequest) {
        if (userRepository.findByUsername(signupRequest.getUsername()).isPresent()) {
            return ResponseEntity.badRequest().body("Error: Username is already taken!");
        }

        User user = new User();
        user.setUsername(signupRequest.getUsername());
        user.setPassword(passwordEncoder.encode(signupRequest.getPassword()));
        user.setName(signupRequest.getName());

        userRepository.save(user);

        return ResponseEntity.ok(user);
    }

    @PostMapping("/signin")
    public ResponseEntity<?> authenticateUser(@Valid @RequestBody LoginRequest loginRequest) {
        Optional<User> userOptional = userRepository.findByUsername(loginRequest.getUsername());
        if (userOptional.isEmpty() || !passwordEncoder.matches(loginRequest.getPassword(), userOptional.get().getPassword())) {
            return ResponseEntity.badRequest().body("Error: Invalid username or password!");
        }

        String jwt = jwtUtils.generateJwtToken(userOptional.get().getUsername());

        return ResponseEntity.ok(new LoginResponse(
                jwt,
                userOptional.get().getId(),
                userOptional.get().getName(),
                userOptional.get().getUsername()
        ) );
    }
}
