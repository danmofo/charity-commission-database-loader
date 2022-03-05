package com.dmoffat.tools.ccdl;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URI;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

/**
 * Downloads the charity data from the Charity Commission website and unzips it into the download directory, ready
 * for importing.
 */
public class CharityDataDownloader {
    private final Path downloadDir;

    public CharityDataDownloader() throws IOException {
        this.downloadDir = Files.createTempDirectory("data");
        System.out.println("Using temp directory: " + downloadDir);
    }

    private String getDownloadUrlForExtractName(String extractName) {
        return "https://ccewuksprdoneregsadata1.blob.core.windows.net/data/txt/publicextract." + extractName + ".zip";
    }

    public Map<String, Path> download() throws IOException {
        System.out.println("Downloading files...");
        Map<String, Path> unzippedPaths = new HashMap<>();
        for(String extractName : App.EXTRACT_NAMES) {
            String downloadUrl = getDownloadUrlForExtractName(extractName);
            Path downloadedFile = downloadDir.resolve(extractName + ".zip");
            System.out.println("Downloading to: " + downloadedFile);
            download(downloadUrl, downloadedFile);
            unzip(downloadedFile);
            unzippedPaths.put(extractName, downloadDir.resolve("publicextract." + extractName + ".txt"));
        }
        return unzippedPaths;
    }

    private void unzip(Path zipFile) throws IOException {
        InputStream is = new FileInputStream(zipFile.toFile());
        try(ZipInputStream zip = new ZipInputStream(is)) {
            for(ZipEntry ze; (ze = zip.getNextEntry()) != null; ) {
                Path resolvedPath = downloadDir.resolve(ze.getName()).normalize();
                if(!resolvedPath.startsWith(downloadDir)) {
                    throw new RuntimeException("Entry with an illegal path.");
                }
                if(ze.isDirectory()) {
                    Files.createDirectories(resolvedPath);
                } else {
                    Files.createDirectories(resolvedPath.getParent());
                    Files.copy(zip, resolvedPath);
                }
            }
        }
    }

    private void download(String url, Path outputFile) throws IOException {
        try(InputStream in = URI.create(url).toURL().openStream()) {
            Files.copy(in, outputFile);
        }
    }

    public void cleanup() {
        deleteRecursive(downloadDir.toFile());
    }

    private boolean deleteRecursive(File fileOrDir) {
        System.out.println("deleteRecursive(" + fileOrDir + ")");
        if(fileOrDir.isDirectory()) {
            Arrays.stream(fileOrDir.listFiles()).allMatch(f -> deleteRecursive(f));
            return fileOrDir.delete();
        }

        return fileOrDir.delete();
    }
}