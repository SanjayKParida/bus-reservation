package com.example.busreservation.services;

import com.example.busreservation.entities.AppUsers;
import com.example.busreservation.repos.AppUserRespository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class CustomUserDetailService implements UserDetailsService {
    @Autowired
    private AppUserRespository appUserRespository;


    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        final AppUsers appUsers = appUserRespository.findByUserName(username).orElseThrow(()-> new UsernameNotFoundException("User does not exist"));
        return User.builder().username(appUsers.getUserName()).password(appUsers.getPassword()).roles(appUsers.getRole()).build();
    }
}
