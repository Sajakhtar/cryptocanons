import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ['canva', 'title', 'tweets'];

  connect() {
  }

  display(event) {
    this.canvaTarget.classList.add('is-moved')
    const title = event.currentTarget.dataset.title
    const cashtag = event.currentTarget.dataset.cashtag
    this.titleTarget.innerText = title
    // console.log(cashtag)
    this.handleTweets(title, cashtag)
  }

  hide() {
    this.canvaTarget.classList.remove('is-moved')
  }

  handleTweets = (title, cashtag) => {
    // console.log(title, cashtag)

    fetch(`/favorite_topics/tweets?title=${title}&cashtag=${cashtag}`)
      .then(response => response.json())
      .then((data) => {
        console.log(data)
        data.forEach((tweetHTML) => {
          if (tweetHTML) {
            this.tweetsTarget.insertAdjacentHTML("beforeend", tweetHTML['tweet']);
          }
        })
      })

  }
}
