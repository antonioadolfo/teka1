var ws=io.connect("http://localhost:5555");
$(document).ready(function(){
  var email=$("#email");
  var nickname=$("#nickname");
  var usr={};
  var btGrabar=$("#btGrabar");
  nickname.focus();
  /*  constantes en html5*/

  email.bind('keypress',function(e){
    if(e.keyCode==13){
      if((email.val()!="") || (nickname.val()!="")){
        ws.emit('login',{nick: nickname.val(), email: email.val()});
      }
    }
  });
 
  nickname.bind('keypress',function(e){
    if(e.keyCode==13){
      if((nickname.val()!="") || (email.val()!="")){
        ws.emit('login',{nick: nickname.val(), email: email.val()});
      }
    }
  });

  ws.on('ready',function(data){
  //Usuario conectado
    $("#nickarea").fadeOut();
    usr=data;
    $("#chatArea").append(usr.nick + ' - ' + usr.Recuerdos.length + ' - ' + usr.Recuerdos );
  });

  btGrabar.bind('onclick',function(e){
      /* Borrar - de prueba*/
      alert('entro' + usr.Recuerdos.length);
      usr.Recuerdos[usr.Recuerdos.length]={
        Nivel: usr.Recuerdos.length+1, 
        Nivel_Estrellas: 1, 
        Nivel_Puntos: 3256,
        Nivel_Tiempo:152 
      }
      /*-------------------*/
        ws.emit('grabar',usr);
  });
});
