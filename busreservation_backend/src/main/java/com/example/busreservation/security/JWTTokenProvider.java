package com.example.busreservation.security;

import com.example.busreservation.models.ReservationApiException;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.MalformedJwtException;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import io.jsonwebtoken.security.UnsupportedKeyException;
import lombok.experimental.UtilityClass;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;

import java.security.Key;
import java.util.Date;

@Component
public class JWTTokenProvider {
    @Value("${app.jwt-secret}")
    private String jwtSecretkey;
    @Value("${app-jwt-expiration-milliseconds}")
    private Long expiration;

    public String generateToken(Authentication authentication){
        String userName = authentication.getName();
        Date expireDate = new Date(new Date().getTime() + expiration);
        return Jwts.builder().setSubject(userName).setIssuedAt(new Date()).setExpiration(expireDate).signWith(key()).compact();
    }

    public String getUserName(String token){
        Claims claims = Jwts.parser().setSigningKey(key()).build().parseClaimsJws(token).getBody();
        return claims.getSubject();
    }

    public boolean validateToken(String token){
        try{
            Jwts.parser().setSigningKey(key()).build().parse(token);
            return true;
        }catch(MalformedJwtException e){
            throw new ReservationApiException(HttpStatus.BAD_REQUEST, "Invalid Token");
        }
        catch(ExpiredJwtException e){
            throw new ReservationApiException(HttpStatus.BAD_REQUEST, "Token Expired");
        }
        catch(UnsupportedKeyException e){
            throw new ReservationApiException(HttpStatus.BAD_REQUEST, "Unsupported Token");
        }
        catch(IllegalArgumentException e){
            throw new ReservationApiException(HttpStatus.BAD_REQUEST, "Invalid Argument");
        }
    }

    private Key key(){
        return Keys.hmacShaKeyFor(Decoders.BASE64.decode(jwtSecretkey));
    }

}
