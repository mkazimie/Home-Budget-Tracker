package com.example.budgetary.exception;

public class RecordAlreadyExistsException extends RuntimeException {

    public RecordAlreadyExistsException(String message) {
        super(message);
    }

}