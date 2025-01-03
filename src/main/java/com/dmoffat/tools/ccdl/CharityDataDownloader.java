package com.dmoffat.tools.ccdl;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URI;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Future;
import java.util.stream.Collectors;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

/**
 * Downloads the charity data from the Charity Commission website and unzips it into the download directory, ready
 * for importing.
 */
public class CharityDataDownloader {
    private final Path downloadDir;
    private final String baseDataDownloadUrl;
    private final ExecutorService executorService;

    public CharityDataDownloader(String dataDownloadDir, String baseDataDownloadUrl, ExecutorService executorService) throws IOException {
        this.executorService = executorService;
        if(dataDownloadDir == null || dataDownloadDir.isEmpty()) {
            System.out.println("No data_download_dir provided, using temp folder.");
            this.downloadDir = Files.createTempDirectory("data");
        } else {
            this.downloadDir = Paths.get(dataDownloadDir);
        }

        this.baseDataDownloadUrl = baseDataDownloadUrl;

        if(!Files.isWritable(this.downloadDir)) {
            throw new RuntimeException("data_download_dir is not writable.");
        }
    }

    private String getDownloadUrlForExtractName(String extractName) {
        return baseDataDownloadUrl + "publicextract." + extractName + ".zip";
    }

    public Map<String, Path> downloadAndUnzip() {
        System.out.println("Downloading files...");
        Map<String, Path> unzippedPaths = new HashMap<>();
        var tasks = App.EXTRACT_NAMES.stream().map(extractName -> (Callable<Void>) () -> {
            String downloadUrl = getDownloadUrlForExtractName(extractName);
            Path downloadedFile = downloadDir.resolve(extractName + ".zip");
            System.out.println("Downloading " + downloadedFile + "...");
            download(downloadUrl, downloadedFile);
            unzip(downloadedFile);
            unzippedPaths.put(extractName, downloadDir.resolve("publicextract." + extractName + ".txt"));
            return null;
        }).toList();

        try {
            executorService.invokeAll(tasks);
            return unzippedPaths;
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
    }

    private void unzip(Path zipFile) throws IOException {
        InputStream is = new FileInputStream(zipFile.toFile());
        try (ZipInputStream zip = new ZipInputStream(is)) {
            for (ZipEntry ze; (ze = zip.getNextEntry()) != null; ) {
                Path resolvedPath = downloadDir.resolve(ze.getName()).normalize();
                if (!resolvedPath.startsWith(downloadDir)) {
                    throw new RuntimeException("Entry with an illegal path.");
                }
                if (ze.isDirectory()) {
                    Files.createDirectories(resolvedPath);
                } else {
                    Files.createDirectories(resolvedPath.getParent());
                    Files.copy(zip, resolvedPath);
                }
            }
        }
    }

    private void download(String url, Path outputFile) throws IOException {
        try (InputStream in = URI.create(url).toURL().openStream()) {
            Files.copy(in, outputFile);
        }
    }

    public void cleanup() {
        deleteRecursive(downloadDir.toFile());
    }

    private boolean deleteRecursive(File fileOrDir) {
        if (fileOrDir.isDirectory()) {
            Arrays.stream(fileOrDir.listFiles()).allMatch(f -> deleteRecursive(f));
            return fileOrDir.delete();
        }
        return fileOrDir.delete();
    }
}
