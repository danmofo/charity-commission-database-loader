package com.dmoffat.tools.ccdl;

import java.sql.*;
import java.util.Properties;

public class Database {
    public Database() throws SQLException {
        String user = System.getenv("db_user");
        String password = System.getenv("db_password");
        String host = System.getenv("db_host");

        Properties props = new Properties();
        props.put("user", user);
        props.put("password", password);

        Connection connection = DriverManager.getConnection("jdbc:mysql://" + host + ":3306/", props);

        try(Statement statement = connection.createStatement()) {
            ResultSet resultSet = statement.executeQuery("select 1 as dan");
            while(resultSet.next()) {
                System.out.println(resultSet.getInt("dan"));
            }
        }
    }
}
