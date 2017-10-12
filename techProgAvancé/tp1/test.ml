
(* exercice 3 *)

(*1)*)
let x = true;;
x;;

(*2)*)
let square x = x*x;;
square 3;;

(*3)*)
let f x = 2*x+3;;
f 3;;

(*4)*)
(* on remarque ici une sintaxe particuliere pour les floats 
ainsi qu'un typage fort de la part du language qui empéche 
les casts automatique des entiers vers les floats. 
Meme les opérateurs sont typés *)

let f2 x = 3.0*.(cos(x))**2.0+.1.0;;
f2 4.0;;



(*5)*)
let valabs x = 
  if x<0 then -x else x;;
valabs (-5);;




(* exercise 4 *)

(* La fonction make_even prend en paramètre une fonction et un entier et retourne une fonction.
On a ici un éxemple de la puissance de la programmation fonctionnel
La fonction f pourrait elle meme etre définit a la volé sans probleme. *)

let make_even f x = (f(x)+f(-x))/2;;
make_even f 3;;



let deriv e f = fun x -> (f(x+e)-f(x-e))/(2*e);;
deriv 1 f 3;;


(* exercice 5 *)

(* on découvre ici comment faire de la récursivité en Ocaml *)
let rec fact n =
  if n<2 then 1  else n*fact (n-1);;
fact 5;;



(* ici on utilise la notion de fonction interne, déclarer a l'aide "let" et "in".
Cela nous donne une fonction récusrsive qui appelle ou non une fonction interne en fonction de n *)

let rec newton x n f =
  if (n == 0) then x else
    let newt = newton x (n-1) f in
    newt - f(newt)/(deriv 1 f(newt));;

newton 2 3 f;;



let approx_pi n =
  let rec approx_pi_rec n =
    if(n=0) then 0 else
      let a = approx_pi_rec (n-1) in
      let u = Random.float 1. and v = Random.float 1. in
      if (u*.u+.v*.v<=1.) then (a+4) else a
  in (approx_pi_rec n,n);;

(*

3)difficile de dire exactement ou ce situe la limite mais si n est trop grand
alors une erreur de dépassement de pile risque de survenir. Cela est un probleme courant
des fonctions récursives. Chaque appel étant empilé sur la pile cette derniere finit par
etre dépassé.

4)Le code C proposé est une fonction récursive Terminal. A la compilation des optimisations
spécifique vont transformé le code en une version itérative. Il n'y aura pas de suite d'appel
de fonction et la pile ne sera pas dépassé.

En C cette optimisation est tout a fait possible. Par éxemple avec gcc -O2 en option.

*)


(* exercice 6 *)

let rec chop k l =
  if k = 0 then l else begin
    match l with
    | x::t -> chop (k-1) t
    | _ -> assert false
  end
;;

let stable_sort l func =                  (*on ajoute une fonction en paramètre pour gérer les tris*)
  let rec rev_merge l1 l2 accu =
    match l1, l2 with
    | [], l2 -> List.rev_append l2 accu
    | l1, [] -> List.rev_append l1 accu
    | h1::t1, h2::t2 ->
        if (func(h2 h1))                   (* on apelle cette fonction*)
        then rev_merge t1 l2 (h1::accu)
        else rev_merge l1 t2 (h2::accu)
  in
  let rec rev_merge_rev l1 l2 accu =
    match l1, l2 with
    | [], l2 -> List.rev_append l2 accu
    | l1, [] -> List.rev_append l1 accu
    | h1::t1, h2::t2 ->
        if (func(h2 h1))
        then rev_merge_rev t1 l2 (h1::accu)
        else rev_merge_rev l1 t2 (h2::accu)
  in
  let rec sort n l =
    match n, l with
    | 2, x1 :: x2 :: _ ->
       if (func(x2 x1)) then [x1; x2] else [x2; x1]  (* et on répéte l'appel a toute les comparaisons*)
    | 3, x1 :: x2 :: x3 :: _ ->
       if (func(x2 x1))then begin
         if (func(x3 x2)) then [x1; x2; x3]
         else if (func(x3 x1))then [x1; x3; x2]
         else [x3; x1; x2]
       end else begin
         if  (func(x3 x1))then [x2; x1; x3]
         else if  (func(x3 x2))then [x2; x3; x1]
         else [x3; x2; x1]
       end
    | n, l ->
       let n1 = n asr 1 in
       let n2 = n - n1 in
       let l2 = chop n1 l in
       let s1 = rev_sort n1 l in
       let s2 = rev_sort n2 l2 in
       rev_merge_rev s1 s2 []
  and rev_sort n l =
    match n, l with
    | 2, x1 :: x2 :: _ ->
       if (func(x1 x2)) then [x1; x2] else [x2; x1]
    | 3, x1 :: x2 :: x3 :: _ ->
       if  (func(x1 x2)) then begin
         if  (func(x2 x3))then [x1; x2; x3]
         else if  (func(x1 x3)) then [x1; x3; x2]
         else [x3; x1; x2]
       end else begin
         if (func(x1 x3))then [x2; x1; x3]
         else if (func(x2 x3)) then [x2; x3; x1]
         else [x3; x2; x1]
       end
    | n, l ->
       let n1 = n asr 1 in
       let n2 = n - n1 in
       let l2 = chop n1 l in
       let s1 = sort n1 l in
       let s2 = sort n2 l2 in
       rev_merge s1 s2 []
  in
  let len = List.length l in
  if len < 2 then l else sort len l
;;

let decroissant x y =
  if x<=y then true else false ;;

stable_sort [4;2;5;3];;
stable_sort ["mauve";"bleu";"blanc";"carmin"];;
