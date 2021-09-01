import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ['canva', 'title', 'tweets', 'search', 'bookmarks'];

  connect() {
  }

  display(event) {
    this.canvaTarget.classList.add('is-moved')
    const title = event.currentTarget.dataset.title
    const cashtag = event.currentTarget.dataset.cashtag
    const coingeckoId = event.currentTarget.dataset.coingeckoId
    const topicId = event.currentTarget.dataset.topicId
    this.titleTarget.innerText = title
    // console.log(cashtag)
    this.handleTweets(title, cashtag, coingeckoId, topicId)
  }

  hide() {
    this.canvaTarget.classList.remove('is-moved')
    setTimeout(() => {
      this.tweetsTarget.innerHTML = `<div class="d-flex justify-content-center align-items-center" style = "height: 90vh;"><div class="spinner-grow text-primary" role="status" style="width: 3rem; height: 3rem;"><span class="sr-only">Loading...</span></div></div>`
    }, 500)
  }

  search() {
    this.searchTarget.classList.add('is-moved')
  }

  hideSearch() {
    this.searchTarget.classList.remove('is-moved')
  }

  handleTweets = (title, cashtag, coingeckoId, topicId) => {
    // console.log(title, cashtag)

    fetch(`/favorite_topics/tweets?title=${title}&cashtag=${cashtag}&coingecko_id=${coingeckoId}&topic_id=${topicId}`)
      .then(response => response.json())
      .then((data) => {
        console.log(data.bookmarks)
        let tweetsHTML = coingeckoId ? data.chart : ''
        tweetsHTML += data.bookmarks
        data.tweets.forEach((tweetHTML) => {
          if (tweetHTML) {
            tweetsHTML += tweetHTML['tweet']
          }
        })
        this.tweetsTarget.innerHTML = tweetsHTML;
      })

  }
}
