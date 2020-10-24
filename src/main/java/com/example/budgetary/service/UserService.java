package com.example.budgetary.service;

import com.example.budgetary.entity.Authority;
import com.example.budgetary.entity.User;
import com.example.budgetary.entity.dto.UserDto;
import com.example.budgetary.exception.RecordAlreadyExistsException;
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

    public User findUserByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    public void saveUser(User user){
        userRepository.save(user);
    }

    public void registerUser(UserDto userDto) throws RecordAlreadyExistsException {
        if (findUserByUsername(userDto.getUsername()) != null) {
            throw new RecordAlreadyExistsException("Username already exists");
        } else {
            User user = new User();
            user.setUsername(userDto.getUsername());
            user.setPassword(passwordEncoder.encode(userDto.getPassword()));
            user.setActive(true);
            Authority authority = authorityRepository.findByName("ROLE_USER");
            user.setAuthorities(new HashSet<>(Arrays.asList(authority)));
            saveUser(user);
        }
    }
}