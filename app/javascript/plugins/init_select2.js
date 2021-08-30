import "select2";
import "select2/dist/css/select2.css";
import $ from "jquery";

const initSelect = () => {
  $("#search_topic").select2({
    placeholder: "Select a topic",
  });
  console.log($("#search_topic"))

}

export { initSelect }
