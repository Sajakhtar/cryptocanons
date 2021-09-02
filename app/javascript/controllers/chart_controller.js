import { Controller } from "stimulus";
import Chartkick from "chartkick"
import "chartkick/chart.js"
import ApexCharts from 'apexcharts'
import moment from 'moment'


// GLOBAL VARIABLES FOR GRAPH
let chart
let priceData

export default class extends Controller {
  static targets = ['graph', 'button', 'price', 'delta'];

  connect() {
    this.activeButton(0)
    this.callCoingecko("daily", 366).then(() => {

      this.drawGraph(priceData)
    })
  }



  display(event) {

    const buttonIndex = parseInt(event.currentTarget.dataset.index)
    this.activeButton(buttonIndex)

    const timeFrame = parseInt(event.currentTarget.dataset.timeframe)


    if(timeFrame === 1) {
      // console.log(timeFrame, "minutely")
      this.callCoingecko("minutely", timeFrame).then(() => {
        this.updateGraph(priceData)
      })
    } else if (timeFrame === 7) {
      // console.log(timeFrame, "hourly")
      this.callCoingecko("hourly", timeFrame).then(() => {
        this.updateGraph(priceData)
      })
    } else {
      // console.log(timeFrame, "daily")
      this.callCoingecko("daily", timeFrame).then(() => {
        this.updateGraph(priceData)
      })
    }

    let start = moment().subtract(timeFrame, 'days').unix() * 1000
    if(start < priceData[0][0]) {
      start = priceData[0][0]
    }

    let startPrice = priceData[0][1]
    if(start) {
      startPrice = priceData.filter((dataPoint) => {
        return moment(dataPoint[0]).format('L') == moment(start).format('L')
      })[0][1]
    }
    const endPrice = priceData[priceData.length - 1][1]
    const delta = ((endPrice / startPrice - 1) * 100)

    this.priceTarget.innerText = `$${endPrice.toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`
    this.deltaTarget.innerText = `${delta.toFixed(1)}% ${event.currentTarget.dataset.change}`
    if(delta > 0) {
      this.deltaTarget.classList.remove("text-danger")
      this.deltaTarget.classList.add("text-success")
    } else {
      this.deltaTarget.classList.remove("text-success")
      this.deltaTarget.classList.add("text-danger")
    }
  }

  updateGraph = (prices) => {
    // console.log(prices)
    ApexCharts.exec('prices', 'updateOptions', {
      series: [
        {
          name: "Price",
          data: prices,
        }
      ]
    })
  }

  callCoingecko = async (interval, timeFrame) => {
    const chartEl = this.graphTarget
    await fetch(`https://api.coingecko.com/api/v3/coins/${chartEl.dataset.coingeckoId}/market_chart?vs_currency=usd&interval=${interval}&days=${timeFrame}`)
      .then(response => response.json())
      .then((data) => {
        priceData = Array.from(data.prices)
        // console.log(priceData)
        // this.drawGraph(priceData)

        // this.buttonTargets[0].classList.add('active')

        // const start = moment().subtract(365, 'days').unix() * 1000
        // const end = moment().unix() * 1000

        const startPrice = priceData[0][1]
        const endPrice = priceData[priceData.length - 1][1]
        const delta = ((endPrice / startPrice - 1) * 100)

        this.priceTarget.innerText = `$${endPrice.toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`
        this.deltaTarget.innerText = `${delta.toFixed(1)}% 1Y`
        if (delta > 0) {
          this.deltaTarget.classList.remove("text-danger")
          this.deltaTarget.classList.add("text-success")
        } else {
          this.deltaTarget.classList.remove("text-success")
          this.deltaTarget.classList.add("text-danger")
        }
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
      tooltip: {
        y: {
          formatter: function (val) {
            return val.toLocaleString('en-US', { style: 'currency', currency: 'USD' })
          }
        }
      },
      annotations: {
        xaxis: this.annotateGraph()
      }
    };

    chart = new ApexCharts(this.graphTarget, options);

    chart.render();
  }

  annotateGraph = () => {
    const bookmarks = JSON.parse(this.graphTarget.dataset.bookmarks)
    // console.log(bookmarks)

    return bookmarks.map((bookmark) => {
      return {
        x: new Date(bookmark.created_at).getTime(),
        borderColor: '#fff001',
        label: {
          style: {
            color: '#000',
            background: '#fff001',
            opacity: 0.3,
          },
          text: `${bookmark.id}`
        }
      }
    })


  }

  activeButton = (index) => {
    this.buttonTargets.forEach((el, i) => {
      el.classList.toggle('active', index === i )
    })
  }

}
