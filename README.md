Charity Commission Database Loader
---

This program downloads the [list of registered charities in England and Wales](https://register-of-charities.charitycommission.gov.uk/register/full-register-download) and imports them into a database.

Table creation SQL can be found in `src/main/resources`, data import SQL can be found in `src/main/resources/import`.

## Usage

1. Copy `.env.template` and fill in the values
2. Execute `./run`, this will compile and run the program.

## TODO
- Upgrade to Java 21
- Add software requirements
- Write tests
- Maybe import the data into temp tables first and then rename the tables, this would prevent existing tables being wiped out if the data import fails.
- Add indexes once we've explored the data a bit more...


### Possible indexes

`latest_fin_period_submitted`

	create index latest_fin_period_submitted_idx on charity_commission.charity_annual_return_parta(latest_fin_period_submitted);
	drop index latest_fin_period_submitted_idx on charity_commission.charity_annual_return_parta;