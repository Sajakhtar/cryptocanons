import Chartkick from "chartkick"
import "chartkick/chart.js"


const fetchMarketData = (id) => {
  fetch(`https://api.coingecko.com/api/v3/coins/${id}/market_chart?vs_currency=usd&days=7`)
    .then(response => response.json())
    .then((data) => {
      // console.log(data.prices)
      // map over prices
        // convert timestamp into date time new Date(unix_timestamp * 1000);
        // format as an object { "2021-08-20": 11, "2021-08-21": 6, "2021-08-22": 9 }
      const marketData = {}
      data.prices.forEach((item) => {
        const key = new Date(item[0] * 1000);
        marketData[key] = item[1]
      })
      console.log(marketData)


    });
}



const initChartkick = () => {

  // get els with chart class
  const chartElements = document.querySelectorAll(".chart")
  if(chartElements.length) {
    chartElements.forEach((chartEl) => {
      // console.log(chartEl.dataset.coingeckoId)
      // console.log(chartEl.id)
      const d = fetchMarketData(chartEl.dataset.coingeckoId);
      const data = { "2021-08-20": 11, "2021-08-21": 6, "2021-08-22": 9 }
      new Chartkick.LineChart(chartEl.id, data)
    });
  }
  // if chart els
  // then plot chart

}

export { initChartkick }
