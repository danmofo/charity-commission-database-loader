Charity Commission Database Loader
---

This program downloads the [list of registered charities in England and Wales](https://register-of-charities.charitycommission.gov.uk/register/full-register-download) and imports them into a database.

Table creation SQL can be found in `src/main/resources`, data import SQL can be found in `src/main/resources/import`.

For simplicity the database tables are emptied before importing any data. The data does contain a `date_of_extract` column
in each table, so in theory you could keep a history of each import...it's just not something I need right now.

## Usage

1. Copy `.env.template` and fill in the values
2. Execute `./run`, this will compile and run the program.

## TODO
- Add software requirements
- Dockerise so things aren't required to be on your computer
- Write tests