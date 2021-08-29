import { Controller } from "stimulus";
import Chartkick from "chartkick"
import "chartkick/chart.js"
import ApexCharts from 'apexcharts'
import moment from 'moment'


// GLOBAL VARIABLES FOR GRAPH
let chart
let priceData

export default class extends Controller {
  static targets = ['graph', 'button'];

  connect() {
    this.callCoingecko()
  }

  display(event) {
    const timeFrame = parseInt(event.currentTarget.dataset.timeframe)

    const start = moment().subtract(timeFrame, 'days').unix() * 1000
    const end = moment().unix() * 1000

    chart.zoomX(
      start,
      end
    )

    const startPrice = priceData.filter((dataPoint) => {
      return moment(dataPoint[0]).format('L') == moment(start).format('L')
    })[0][1]
    const endPrice = priceData[priceData.length - 1][1]
    // console.log(startPrice, endPrice)

    if(endPrice > startPrice) {
      ApexCharts.exec('prices', 'updateOptions', {
        colors: ['#329932'],
        chart: {
          zoom: {
            enabled: true,
            type: 'x',
            autoScaleYaxis: false
          },
        }
      })
    } else {
      ApexCharts.exec('prices', 'updateOptions', {
        colors: ['#FF3232'],
        chart: {
          zoom: {
            enabled: true,
            type: 'x',
            autoScaleYaxis: false
          },
        }
      })
    }


  }

  callCoingecko = () => {
    const chartEl = this.graphTarget
    fetch(`https://api.coingecko.com/api/v3/coins/${chartEl.dataset.coingeckoId}/market_chart?vs_currency=usd&interval=daily&days=366`)
      .then(response => response.json())
      .then((data) => {
        priceData = Array.from(data.prices)
        this.drawGraph(priceData)
      })
  }


  drawGraph = (prices) => {
    var options = {
      chart: {
        id: "prices",
        height: 200,
        type: "area",
        toolbar: {
          show: false
        },
        zoom: {
          enabled: true,
          type: 'x',
          autoScaleYaxis: false
        },
      },
      dataLabels: {
        enabled: false
      },
      series: [
        {
          name: "Price",
          data: prices,
        }
      ],
      fill: {
        type: "gradient",
        gradient: {
          shadeIntensity: 1,
          opacityFrom: 0.7,
          opacityTo: 0.9,
          stops: [0, 90, 100]
        }
      },
      xaxis: {
        type: 'datetime',
        labels: {
          style: {
            colors: [],
            fontSize: '10px',
            fontFamily: 'Helvetica, Arial, sans-serif',
            fontWeight: 400,
            cssClass: 'apexcharts-xaxis-label',
          }
        }
      },
      yaxis: {
        show: false,
      },
      colors: ['#0052FF'],
      grid: {
        show: false,
      },
    };

    chart = new ApexCharts(this.graphTarget, options);

    chart.render();
  }
}
