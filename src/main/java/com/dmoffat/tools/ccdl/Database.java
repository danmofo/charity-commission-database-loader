package com.dmoffat.tools.ccdl;

import java.sql.*;
import java.util.Objects;
import java.util.Properties;

/**
 * Simple helper to interact with the database.
 * Note: This class opens a new connection each time its methods are called.
 */
public class Database {
    private final String host;
    private final String username;
    private final String password;

    public Database(String host, String username, String password) {
        this.host = Objects.requireNonNull(host);
        this.username = Objects.requireNonNull(username);
        this.password = Objects.requireNonNull(password);
    }

    public boolean canConnect() {
        try {
            execute("select 1 from dual");
            return true;
        } catch (SQLException ex) {
            return false;
        }
    }

    public void execute(String sql) throws SQLException {
        try (
            Connection connection = getConnection();
            Statement statement = connection.createStatement()
        ) {
            statement.execute(sql);
        }
    }

    public void dropTable(String schema, String tableName) throws SQLException {
        execute("drop table if exists " + schema + "." + tableName);
    }

    public long countRows(String schema, String tableName) throws SQLException {
        String sql = "select count(*) as count from " + schema + "." + tableName;
        try (
                Connection connection = getConnection();
                Statement statement = connection.createStatement()
        ) {
            ResultSet rs = statement.executeQuery(sql);
            rs.next();
            int count = rs.getInt("count");
            rs.close();
            return count;
        }
    }

    private Connection getConnection() throws SQLException {
        Properties props = new Properties();
        props.put("user", username);
        props.put("password", password);
        props.put("connectTimeout", "2000");

        return DriverManager.getConnection("jdbc:mysql://" + host + ":3306/?allowLoadLocalInfile=true", props);
    }


}
