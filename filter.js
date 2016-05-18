var container = document.getElementById('elm-content');

var h3s = document.getElementsByTagName("H3");
var h3sArr = [].slice.call(h3s);

var h3sInfo = h3sArr.map( function(elmt, index) {
    var text = elmt.innerText || elmt.textContent || "text not found";
    return { id: elmt.id, text: text };
});

console.log("h3sInfo", h3sInfo);

Elm.Filter.embed(container, h3sInfo);

