const hideDevs = () => {
  let unavailable = document.querySelectorAll('[data-hireable="Not available"]');
  unavailable.forEach(dev => {
    dev.classList.toggle('d-none');
  });
  let numberOfResults = document.querySelectorAll(".serp-card-holder").length;
  let numberOfHiddens = document.querySelectorAll(".d-none").length;

  document.getElementById("serp_headline").innerText = `Showing ${numberOfResults - numberOfHiddens} developers`
};


const initDevFilter = () => {
  let checkbox = document.getElementById("serpcheckbox");
  if (checkbox) {
    checkbox.checked = true;
    hideDevs();

    checkbox.addEventListener('change', function() {
        hideDevs();
    });
  }
}

export { initDevFilter, hideDevs };
