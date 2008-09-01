$(document).ready(function() {
   $('#htmlrequest').click(onHtmlClick);
   $('#xmlrequest').click(onXmlClick);
   $('#jsonrequest').click(onJsonClick);
});

function onHtmlClick() {
   var file = "data/data.html";
   $('#result').load(file, null, function(responseText, textStatus, xmlhttprequest){
      console.log(responseText);
   });
}

function onXmlClick() {
   var file = "data/data.xml";
   
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
   
   $.getJSON(file, null, function(data, textStatus){
      var restaurants = data;
      
      $('#result').empty();
      
      for(var i=0; i<restaurants.length; i++) {
         $('#result').append(restaurants[i].name + '<br/>');
      }
      console.log(restaurants);
   });
}
