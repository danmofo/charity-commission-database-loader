package com.dmoffat.tools.ccdl;

import java.nio.file.Path;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

public class App {
    protected static final List<String> EXTRACT_NAMES = Arrays.asList(
            "charity",
            "charity_annual_return_history",
            "charity_annual_return_parta",
            "charity_annual_return_partb",
            "charity_area_of_operation",
            "charity_classification",
            "charity_event_history",
            "charity_governing_document",
            "charity_other_names",
            "charity_other_regulators",
            "charity_policy",
            "charity_published_report",
            "charity_trustee"
    );

    protected static final List<String> EXTRACT_NAMES_WHICH_CONTAIN_DUPES = Arrays.asList(
            "charity_trustee",
            "charity_policy"
    );

    public static void main(String[] args) throws Exception {
        System.out.println(Util.getResourceAsString("cli-banner.txt"));

        Environment environment = new Environment();

        CharityDataImporter charityDataImporter = new CharityDataImporter(
                new Database(
                        environment.getValue("db_host"),
                        environment.getValue("db_user"),
                        environment.getValue("db_password")
                ),
                environment.getValue("db_name")
        );
        charityDataImporter.recreateSchema();

        String dataDownloadDir = environment.getMaybeValue("data_download_dir");
        String dataDownloadUrl = environment.getValue("data_download_url");
        CharityDataDownloader charityDataDownloader = new CharityDataDownloader(dataDownloadDir, dataDownloadUrl);

        Util.timeOperation("Downloading and importing", () -> {
            try {
                Map<String, Path> dataFilesMap = charityDataDownloader.download();
                charityDataImporter.importData(dataFilesMap);
            } catch (Exception ex) {
                System.out.println("Failed to download files.");
                ex.printStackTrace();
            } finally {
                boolean cleanupFilesOnException = environment.getBoolean("cleanup_files_on_exception");
                if(cleanupFilesOnException) {
                    charityDataDownloader.cleanup();
                }
            }
        });
    }
}
