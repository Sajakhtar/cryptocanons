import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ['canva', 'title', 'tweets'];

  connect() {
  }

  display(event) {
    this.canvaTarget.classList.add('is-moved')
    const title = event.currentTarget.dataset.title
    const cashtag = event.currentTarget.dataset.cashtag
    const coingeckoId = event.currentTarget.dataset.coingeckoId
    this.titleTarget.innerText = title
    // console.log(cashtag)
    this.handleTweets(title, cashtag, coingeckoId)
  }

  hide() {
    this.canvaTarget.classList.remove('is-moved')
    setTimeout(() => {
      this.tweetsTarget.innerHTML = `<div class="d-flex justify-content-center align-items-center" style = "height: 90vh;"><div class="spinner-grow text-primary" role="status" style="width: 3rem; height: 3rem;"><span class="sr-only">Loading...</span></div></div>`
    }, 500)
  }

  handleTweets = (title, cashtag, coingeckoId) => {
    // console.log(title, cashtag)

    fetch(`/favorite_topics/tweets?title=${title}&cashtag=${cashtag}&coingecko_id=${coingeckoId}`)
      .then(response => response.json())
      .then((data) => {
        // console.log(data)
        // console.log(data.chart)
        let tweetsHTML = coingeckoId ? data.chart : ''
        data.tweets.forEach((tweetHTML) => {
          if (tweetHTML) {
            tweetsHTML += tweetHTML['tweet']
          }
        })
        this.tweetsTarget.innerHTML = tweetsHTML;
      })

  }
}
