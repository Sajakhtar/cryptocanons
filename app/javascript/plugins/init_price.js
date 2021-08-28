const initPrice = () => {
  // console.log('hello from price')

  const priceElements = document.querySelectorAll('.price')

  if(priceElements.length) {
    // console.log(priceElements)

    priceElements.forEach((priceEl) => {
      // console.log(priceEl.dataset.coingeckoId)
      // console.log(priceEl.innerText)
      fetch(`https://api.coingecko.com/api/v3/coins/${priceEl.dataset.coingeckoId}`)
        .then(response => response.json())
        .then((data) => {
          const price = data['market_data']['current_price']['usd'];
          const change24hr = data['market_data']['price_change_24h_in_currency']['usd'];
          // console.log({ price, change24hr });
          priceEl.innerText = new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(price);
        });
    });
  }
}



export { initPrice }
