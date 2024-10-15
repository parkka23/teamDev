package com.example.notifymeapp.service;

import com.example.notifymeapp.entity.Role;
import com.example.notifymeapp.entity.User;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Set;

public class MyUserDetails implements UserDetails {
    private final User user;

    public MyUserDetails(User user) {
        this.user = user;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        Set<Role> roles = user.getRoles();
        List<SimpleGrantedAuthority> authorities = new ArrayList<>();

        for (Role role : roles) {
            authorities.add(new SimpleGrantedAuthority(role.getName()));
        }

        return authorities;
    }
    public void setAuthorities(Set<Role> roles) {
        user.setRoles(roles);
    }
    public String getFullName(){
        return user.getFullName();
    }
    @Override
    public String getPassword() {
        return user.getPassword();
    }
    public void setPassword(String password) {
        user.setPassword(password);
    }

    @Override
    public String getUsername() {
        return user.getEmail();
    }

    public void setUsername(String email){
        user.setEmail(email);
    }

    public void setFullName (String fullName) {
        user.setFullName(fullName);
    }
    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return user.isEnabled();
    }
}
