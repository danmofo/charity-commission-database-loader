package com.dmoffat.tools.ccdl;

public class App {
    public static void main(String[] args) throws Exception {
        Environment environment = new Environment();
        Database database = new Database(
            environment.getValue("db_host"),
            environment.getValue("db_user"),
            environment.getValue("db_password")
        );
        database.execute("drop table charity_commission.test;");
        database.execute("create table charity_commission.test (id int primary key);");
    }
}
