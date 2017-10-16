(* Exercice 1 *)


(* 1) *)
let pi = 3.1415;;
let rot_gen pi (x,y,ang) = 
  let newx = x*.cos(ang*.pi) +. y*.sin(ang*.pi) in
  let newy = x*.sin(ang*.pi) -. y*.cos(ang*.pi) in (newx,newy);;
let rot = (rot_gen pi);;
let pi = "troispointquatorze";;
rot (1.,0.,1.);;
 
  (* le resultat est bon car le résultat de rot_gen avec le parametre pi = 3.1415 c'est retrouver capturer dans rot *)

  (* 2) *)

  
