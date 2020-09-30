package com.example.budgetary.service;

import com.example.budgetary.entity.Authority;
import com.example.budgetary.entity.User;
import com.example.budgetary.repository.AuthorityRepository;
import com.example.budgetary.repository.UserRepository;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.HashSet;

@Service
public class UserService {

    private final UserRepository userRepository;
    private final AuthorityRepository authorityRepository;
    private final BCryptPasswordEncoder passwordEncoder;

    public UserService(UserRepository userRepository, AuthorityRepository authorityRepository,
                           BCryptPasswordEncoder passwordEncoder) {
        this.passwordEncoder = passwordEncoder;
        this.userRepository = userRepository;
        this.authorityRepository = authorityRepository;
    }

    public User findByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    public void saveUser(User user){
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setActive(true);
        Authority authority = authorityRepository.findByName("ROLE_USER");
        user.setAuthorities(new HashSet<>(Arrays.asList(authority)));
        userRepository.save(user);
    }
}
