const fetchPrice = (priceElements) => {
  priceElements.forEach((priceEl) => {

    fetch(`https://api.coingecko.com/api/v3/coins/${priceEl.dataset.coingeckoId}`)
      .then(response => response.json())
      .then((data) => {
        const price = data['market_data']['current_price']['usd'];
        const priceFormatted = new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(price);

        const change24hr = data['market_data']['price_change_percentage_24h'];
        const change24hrFormatted = change24hr.toFixed(1)

        priceEl.innerText = priceFormatted

        const change24hrEl = priceEl.nextElementSibling
        change24hrEl.innerText = `${change24hrFormatted}% 24h`

        if (change24hr > 0) {
          change24hrEl.classList.add('text-success')
        } else {
          change24hrEl.classList.add('text-danger')
        }
      });
  });
}

const initPrice = () => {
  const priceElements = document.querySelectorAll('.price')

  if(priceElements.length) {
    fetchPrice(priceElements)
    setInterval(fetchPrice, 60000, priceElements);
  }
}

export { initPrice }
