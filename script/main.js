
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
        if (elementId === "header") {
          setActiveNavigation();
        }
      } else {
        console.error(`Element with ID '${elementId}' not found`);
      }
    })
    .catch(error => {
      console.error('Error loading HTML:', error);
    });
}

function setActiveNavigation() {
  const currentPage = window.location.pathname.split("/").pop() || "index.html";

  document.querySelectorAll("#header .nav-link").forEach(link => {
    const href = link.getAttribute("href");
    if (!href || href.startsWith("http") || href.endsWith(".pdf")) return;

    const linkPage = href.split("#")[0] || "index.html";
    if (linkPage === currentPage) {
      link.classList.add("active");
      link.setAttribute("aria-current", "page");
    }
  });
}

// Load footer when DOM is ready
document.addEventListener("DOMContentLoaded", function() {
  includeHTML("footer.html", "footer");
  includeHTML("header.html", "header");
});
