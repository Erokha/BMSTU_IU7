let express = require('express')
let app = express()
const fetch = require('node-fetch');
let config = require('./superSecretConfig')
let stockModel = require('./stockModel')
var stocks = []


function readStocks() {
    let url = 'https://financialmodelingprep.com/api/v3/' +
        'profile/' + config.avalibleStocksSybols + '?apikey=' + config.apikey
    fetch(url)
        .then((response) => {
            return response.json()
        })
        .then((data) => {
            stocks = new stockModel.stockMassive(data)
            console.log("local mas updated")
        });
}

function updateStocks() {
    let url = `https://financialmodelingprep.com/api/v3/quote/${config.avalibleStocksSybols}?apikey=${config.apikey}`
    fetch(url)
        .then((response) => {
            return response.json()
        })
        .then((data) => {
            let dict = {};
            for (let i = 0; i < data.length; i++) {
                dict[data[i]["symbol"]] = data[i]["price"]
            }
            stocks.update(dict)
        });
}

app.get('/', function (req, res) {
    let a =
            `<h1>Зачем ты сюда зашел🌚</h1>
            <p><span id="datetime"></span></p>
            <script>
            var dt = new Date();
            document.getElementById("datetime").innerHTML = dt.toLocaleString();
            </script>`
    res.send(a)
})

app.get('/stock/random', function (req, res) {
    res.send(fakeStock())
})

app.get('/news', function (req, res) {
    let url = `https://financialmodelingprep.com/api/v3/stock_news?tickers=${config.avalibleStocksSybols}&limit=50&apikey=${config.apikey}`
    fetch(url)
        .then((response) => {
            return response.json()
        })
        .then((data) => {
            res.send(data)
        });
    // let nonewsobj =
    //     [
    //         {
    //             text:"THIS ARTICLE HAS BROKEN URL!!!!!!!",
    //             url: "brokenurl",
    //             image:"https://49yoqg1t6shk2yfdou1ieaws-wpengine.netdna-ssl.com/wp-content/uploads/2017/04/no-news-good-news.png"
    //         },
    //     ]
    // res.send(nonewsobj)
})

app.get('/learn', function (req, res) {

    let learnobj =
        [
            {
                text:"How to Start Investing in Stocks: A Beginner's Guide",
                url: "https://www.nerdwallet.com/article/investing/5-steps-start-trading-stocks-online",
                image:"https://www.nerdwallet.com/assets/blog/wp-content/uploads/2015/10/GettyImages-1140848960-2400x1440.jpg"
            },
            {
                text:"The Best Way To Learn About Investing",
                url: "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
                image:"https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fspecials-images.forbesimg.com%2Fimageserve%2F601543736%2F960x0.jpg%3Ffit%3Dscale"
            },
            {
                text:"How to Start Trading on the Stock Market with Low Mone",
                url: "https://due.com/blog/how-to-start-trading-on-the-stock-market/",
                image:"https://due.com/wp-content/uploads/2017/03/money-going-up.jpg"

            },
            {
                text:"How to Invest in Stocks - This article provides information and education for investors. NerdWallet does not offer advisory or brokerage services, nor does it recommend or advise investors to buy or sell particular stocks or securities.",
                url: "https://www.nerdwallet.com/article/investing/how-to-invest-in-stocks/",
                image:"https://www.nerdwallet.com/assets/blog/wp-content/uploads/2017/02/GettyImages-617563676-2400x1440.jpg"
            },
            {
                text:"Investing 101: Investing Basics For Beginners That is the super concise investing definition that comes courtesy of Merriam-Webster. Regardless of where you invest your money, you're essentially giving your money to a company, government, or other entity in the hope they provide you with more money in the future. People generally invest money with a specific goal in mind, for example, retirement, their children's education, a house — the list goes on.",
                url: "https://www.wealthsimple.com/en-ca/learn/investing-basics/",
                image:"https://images.ctfassets.net/v44fuld738we/7sKnCgU5mttbc1pcV0hGtr/b16c8ab4c2685f0febee3de8c14a8660/Learn-04-Money_Under_Your_Mattress_vs._Savings_vs._Investing.png"
            },

        ]
    res.send(learnobj)
})

app.get('/stock/:symbol', function (req, res) {
    let mas = req.params["symbol"].split(',')
    let result = []
    for (let i = 0; i < mas.length; i++) {
        result.push(stocks.getBySymbol(mas[i]))
    }
    res.send(result)
})

app.get('/history/:symbol', function (req, res) {
    console.log('request got')
    let stockrequest = req.params["symbol"]
    let url = `https://financialmodelingprep.com/api/v3/historical-chart/1min/${stockrequest}?apikey=${config.apikey}`
    console.log(url)
    fetch(url)
        .then((response) => {
            return response.json()
        })
        .then((data) => {
            let result = data.slice(-30)
            res.send(result)
            console.log('response send')
        });

})

app.get('/allStocks', function (req, res) {
    res.send(stocks.getAllStocks())
})

app.get('/secret/config/update', function (req, res) {
    updateStocks()
    res.send('Update started')
})



app.listen(8000, function () {
    readStocks()

     // setInterval(() => {
     //     updateStocks()
     // }, 10000);

    console.log("Server started!")
})
