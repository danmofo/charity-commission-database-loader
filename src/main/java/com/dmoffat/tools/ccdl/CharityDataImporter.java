package com.dmoffat.tools.ccdl;

import java.io.IOException;
import java.nio.file.Path;
import java.sql.SQLException;
import java.util.Map;
import java.util.concurrent.ExecutorService;

/**
 * Imports the charity data into the database + verifies that they were imported correctly.
 */
public class CharityDataImporter {
    private final Database database;
    private final String databaseName;
    private final ExecutorService executorService;

    public CharityDataImporter(Database database, String databaseName, ExecutorService executorService) {
        this.database = database;
        this.databaseName = databaseName;
        this.executorService = executorService;
    }

    public void recreateSchema() throws SQLException {
        System.out.println("Recreating schema in database " + databaseName);
        dropExistingExtractTables();
        createExtractTables();
    }

    private void dropExistingExtractTables() throws SQLException {
        System.out.println("Dropping tables.");
        for(String extractName : App.EXTRACT_NAMES) {
            database.dropTable(databaseName, extractName);
        }
    }

    private void createExtractTables() throws SQLException {
        System.out.println("Creating tables.");
        for(String extractName : App.EXTRACT_NAMES) {
            String createTableSql = Util.getResourceAsString(extractName + ".sql");
            database.execute(createTableSql);
        }
    }

    public void loadData(Map<String, Path> dataFilesMap) throws SQLException {
        System.out.println("Loading data...");

        for (String extractName : App.EXTRACT_NAMES) {
            Path dataFile = dataFilesMap.get(extractName);
            String importDataSql = getImportSqlForExtractName(extractName, dataFile);

            System.out.println("Importing table " + extractName);
            database.execute(importDataSql);
            System.out.println("Done importing table.");
        }

    }

    public void verifyDataWasLoaded(Map<String, Path> dataFilesMap) throws SQLException, IOException {
        System.out.println("Verifying data was imported correctly.");

        for (String extractName : App.EXTRACT_NAMES) {
            Path dataFile = dataFilesMap.get(extractName);

            System.out.println("Verifying table " + extractName);
            long actualRowCount = database.countRows(databaseName, extractName);
            long expectedRowCount = Util.lineCountMinusHeader(dataFile);

            // If this extract contains duplicates, check at least 95% of the rows have been imported.
            // IME, there's only ever a handful of duplicates, more than 5% would indicate a bigger problem.
            if(App.EXTRACT_NAMES_WHICH_CONTAIN_DUPES.contains(extractName)) {
                expectedRowCount = (long) (expectedRowCount * 0.95);

                if(actualRowCount < expectedRowCount) {
                    throw new RuntimeException("Expected at least " + expectedRowCount + " rows to be imported, got " +
                        actualRowCount);
                }
            } else {
                if(expectedRowCount != actualRowCount) {
                    throw new RuntimeException("Expected row count " + expectedRowCount + ", got " + actualRowCount);
                }
            }
        }
    }

    public void importData(Map<String, Path> dataFilesMap) throws SQLException, IOException {
        loadData(dataFilesMap);
        verifyDataWasLoaded(dataFilesMap);
    }

    private String getImportSqlForExtractName(String extractName, Path dataFile) {
        String importDataSql = Util.getResourceAsString("import/load_" + extractName + ".sql");
        importDataSql = importDataSql.replaceFirst("DATA_PATH", dataFile.toAbsolutePath().toString());
        return importDataSql;
    }
}
