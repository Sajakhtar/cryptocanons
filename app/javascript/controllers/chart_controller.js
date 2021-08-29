import { Controller } from "stimulus";
import Chartkick from "chartkick"
import "chartkick/chart.js"

export default class extends Controller {
  static targets = ['graph'];

  connect() {
    // console.log(this.graphTarget)
    this.chartkick()
  }

  chartkick = () => {
    const chartEl = this.graphTarget

    fetch(`https://api.coingecko.com/api/v3/coins/${chartEl.dataset.coingeckoId}/market_chart?vs_currency=usd&interval=daily&days=7`)
      .then(response => response.json())
      .then((data) => {
        const ArrData = Array.from(data.prices)

        const marketData = ArrData.map((item) => {
          const dateFormatted = new Date(item[0])
          const dateString = dateFormatted.toISOString().split('T')[0]
          return [dateString, item[1]]
        })

        const flatData = marketData.flat().filter(item => typeof item === 'number')

        const min = Math.round(Math.min(...flatData) - Math.min(...flatData) * 0.02)

        // console.log(marketData)
        // console.log(min)
        new Chartkick.LineChart(chartEl.id, marketData, { min: min, prefix: "$", colors: ["#518FFF"], thousands: "," });

      })
  }
}
