// register init function to be called when the DOM is loaded in Firefox and Opera
document.addEventListener('DOMContentLoaded', init, false);

function init() {
   document.getElementById('htmlrequest').addEventListener('click', onHtmlClick, false);
   document.getElementById('xmlrequest').addEventListener('click', onXmlClick, false);
   document.getElementById('jsonrequest').addEventListener('click', onJsonClick, false);
}

function onHtmlClick() {
   var file = "data/data.html";
   
   var request =  new XMLHttpRequest();
   request.open("GET", file, true);
   request.onreadystatechange = function() {
      if (request.readyState == 4) {
         document.getElementById('result').innerHTML = request.responseText;
         console.log(request.responseText);
      }
   }
   request.send(null);
}

function onXmlClick() {
   var file = "data/data.xml";
   
   var request =  new XMLHttpRequest();
   request.open("GET", file, true);
   request.onreadystatechange = function() {
      if (request.readyState == 4) {

         document.getElementById('result').innerHTML = "";
         
         var xml = request.responseXML;
         var restaurants = xml.getElementsByTagName('restaurant');
         for(var i=0; i<restaurants.length; i++) {
            document.getElementById('result').innerHTML +=  restaurants[i].getElementsByTagName('name')[0].textContent + "<br/>";
         }
         console.log(xml);
      }
   }
   request.send(null);
}

function onJsonClick() {
   var file = "data/data.json";
   
   var request =  new XMLHttpRequest();
   request.open("GET", file, true);
   request.onreadystatechange = function() {
      if (request.readyState == 4) {
         var restaurants = eval(request.responseText);
         
         document.getElementById('result').innerHTML = "";
         
         for(var i=0; i<restaurants.length; i++) {
            document.getElementById('result').innerHTML += restaurants[i].name + "<br/>";
         }
         
         console.log(restaurants);
      }
   }
   request.send(null);
}
