var container = document.getElementById('elm-content');

// Collect information about the implicit sections of the document. Each section
// starts with an H3 element and continues until the next heading of equal or
// higher value.

var h3s = document.getElementsByTagName("H3");
var h3sArr = [].slice.call(h3s); // convert to array to allow map()

var h3sInfo = h3sArr.map( function(elmt, index) {
    var title = elmt.innerText || elmt.textContent;

    var content = "";
    for (var next = elmt.nextSibling; next; next = next.nextSibling) {
        if (next.tagName == "H3" || next.tagName == "H2" || next.tagName == "H1") {
	    break;
        }
        content += next.textContent;
    }
    
    return { id: elmt.id, title: title, content: content };
});


Elm.Filter.embed(container, h3sInfo);

// When following a link to the comprising page with a hash (HTML anchor
// name) the browser often scrolls to the wrong offset in the document, as
// if the content inserted by the Filter app above was not accounted
// for. The following kluge works around that.

if (window.location.hash) {
    var save = window.location.hash;
    window.location.hash = "#";
    setTimeout(function() {
	window.location.hash = save;
    }, 1);
}
