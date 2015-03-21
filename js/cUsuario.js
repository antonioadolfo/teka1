var Usr = Usr || {};
//--------------------------------------------------------------------------
Usr.login = (function() {
  var Usuario={};
/*
{
    Cantidad_Guardadas: Cantidad_Guardadas, 
    Nivel_Limite: Nivel_Limite, 
    Nivel_Maximo: Nivel_Maximo, 
    Nivel_Actual: Nivel_Actual, 
    Puntos: Puntos, 
    recuerdos : [ 
        { 
            nivel: i, 
            Nivel_Estrellas: Nivel_Estrellas[ i ], 
            Nivel_Puntos: Nivel_Puntos[ i ] 
        } 
    ], 
    Poder_Muestra: Poder[ Poder_Muestra ], 
    Poder_QuitaCandado: Poder[ Poder_QuitaCandado ], 
    Poder_MueveOscuros: Poder[ Poder_MueveOscuros ], 
    mapa_mapa_x: mapa_mapa_x 
}
*/
  var Recuerdos=[];
  Usuario.Conectado=false;
  Usuario.ConRecuerdos=false;
  return {
    Conexion: function(usr, conex, aSocket){
    // busqueda para autorizar conexion
      conex.query('SELECT usuario.id_usuario, '
          + 'usuario.email, '
          + 'usuario.nick, '
          + 'usuario.creacion, '
          + 'usuario.ultimaconexion, '
          + 'usuario.Poder_Muestra, '
          + 'usuario.Poder_QuitaCandado, '
          + 'usuario.Poder_MueveOscuros '
          + 'FROM tekateki.usuario '
          + 'WHERE '
          + 'usuario.nick=(?) or usuario.email=(?) ',
          [usr.nick, usr.email],
        function (err, mDT) {
          if(err){
            console.error('error en busqueda usuario: ' + err.stack);
            throw err;
          }else if(mDT.length==0){
              console.log('nick o email incorrecto');
          }else{
            Usuario = mDT[0];
            // Actualiza ultima conexion
            conex.query('UPDATE tekateki.usuario '
              + 'SET '
              + 'ultimaconexion = now() '
              + 'WHERE id_usuario = (?) ',
              [Usuario.id_usuario],
              function (err, mDT) {
                if(err){
                  console.error('error en actualizacion de fecha de conexion: ' + err.stack);
                  throw err;
                }
                else{
                  Usuario.Conectado=true;
                  // Busca puntaje en los distintos recuerdos
                  conex.query('SELECT jugada.id_jugada, '
                    + 'jugada.id_usuario, '
                    + 'jugada.id_recuerdo, '
                    + 'jugada.fecha_juego, '
                    + 'jugada.estrellas, '
                    + 'jugada.puntos, '
                    + 'jugada.tiempo '
                    + 'FROM tekateki.jugada '
                    + 'WHERE jugada.id_usuario = (?) '
                    + 'ORDER BY jugada.id_recuerdo ',
                    [Usuario.id_usuario],
                    function (err, mDT) {
                      if(err){
                        console.error('error en busqueda de recuerdos del usuario: ' + err.stack);
                        throw err;
                      }else{
                        Usuario.Recuerdos=[];
                        var msg_consola = 'Conectado: ' + Usuario.nick;                               + ' recibiendo noticias de ';
                        for (i in mDT){
                          if(Usuario.ConRecuerdos==false){
                            Usuario.ConRecuerdos=true;
                          }
                          Usuario.Recuerdos[Usuario.Recuerdos.length]={
                            Nivel: mDT[i].id_recuerdo, 
                            Nivel_Estrellas: mDT[i].estrellas, 
                            Nivel_Puntos: mDT[i].puntos,
                            Nivel_Tiempo: mDT[i].tiempo
                          }
                        }
                        console.log(msg_consola);
                        if(aSocket){
                          aSocket.emit('ready', Usuario);
                        };
                      }
                    }
                  );
                }
              }
            );
          }
        }
      );
    },
    getUsuario: function(){
    // devuelve usuario conectado
      return Usuario;
    },
    Grabar: function(aData, conex, aSocket){
    //Actualiza datos del usuario
      Usuario = aData;
      conex.query('UPDATE tekateki.usuario '
        + 'SET '
        + 'ultimaconexion = now() '
        + 'WHERE id_usuario = (?) ',
        [Usuario.id_usuario],
        function (err, mDT) {
          if(err){ 
            console.error('error al actualizar fecha de última conexion: ' + err.stack);
            throw err;
          }
          else{
            conex.query('DELETE FROM tekateki.jugada '
              + 'WHERE id_usuario = (?)',
              [Usuario.id_usuario],
              function (err, mDT) {
                if(err){ 
                  console.error('error al borrar recuerdos de las jugadas: ' + err.stack);
                  throw err;
                }
                else{
                  for (i in Usuario.Recuerdos) {
                    conex.query('INSERT INTO tekateki.jugada '
                      + '(id_usuario,'
                      + 'id_recuerdo,'
                      + 'fecha_juego,'
                      + 'estrellas,'
                      + 'puntos,'
                      + 'tiempo) '
                      + 'VALUES ' 
                      + '((?),(?),now(),(?),(?),(?)) ',
                      [Usuario.id_usuario,Usuario.Recuerdos[i].Nivel,Usuario.Recuerdos[i].Nivel_Estrellas,Usuario.Recuerdos[i].Nivel_Puntos,Usuario.Recuerdos[i].Nivel_Tiempo],
                      function (err, mDT) {
                        if(err){ 
                          console.error('error al actualizar recuerdo ' + Usuario.Recuerdos[i].Nivel + ' usuario: ' + Usuario.nick + err.stack);
                          throw err;
                        }
                        else{
                          if(aSocket){
                            aSocket.emit('Grabar_Ok', 'Ok');
                          }
                        }
                      }
                    );
                  }
                }
              }
            );
/*            Anuncios = mDT;
            if(aSocket){
              aSocket.emit('ready_lst_anuncio', Anuncios);
            }
*/
          }
        }
      );
    }
  };
})();
exports.Usr=Usr;
