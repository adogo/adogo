// register init function to be called when the DOM is loaded in Firefox, Opera, Safari, and Google Chrome
document.addEventListener('DOMContentLoaded', init, false);

function init() {
   document.getElementById('htmlrequest').addEventListener('click', onHtmlClick, false);
   document.getElementById('xmlrequest').addEventListener('click', onXmlClick, false);
   document.getElementById('jsonrequest').addEventListener('click', onJsonClick, false);
}

function onHtmlClick() {
   var file = "data/data.html";
   
   var request =  new XMLHttpRequest();
   
   //Setup HTTP request details
   request.open("GET", file, true);
   
   //map callback fxn for when state changes during HTTP request
   request.onreadystatechange = function() {
      //if the request was successful and an HTTP response is available
      if (request.readyState == 4) {
         document.getElementById('result').innerHTML = request.responseText;
         
         //see Firebug console
         console.log(request.responseText);
      }
   }
   
   //send with no data
   request.send(null);
}

function onXmlClick() {
   var file = "data/data.xml";
   
   var request =  new XMLHttpRequest();
   request.open("GET", file, true);
   request.onreadystatechange = function() {
      if (request.readyState == 4) {
         document.getElementById('result').innerHTML = "";
         
         //Get HTTP response body as XML
         var xml = request.responseXML;
         
         //iterate over each <restaurant> node and append its name to the list
         var restaurants = xml.getElementsByTagName('restaurant');
         for(var i=0; i<restaurants.length; i++) {
            document.getElementById('result').innerHTML +=  restaurants[i].getElementsByTagName('name')[0].textContent + "<br/>";
         }
         
         //see Firebug console
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
         document.getElementById('result').innerHTML = "";
         
         //Get HTTP response body and dynamically evaluate it as JavaScript (JSON)
         var restaurants = eval(request.responseText);
         
         //iterate over array and append name to list
         for(var i=0; i<restaurants.length; i++) {
            document.getElementById('result').innerHTML += restaurants[i].name + "<br/>";
         }
         
         //see Firebug console
         console.log(restaurants);
      }
   }
   request.send(null);
}
