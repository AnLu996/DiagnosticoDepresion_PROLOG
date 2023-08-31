

 :- use_module(library(pce)).
 :- pce_image_directory('./imagenes').
 :- use_module(library(pce_style_item)).
 :- dynamic color/2.

 resource(img_principal, image, image('img_principal.jpg')).
 resource(portada, image, image('portada.jpg')).
 resource(llanto, image, image('llanto.jpg')).
 resource(dormir, image, image('dormir.jpg')).
 resource(corazon, image, image('corazon.jpg')).
 resource(cansancio, image, image('cansancio.jpg')).
 resource(clara, image, image('clara.jpg')).
 resource(facil, image, image('facil.jpg')).
 resource(decisiones, image, image('decisiones.jpg')).
 resource(utilidad, image, image('utilidad.jpg')).
 resource(suicidio, image, image('suicidio.jpg')).
 resource(disfrutar, image, image('disfrutar.jpg')).

 mostrar_imagen(Pantalla, Imagen) :- new(Figura, figure),
                                     new(Bitmap, bitmap(resource(Imagen),@on)),
                                     send(Bitmap, name, 1),
                                     send(Figura, display, Bitmap),
                                     send(Figura, status, 1),
                                     send(Pantalla, display,Figura,point(100,80)).
 nueva_imagen(Ventana, Imagen) :-new(Figura, figure),
                                new(Bitmap, bitmap(resource(Imagen),@on)),
                                send(Bitmap, name, 1),
                                send(Figura, display, Bitmap),
                                send(Figura, status, 1),
                                send(Ventana, display,Figura,point(0,0)).
  imagen_pregunta(Ventana, Imagen) :-new(Figura, figure),
                                new(Bitmap, bitmap(resource(Imagen),@on)),
                                send(Bitmap, name, 1),
                                send(Figura, display, Bitmap),
                                send(Figura, status, 1),
                                send(Ventana, display,Figura,point(500,60)).
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
  botones:-borrado,
                send(@boton, free),
                mostrar_diagnostico(Enfermedad),
                send(@texto, selection('El Diagnostico a partir de los datos es:')),
                send(@resp1, selection(Enfermedad)),
                new(@boton, button('Iniciar consulta',
                message(@prolog, botones)
                )),

                
                send(@main, display,@boton,point(20,450)).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


   preguntar(Preg,Resp):-new(Di,dialog('Colsultar Datos:')),
                        new(L2,label(texto,'Responde las siguientes preguntas')),
                        id_imagen_preg(Preg,Imagen),
                        imagen_pregunta(Di,Imagen),
                        new(La,label(prob,Preg)),
                        new(B1,button(si,and(message(Di,return,si)))),
                        new(B2,button(no,and(message(Di,return,no)))),
                        send(Di, gap, size(25,25)),
                        send(Di,append(L2)),
                        send(Di,append(La)),
                        send(Di,append(B1)),
                        send(Di,append(B2)),
                        send(Di,default_button,'si'),
                        send(Di,open_centered),get(Di,confirm,Answer),
                        free(Di),
                        Resp=Answer.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  interfaz_principal:-new(@main,dialog('Sistema Experto Diagnosticador de Depresión',
        size(1000,1000))),
        new(@texto, label(nombre,'El Diagnostico a partir de los datos es:',font('times','roman',18))),
        new(@resp1, label(nombre,'',font('times','roman',22))),
        new(@lblExp1, label(nombre,'',font('times','roman',14))),
        new(@lblExp2, label(nombre,'',font('times','roman',14))),
        new(@salir,button('SALIR',and(message(@main,destroy),message(@main,free)))),
        new(@boton, button('Iniciar consulta',message(@prolog, botones))),


        nueva_imagen(@main, img_principal),
        send(@main, display,@boton,point(138,450)),
        send(@main, display,@texto,point(25,235)),
        send(@main, display,@salir,point(300,450)),
        send(@main, display,@resp1,point(25,285)),
        send(@main,open_centered).

       borrado:- send(@resp1, selection('')).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  crea_interfaz_inicio:- new(@interfaz,dialog('Bienvenido al Sistema Experto Diagnosticador',
  size(1000,1000))),

  mostrar_imagen(@interfaz, portada),

  new(BotonComenzar,button('COMENZAR',and(message(@prolog,interfaz_principal) ,
  and(message(@interfaz,destroy),message(@interfaz,free)) ))),
  new(BotonSalir,button('SALIDA',and(message(@interfaz,destroy),message(@interfaz,free)))),
  send(@interfaz,append(BotonComenzar)),
  send(@interfaz,append(BotonSalir)),
  send(@interfaz,open_centered).

  :-crea_interfaz_inicio.

/* BASE DE CONOCIMIENTOS: Sintomas y Enfermedades del Pez Goldfish, contiente ademas
el identificador de imagenes de acuerdo al  sintoma
*/

conocimiento('Ausencia de depresion',
['Nunca o muy pocas veces tuve la dificultad de tomar decisiones',
'El corazon me late como de costumbre','Estoy en desacuerdo con la idea "Me canso aunque no haga nada"',
'Nunca o algunas veces tengo episodios de llanto o deseos de llorar',
'Nunca o quiza alguna vez senti que los demas estarian mejor si yo muriera',
'Nunca o quiza alguna vez me costo trabajo dormir por las noches']).

conocimiento('Depresion leve',
['No creo haber dejado de disfrutar las cosas que disfrutaba antes',
'Nunca o quiza algunas veces creo que canso aunque no haga nada']).

conocimiento('Depresion moderada',
['Aunque frecuentemente me cuesta trabajo dormirme en la noche, no creo que pase la mayoria del tiempo o en todas las noches',
'Recuerdo tener episodios de llanto o deseos de llorar, pero no todo el tiempo']).

conocimiento('Depresion severa',
['Nunca o quiza solo pocas veces me siento util y necesario',
'Nunca o solo pocas veces creo que tengo la mente tan clara como antes',
'Algunas veces o la mayor parte del tiempo tengo la idea de que los demas estarian mejor si yo muriera']).

conocimiento('Responda las preguntas adecuadamente',
[]).

id_imagen_preg('Nunca o muy pocas veces tuve la dificultad de tomar decisiones','decisiones').
id_imagen_preg('El corazon me late como de costumbre','corazon').
id_imagen_preg('Estoy en desacuerdo con la idea "Me canso aunque no haga nada"','cansancio').
id_imagen_preg('Nunca o algunas veces tengo episodios de llanto o deseos de llorar','llanto').
id_imagen_preg('Nunca o quiza alguna vez senti que los demas estarian mejor si yo muriera','suicidio').
id_imagen_preg('Nunca o quiza alguna vez me costo trabajo dormir por las noches','dormir').
id_imagen_preg('No creo haber dejado de disfrutar las cosas que disfrutaba antes','disfrutar').
id_imagen_preg('Nunca o quiza algunas veces creo que canso aunque no haga nada','cansancio').
id_imagen_preg('Aunque frecuentemente me cuesta trabajo dormirme en la noche, no creo que pase la mayoria del tiempo o en todas las noches','dormir').
id_imagen_preg('Recuerdo tener episodios de llanto o deseos de llorar, pero no todo el tiempo','llanto').
id_imagen_preg('Nunca o quiza solo pocas veces me siento util y necesario','utilidad').
id_imagen_preg('Nunca o solo pocas veces creo que tengo la mente tan clara como antes','clara').
id_imagen_preg('Algunas veces o la mayor parte del tiempo tengo la idea de que los demas estarian mejor si yo muriera','suicidio').





 /* MOTOR DE INFERENCIA: Esta parte del sistema experto se encarga de
 inferir cual es el diagnostico a partir de las preguntas realizadas
 */
:- dynamic conocido/1.

  mostrar_diagnostico(X):-haz_diagnostico(X),clean_scratchpad.
  mostrar_diagnostico(lo_siento_diagnostico_desconocido):-clean_scratchpad .

  haz_diagnostico(Diagnosis):-
                            obten_hipotesis_y_sintomas(Diagnosis, ListaDeSintomas),
                            prueba_presencia_de(Diagnosis, ListaDeSintomas).


obten_hipotesis_y_sintomas(Diagnosis, ListaDeSintomas):-
                            conocimiento(Diagnosis, ListaDeSintomas).


prueba_presencia_de(Diagnosis, []).
prueba_presencia_de(Diagnosis, [Head | Tail]):- prueba_verdad_de(Diagnosis, Head),
                                              prueba_presencia_de(Diagnosis, Tail).


prueba_verdad_de(Diagnosis, Sintoma):- conocido(Sintoma).
prueba_verdad_de(Diagnosis, Sintoma):- not(conocido(is_false(Sintoma))),
pregunta_sobre(Diagnosis, Sintoma, Reply), Reply = 'si'.


pregunta_sobre(Diagnosis, Sintoma, Reply):- preguntar(Sintoma,Respuesta),
                          process(Diagnosis, Sintoma, Respuesta, Reply).


process(Diagnosis, Sintoma, si, si):- asserta(conocido(Sintoma)).
process(Diagnosis, Sintoma, no, no):- asserta(conocido(is_false(Sintoma))).


clean_scratchpad:- retract(conocido(X)), fail.
clean_scratchpad.


conocido(_):- fail.

not(X):- X,!,fail.
not(_).
