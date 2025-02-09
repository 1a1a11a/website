
function show_sec(id) {
    const sections = document.getElementsByClassName("section");
    for (var i = 0; i < sections.length; i++) {
      sections[i].style.display = "none";
    }
    document.getElementById(id).style.display = "block";
  }
  function show_secs(id_list) {
    const sections = document.getElementsByClassName("section");
    for (var i = 0; i < sections.length; i++) {
      sections[i].style.display = "none";
    }
    for (var i = 0; i < id_list.length; i++) {
      document.getElementById(id_list[i]).style.display = "block";
    }
  }

  function load_content(pagename, sec_id) {
    fetch(pagename)
      .then(response => response.text())
      .then(data => {
        document.getElementById(sec_id).innerHTML = data;
      })
      .catch(error => console.error('Error loading content:', error));
  }
