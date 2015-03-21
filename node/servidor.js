var mysql = require('mysql');
var usuario =require('../js/cUsuario.js');
var io=require('socket.io').listen(5555);

var connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: 'servidor'
});
connection.connect(function(err){
  if(err){
    console.error('error de conexion: ' + err.stack);
    return;
  }
  connection.query('USE tekateki');
  console.log('conectado a la base de datos tekateki \n');
});
//poner callback


io.sockets.on('connection',function(socket){
  socket.on('login',function(usr){
    usuario.Usr.login.Conexion(usr, connection, socket);
      
    socket.on('grabar', function(data){
      console.log('graba');
      usuario.Usr.login.Grabar(data, connection, socket);
    });

    socket.on('msg',function(msg){
    // recibe mensaje de usuario
      console.log('recibio mensaje \n' 
        + mret.nick + ' - ' + msg 
        + '\n y emitido en room ' 
        + mret.rooms[0].descripcion + '\n');
      // emite mensaje recibido a los usuarios conectados en el room 
      io.sockets.in(mret.rooms[0].cod_interes).emit(
        'messageRoom',
        mret.nick + '<br/>' 
        + mret.rooms[0].descripcion + ':<br/>' 
        + msg 
      );
    });
  });
});

// desconexion del usuario 
io.sockets.on('disconnect', function(socket){
              'UPDATE needy.conexion SET fecha_desc = now() '
              + 'WHERE needy.conexion.socket=(?)',
              [mret.socket],
  console.log('Desconectado: ' + mret.nick);
});