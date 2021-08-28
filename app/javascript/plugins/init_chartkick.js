import Chartkick from "chartkick"
import "chartkick/chart.js"

const initChartkick = () => {
  const chartElements = document.querySelectorAll(".chart")

  if (chartElements.length) {
    chartElements.forEach((chartEl) => {

      fetch(`https://api.coingecko.com/api/v3/coins/${chartEl.dataset.coingeckoId}/market_chart?vs_currency=usd&interval=daily&days=7`)
        .then(response => response.json())
        .then((data) => {
          console.log(data.price)
          const ArrData = Array.from(data.prices)

          const marketData = ArrData.map((item) => {
            const dateFormatted = new Date(item[0]);
            const dateString = dateFormatted.toISOString().split('T')[0];
            return [dateString, item[1]];
          })

          new Chartkick.LineChart(chartEl.id, marketData);
        });
    });
  }
}

export { initChartkick }
