package com.dmoffat.tools.ccdl;

public class Environment {
    public String getValue(String key) {
        String value = System.getenv(key);
        if(value == null || value.trim().isEmpty()) {
            throw new RuntimeException("Environment variable '" + key + "' is not defined.");
        }
        return value;
    }

    public String getMaybeValue(String key) {
        return System.getenv(key);
    }

    public boolean getBoolean(String key) {
        String value = getValue(key);
        return value.equals("true");
    }
}
