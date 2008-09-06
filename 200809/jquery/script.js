//executed when the DOM has been completely constructed
$(document).ready(function() {
   $('#htmlrequest').click(onHtmlClick);
   $('#xmlrequest').click(onXmlClick);
   $('#jsonrequest').click(onJsonClick);
});

function onHtmlClick() {
   var file = "data/data.html";
   
   //hit a url, interpret its contents as HTML and append it to #result
   $('#result').load(file, null, function(responseText, textStatus, xmlhttprequest){
      console.log(responseText);
   });
}

function onXmlClick() {
   var file = "data/data.xml";
   
   //Perform an HTTP GET and use the inline function as a callback fxn
   $.get(file, null, 
      function(data, textStatus){
         var xml = data;
         
         $('#result').empty();
         
         $(xml).find('restaurant').each(function (){
            $('#result').append($(this).find('name').text() + '<br/>');
         });
         console.log(data);
      }, 
      "xml");
}

function onJsonClick() {
   var file = "data/data.json";

   //Perform an HTTP GET, interpret the HTTP response as JSON, use the inline callback fxn
   $.getJSON(file, null, function(data, textStatus){
      var restaurants = data;
      
      $('#result').empty();
      
      for(var i=0; i<restaurants.length; i++) {
         $('#result').append(restaurants[i].name + '<br/>');
      }
      console.log(restaurants);
   });
}
