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
        System.out.println(getCliBanner());

        Environment environment = new Environment();

        Database database = new Database(
            environment.getValue("db_host"),
            environment.getValue("db_user"),
            environment.getValue("db_password")
        );

        CharityDataImporter charityDataImporter = new CharityDataImporter(database);
        charityDataImporter.recreateSchema();

        CharityDataDownloader charityDataDownloader = new CharityDataDownloader();
        try {
            Map<String, Path> dataFilesMap = charityDataDownloader.download();
            charityDataImporter.importData(dataFilesMap);
        } catch (Exception ex) {
            ex.printStackTrace();
            System.out.println("Failed to download files.");
        } finally {
            charityDataDownloader.cleanup();
        }

    }

    private static String getCliBanner() {
        return Util.inputStreamToString(Util.getResource("cli-banner.txt"));
    }
}
