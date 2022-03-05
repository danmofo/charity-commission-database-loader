package com.dmoffat.tools.ccdl;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Objects;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class Util {

    public static String getResourceAsString(String path) {
        return inputStreamToString(getResource(path));
    }

    private static InputStream getResource(String path) {
        return Objects.requireNonNull(Util.class.getClassLoader().getResourceAsStream(path), "Resource not found: " + path);
    }

    private static String inputStreamToString(InputStream is) {
        return new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8))
                .lines()
                .collect(Collectors.joining("\n"));
    }

    public static long lineCountMinusHeader(Path dataFile) throws IOException {
        long lineCount;
        try (Stream<String> stream = Files.lines(dataFile, StandardCharsets.UTF_8)) {
            lineCount = stream.count() - 1;
        }
        return lineCount;
    }
}