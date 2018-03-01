#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset
IFS=$' \n\t'

curl='/usr/bin/curl'

# | Company       | Symbol   | Exchange  | Price  | Change  | % Change  |
# |---------------|----------|-----------|--------|---------|-----------|
# |               |          |           |        |         |           |
# |               |          |           |        |         |           |
# |               |          |           |        |         |           |
# |               |          |           |        |         |           |
# |               |          |           |        |         |           |
# |               |          |           |        |         |           |

# <div id="sharebox-data"
#      itemscope="itemscope"
#      itemtype="http://schema.org/Intangible/FinancialQuote">
# <meta itemprop="name"
#         content="Apple Inc." />
# <meta itemprop="url"
#         content="https://www.google.com/finance?cid=22144" />
# <meta itemprop="imageUrl"
#         content="https://www.google.com/finance/chart?cht=g&q=NASDAQ:AAPL&tkr=1&p=1d&enddatetime=2018-02-28T16:00:03Z" />
# <meta itemprop="tickerSymbol"
#         content="AAPL" />
# <meta itemprop="exchange"
#         content="NASDAQ" />
# <meta itemprop="exchangeTimezone"
#         content="America/New_York" />
# <meta itemprop="price"
#         content="178.12" />
# <meta itemprop="priceChange"
#         content="-0.27" />
# <meta itemprop="priceChangePercent"
#         content="-0.15" />
# <meta itemprop="isAfterHours"
#         content="true">
# <meta itemprop="afterHoursPrice"
#         content="178.45">
# <meta itemprop="afterHoursPriceChange"
#         content="+0.33">
# <meta itemprop="afterHoursPriceChangePercent"
#         content="0.19">
# <meta itemprop="afterHoursQuoteTime"
#         content="2018-03-01T00:19:58Z">
# <meta itemprop="quoteTime"
#         content="2018-02-28T16:00:03Z" />
# <meta itemprop="dataSource"
#         content="NASDAQ real-time data" />
# <meta itemprop="dataSourceDisclaimerUrl"
#         content="//www.google.com/help/stock_disclaimer.html#realtime" />
# <meta itemprop="priceCurrency"
#         content="USD" />
# </div>



function _parse_quote() {

    if [[ "$#" -eq 0 ]]; then
        echo "ERROR: Must provide a symbol to quote"
        return 1
    else
        echo "Quoting symbol $1."
    fi
}

base_url='https://finance.google.com/finance?q='

string='<meta itemprop="afterHoursPriceChange"
         content="+0.30">'

cat "$string" | grep -o '<meta itemprop="afterHoursPriceChange"
