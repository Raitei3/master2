
(* exercice 3 *)

let x = true;;
x;;


let square x = x*x;;
square 3;;


let f x = 2*x+3;;
f 3;;


let f2 x = 3.0*.(cos(x))**2.0+.1.0;;
f2 4.0;;


let valabs x = 
  if x<0 then -x else x;;


(* exercise 4 *)

let paire x = (function x -> float + function x -> float)/2;;



(* exercice 5 *)

let rec fact n =
  if n<2 then 1  else n*fact (n-1);;
fact 5;;




let newton x =;;




let approx_pi n =
  let rec approx_pi_rec n =
    if(n=0) then 0 else
      let a = approx_pi_rec (n-1) in
      let u = Random.float 1. and v = Random.float 1. in
      if (u*.u+.v*.v<=1.) then (a+4) else a
  in (approx_pi_rec n,n);;

(*

3)

4)

*)


(* exercice 6 *)
