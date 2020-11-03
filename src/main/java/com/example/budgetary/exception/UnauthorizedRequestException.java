package com.example.budgetary.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value= HttpStatus.UNAUTHORIZED, reason="Unauthorized Request")
public class UnauthorizedRequestException extends RuntimeException {

    public UnauthorizedRequestException(String message) {
        super(message);
    }
}