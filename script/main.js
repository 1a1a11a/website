
function includeHTML(file, elementId) {
  fetch(file)
    .then(response => {
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      return response.text();
    })
    .then(data => {
      const element = document.getElementById(elementId);
      if (element) {
        element.innerHTML = data;
      } else {
        console.error(`Element with ID '${elementId}' not found`);
      }
    })
    .catch(error => {
      console.error('Error loading HTML:', error);
    });
}

// Load footer when DOM is ready
document.addEventListener("DOMContentLoaded", function() {
  includeHTML("footer.html", "footer");
  includeHTML("header.html", "header");
});
