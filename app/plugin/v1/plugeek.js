(function(window){
  function myGeekLib(){
    var _myGeekLibObject = {};
    
    _myGeekLibObject.registerPage = function()
    {
      const retrievedObject = localStorage.getItem('my_store_obj');
      let myObject = {};
      
      if (retrievedObject == null) { myObject = {name: "", email:"", pages: []}; }
      else { myObject = JSON.parse(retrievedObject); }
      
      myObject.pages.push(window.location.href);
      localStorage.setItem('my_store_obj', JSON.stringify(myObject));
      this.sendInfoToGeek(false);
    };
    
    _myGeekLibObject.registerUser = function(name, email) {
      
      if (name == "" || email == "") return;
      
      const retrievedObject = localStorage.getItem('my_store_obj');
      let myObject = {};
      
      if (retrievedObject == null) { myObject = {name: "", email:"", pages: []}; }
      else { myObject = JSON.parse(retrievedObject); }
      myObject.name = name;
      myObject.email = email;
      localStorage.setItem('my_store_obj', JSON.stringify(myObject));
      this.sendInfoToGeek(true);
    };
    
    _myGeekLibObject.sendInfoToGeek = function(register) {
      const retrievedObject = localStorage.getItem('my_store_obj');
      const result = JSON.parse(retrievedObject)
      
      if (register) { 
          this.sendRequest("add_user", "name=" + result.name + "&email=" + result.email, true) 
      } 
      
      if (result.email != "")
      {
          while (result.pages.length != 0) {
            let url = result.pages.pop()
            this.sendRequest("add_stats", "&email=" + result.email + "&url=" + url, true)
          }
          localStorage.setItem('my_store_obj', JSON.stringify(result));
      }      
    };
    
    _myGeekLibObject.sendRequest = function(url, toSend, async) {

      const site = "https://hero-geek.herokuapp.com/"    
      
      var xhttp = new XMLHttpRequest();
      
      xhttp.open("POST", site + url, async);
      xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
      xhttp.send(toSend);
    };
    
    return _myGeekLibObject;
  }

  if(typeof(window.myGeekLib) === 'undefined') { window.myGeekLib = myGeekLib(); }
})(window); 