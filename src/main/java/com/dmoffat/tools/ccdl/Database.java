package com.dmoffat.tools.ccdl;

import java.sql.*;
import java.util.Objects;
import java.util.Properties;

/**
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

    public void execute(String sql) throws SQLException {
        try (
            Connection connection = getConnection();
            Statement statement = connection.createStatement()
        ) {
            statement.execute(sql);
        }
    }

    private Connection getConnection() throws SQLException {
        Properties props = new Properties();
        props.put("user", username);
        props.put("password", password);

        return DriverManager.getConnection("jdbc:mysql://" + host + ":3306/", props);
    }
}
