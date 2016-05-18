var container = document.getElementById('elm-content');

var h3s = document.getElementsByTagName("H3");
var h3sArr = [].slice.call(h3s);

var h3sInfo = h3sArr.map( function(elmt, index) {
    var text = elmt.innerText || elmt.textContent || "text not found";

    var content = "";

    var next = elmt.nextSibling;
    for (var i = 0; next && (i < 99); next = next.nextSibling, i++)  {
        if (next.tagName == "H3") {
            break;
        }
        content += next.textContent;
    }
    
    return { id: elmt.id, text: text, content: content };
});


Elm.Filter.embed(container, h3sInfo);

