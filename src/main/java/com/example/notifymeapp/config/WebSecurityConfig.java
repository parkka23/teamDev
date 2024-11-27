package com.example.notifymeapp.config;

import com.example.notifymeapp.service.UserDetailsServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class WebSecurityConfig {
     private final UserDetailsServiceImpl userDetailsService;

    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public DaoAuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        authProvider.setUserDetailsService(userDetailsService);
        authProvider.setPasswordEncoder(passwordEncoder());
        return authProvider;
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .csrf(AbstractHttpConfigurer::disable)
                .httpBasic(Customizer.withDefaults())
                 .formLogin(form -> form
                        .loginPage("/user/login")
                        .loginProcessingUrl("/user/login")
                        .defaultSuccessUrl("/home")
                        .failureUrl("/user/login?error")
                        .permitAll()
                )
                .logout(logout -> logout
                        .logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
                        .logoutSuccessUrl("/home")
                        .permitAll())
                .exceptionHandling(exceptionHandling -> exceptionHandling
                        .accessDeniedPage("/home")
                )
                .authorizeHttpRequests(authorize -> authorize
                        .antMatchers("/logout").authenticated()
                        .antMatchers("/user/register").permitAll()
//                                .antMatchers("/user/register").hasAnyAuthority("ADMIN")
                                .antMatchers("/user/details").hasAnyAuthority("ADMIN", "USER")
                                .antMatchers("/user/{id}/delete").hasAnyAuthority("ADMIN")
                                .antMatchers("/user/{id}").hasAnyAuthority("ADMIN")
                                .antMatchers("/user/list").hasAnyAuthority("ADMIN")
                                .antMatchers("/user/list").hasAnyAuthority("ADMIN")
                                .antMatchers("/user/update/**").hasAnyAuthority("ADMIN", "USER")
                                .antMatchers("/user/update/roles").hasAnyAuthority("ADMIN")


                                .antMatchers("/services/all").hasAnyAuthority("ADMIN", "USER")
                                .antMatchers("/services/create").hasAnyAuthority("ADMIN")
                                .antMatchers("/services/{id}").hasAnyAuthority("ADMIN", "USER")
                                .antMatchers("/services/{id}/edit").hasAnyAuthority("ADMIN")
                                .antMatchers("/services/{id}/delete").hasAnyAuthority("ADMIN")
                                .antMatchers("/services/{id}/add-chat").hasAnyAuthority("ADMIN")
                                .antMatchers("/services/{id}/add-email").hasAnyAuthority("ADMIN")
                                .antMatchers("/services/{id}/delete-chat").hasAnyAuthority("ADMIN")
                                .antMatchers("/services/{id}/delete-email").hasAnyAuthority("ADMIN")
                                .antMatchers("/services/{serviceId}/message-success").hasAnyAuthority("ADMIN")
                                .antMatchers("/services/{serviceId}/message-error").hasAnyAuthority("ADMIN")
                                .antMatchers("/services/send-message").hasAnyAuthority("ADMIN")

                                .antMatchers("/chats/all").hasAnyAuthority("ADMIN", "USER")
                                .antMatchers("/chats/{id}/delete").hasAnyAuthority("ADMIN")

                                .antMatchers("/emails/all").hasAnyAuthority("ADMIN", "USER")
                                .antMatchers("/emails/create").hasAnyAuthority("ADMIN")
                                .antMatchers("/emails/{id}/edit").hasAnyAuthority("ADMIN")
                                .antMatchers("/emails/{id}/delete").hasAnyAuthority("ADMIN")

                                .antMatchers("/message/send").hasAnyAuthority("ADMIN")

                        .anyRequest().permitAll()

                );
        return http.build();
    }
}

