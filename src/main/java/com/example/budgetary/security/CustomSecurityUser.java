package com.example.budgetary.security;

import org.springframework.security.core.GrantedAuthority;

import java.util.Collection;

public class CustomSecurityUser extends org.springframework.security.core.userdetails.User {

    private final com.example.budgetary.entity.User user;

    public CustomSecurityUser(String username, String password, Collection<? extends GrantedAuthority> authorities,
                              com.example.budgetary.entity.User user) {
        super(username, password, authorities);
        this.user = user;
    }
    public com.example.budgetary.entity.User getUser() {
        return user;
    }
}
