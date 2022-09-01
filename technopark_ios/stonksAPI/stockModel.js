module.exports.stockMassive = class {
    constructor(data) {
        this.mas = []
        for (let i = 0; i < data.length; i++) {
            this.mas.push(data[i])
        }
    }

    getBySymbol(symbol) {
        for (let i = 0; i < this.mas.length; i++) {
            if (this.mas[i]["symbol"] === symbol) {
                return this.mas[i]
            }
        }
        return {}
    }

    getAllStocks() {
        return this.mas
    }

    update(recived) {
        for (let i = 0; i < this.mas.length; i++) {
            if (recived[this.mas[i]["symbol"]] !== undefined) {
                this.mas[i]["price"] = recived[this.mas[i]["symbol"]]
            }
        }
	    //console.log('update handled')
    }
}

